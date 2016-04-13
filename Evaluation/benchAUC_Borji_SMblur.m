function benchAUC_Borji_SMblur()
InputFixationMap = './FixationMaps/';
InputSaliencyMap = './SaliencyMaps/';
OutputResults = './Results/AUC_Borji_SMblur/';
traverse(InputFixationMap, InputSaliencyMap, OutputResults)

function traverse(InputFixationMap, InputSaliencyMap, OutputResults)
idsFixationMap = dir(InputFixationMap);
for i = 1:length(idsFixationMap)
    if idsFixationMap(i, 1).name(1)=='.'
        continue;
    end
    if idsFixationMap(i, 1).isdir==1
        if ~isdir(strcat(OutputResults, idsFixationMap(i, 1).name, '/'))
            mkdir(strcat(OutputResults, idsFixationMap(i, 1).name, '/'));
        end
        traverse(strcat(InputFixationMap, idsFixationMap(i, 1).name, '/'), strcat(InputSaliencyMap, idsFixationMap(i, 1).name, '/'), strcat(OutputResults, idsFixationMap(i, 1).name, '/'));
    else
        %% compute the number of images in the dataset
        imgNum = length(idsFixationMap)-2;
        %%
        subidsSaliencyMap = dir(InputSaliencyMap);
        for curAlgNum = 1:length(subidsSaliencyMap)
            if subidsSaliencyMap(curAlgNum, 1).name(1)=='.'
                continue;
            end
            outFileName = strcat(OutputResults, subidsSaliencyMap(curAlgNum, 1).name, '.mat');
            subsubidsSaliencyMap = dir(strcat(InputSaliencyMap, subidsSaliencyMap(curAlgNum, 1).name, '/'));
            
            if length(subsubidsSaliencyMap) == length(idsFixationMap)
                sigmaList = 0:0.01:0.12;
                sigmaLen = length(sigmaList);
                AUC_Borji_SMblur_score = zeros(sigmaLen, imgNum);
                tmpNum = 1;
                for curImgNum = 1:length(subsubidsSaliencyMap)
                    if subsubidsSaliencyMap(curImgNum, 1).name(1)=='.'
                        continue;
                    end
                    [pathstrFixationMap, nameFixationMap, extFixationMap] = fileparts(strcat(InputFixationMap, idsFixationMap(curImgNum, 1).name));
                    [pathstrSaliencyMap, nameSaliencyMap, extSaliencyMap] = fileparts(strcat(InputSaliencyMap, subidsSaliencyMap(curAlgNum, 1).name, '/', subsubidsSaliencyMap(curImgNum, 1).name));
                    if strcmp(nameFixationMap, nameSaliencyMap)
                        rawSMap = double(imread(strcat(InputSaliencyMap, subidsSaliencyMap(curAlgNum, 1).name, '/', subsubidsSaliencyMap(curImgNum, 1).name)));
                        eval(['load ', strcat(InputFixationMap, idsFixationMap(curImgNum, 1).name)]);
                        rawSMap = imresize(rawSMap, size(fixLocs));
                        kSizeList = norm(size(fixLocs)).*sigmaList;
                        kNum = length(kSizeList);
                        tmpAUC = zeros(kNum, 1);
                        for curK = 1:kNum
                            kSize = kSizeList(curK);
                            if kSize==0
                                smoothSMap = rawSMap;
                            else
                                curH = fspecial('gaussian', round([kSize, kSize]*5), kSize);	% construct blur kernel
                                smoothSMap = imfilter(rawSMap, curH);
                            end
                            tmpAUC(curK) = AUC_Borji(smoothSMap, fixLocs);
                        end
                        AUC_Borji_SMblur_score(:, tmpNum) = tmpAUC;
                        tmpNum = tmpNum+1;
                    else
                        error('The name of FixationMap and SaliencyMap must be the same.');
                    end
                end
                AUC_Borji_SMblur_score = mean(AUC_Borji_SMblur_score, 2);
                saveAUC_Borji_SMblur_score = strcat('AUC_Borji_SMblur', '_', subidsSaliencyMap(curAlgNum).name);
                eval([saveAUC_Borji_SMblur_score, '=', 'AUC_Borji_SMblur_score']);
                
                save(outFileName, saveAUC_Borji_SMblur_score, 'sigmaList');
            else
                error('The number of saliency maps and the number of fixation maps must be the same.');
            end
        end
        break;
    end
end