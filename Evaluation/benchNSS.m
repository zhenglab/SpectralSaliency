function benchNSS()
InputFixationMap = './FixationMaps/';
InputSaliencyMap = './SaliencyMaps/';
OutputResults = './Results/NSS/';
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
        series=regexp(OutputResults, '/');
        DatasetsName=OutputResults((series(end-1)+1):(series(end)-1));
        DatasetsTxt = fopen(strcat(OutputResults, 'NSS-', DatasetsName, '.txt'), 'w');
        fprintf(DatasetsTxt, '%s\t%s\n', 'Model', 'NSS');
        subidsSaliencyMap = dir(InputSaliencyMap);
        for curAlgNum = 1:length(subidsSaliencyMap)
            if subidsSaliencyMap(curAlgNum, 1).name(1)=='.'
                continue;
            end
            fprintf(DatasetsTxt, '%s\t', subidsSaliencyMap(curAlgNum, 1).name);
            outFileName = strcat(OutputResults, subidsSaliencyMap(curAlgNum, 1).name, '.mat');
            subsubidsSaliencyMap = dir(strcat(InputSaliencyMap, subidsSaliencyMap(curAlgNum, 1).name, '/'));
            
            if length(subsubidsSaliencyMap) == length(idsFixationMap)
                NSSscore = cell(1, imgNum);
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
                        curNSSscore = NSS(curSaliencyMap, fixLocs);
                        NSSscore{tmpNum} = curNSSscore;
                        tmpNum = tmpNum+1;
                    else
                        error('The name of FixationMap and SaliencyMap must be the same.');
                    end
                end
                NSSscore = mean(cell2mat(NSSscore), 2);
                saveNSSscore = strcat('NSS', '_', subidsSaliencyMap(curAlgNum).name);
                eval([saveNSSscore, '=', 'NSSscore']);
                
                save(outFileName, saveNSSscore);
                fprintf(DatasetsTxt, '%f\n', NSSscore);
            else
                error('The number of saliency maps and the number of fixation maps must be the same.');
            end
        end
        break;
    end
end