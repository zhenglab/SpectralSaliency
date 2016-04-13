function benchAUC_shuffled()
InputFixationMap = './FixationMaps/';
InputSaliencyMap = './SaliencyMaps/';
OutputResults = './Results/AUC_shuffled/';
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
        %% CVBIOUC
        allNegFix = cell(imgNum, 1);
        for curImgNum = 1:imgNum
            eval(['load ', strcat(InputFixationMap, idsFixationMap(curImgNum+2, 1).name)]);
            [rows, cols] = find(fixLocs);
            curFix = [rows cols];
            curCenter = round(size(fixLocs)/2);
	        allNegFix{curImgNum} = bsxfun(@minus, curFix, curCenter);
        end
        %% END CVBIOUC
        series=regexp(OutputResults, '/');
        DatasetsName=OutputResults((series(end-1)+1):(series(end)-1));
        DatasetsTxt = fopen(strcat(OutputResults, 'AUC_shuffled-', DatasetsName, '.txt'), 'w');
        fprintf(DatasetsTxt, '%s\t%s\n', 'Model', 'AUC_shuffled');
        subidsSaliencyMap = dir(InputSaliencyMap);
        for curAlgNum = 1:length(subidsSaliencyMap)
            if subidsSaliencyMap(curAlgNum, 1).name(1)=='.'
                continue;
            end
            fprintf(DatasetsTxt, '%s\t', subidsSaliencyMap(curAlgNum, 1).name);
            outFileName = strcat(OutputResults, subidsSaliencyMap(curAlgNum, 1).name, '.mat');
            subsubidsSaliencyMap = dir(strcat(InputSaliencyMap, subidsSaliencyMap(curAlgNum, 1).name, '/'));
            
            if length(subsubidsSaliencyMap) == length(idsFixationMap)
                AUC_shuffled_score = cell(1, imgNum);
                tmpNum = 1;
                for curImgNum = 1:length(subsubidsSaliencyMap)
                    if subsubidsSaliencyMap(curImgNum, 1).name(1)=='.'
                        continue;
                    end
                    [pathstrFixationMap, nameFixationMap, extFixationMap] = fileparts(strcat(InputFixationMap, idsFixationMap(curImgNum, 1).name));
                    [pathstrSaliencyMap, nameSaliencyMap, extSaliencyMap] = fileparts(strcat(InputSaliencyMap, subidsSaliencyMap(curAlgNum, 1).name, '/', subsubidsSaliencyMap(curImgNum, 1).name));
                    if strcmp(nameFixationMap, nameSaliencyMap)
                        curSaliencyMap = double(imread(strcat(InputSaliencyMap, subidsSaliencyMap(curAlgNum, 1).name, '/', subsubidsSaliencyMap(curImgNum, 1).name)));
                        eval(['load ', strcat(InputFixationMap, idsFixationMap(curImgNum, 1).name)]);
                        %% CVBIOUC
                        negFixInd = 1:imgNum;
                        negFixInd(curImgNum-2) = [];
                        negFix = bsxfun(@plus, cell2mat(allNegFix(negFixInd)), round(size(fixLocs)/2));
                        offFixInd = negFix(:,1)<1 | negFix(:,2)<1 | negFix(:,1)>size(fixLocs,1) | negFix(:,2)>size(fixLocs,2);
                        negFix(offFixInd, :) = [];
                        otherMap = zeros(size(fixLocs));
                        [m, n] = size(negFix);
                        for j = 1:m
                            x = negFix(j, 1);
                            y = negFix(j, 2);
                            otherMap(x, y) = 1;
                        end
                        %% END CVBIOUC
                        curAUC_shuffled_score = AUC_shuffled(curSaliencyMap, fixLocs, otherMap);
                        AUC_shuffled_score{tmpNum} = curAUC_shuffled_score;
                        tmpNum = tmpNum+1;
                    else
                        error('The name of FixationMap and SaliencyMap must be the same.');
                    end
                end
                AUC_shuffled_score = mean(cell2mat(AUC_shuffled_score), 2);
                saveAUC_shuffled_score = strcat('AUC_shuffled', '_', subidsSaliencyMap(curAlgNum).name);
                eval([saveAUC_shuffled_score, '=', 'AUC_shuffled_score']);
                
                save(outFileName, saveAUC_shuffled_score);
                fprintf(DatasetsTxt, '%f\n', AUC_shuffled_score);
            else
                error('The number of saliency maps and the number of fixation maps must be the same.');
            end
        end
        break;
    end
end