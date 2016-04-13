function drawAUC()
InputResults = './tmp/results/AUC_Borji_SMblur/';
customColor = cell(10,1);

customColor{1, 1} = [1 1 0];%'y' 'yellow'
customColor{2, 1} = [1 0 1];%'m' 'magenta'
customColor{3, 1} = [0 1 1];%'c' 'cyan'
customColor{4, 1} = [1 0 0];%'r' 'red'
customColor{5, 1} = [0 1 0];%'g' 'green'
customColor{6, 1} = [0 0 1];%'b' 'blue'
customColor{7, 1} = [0 0 0];%'k' 'black'
customColor{8, 1} = [0 0.7 1];
customColor{9, 1} = [0.7 0 1];
customColor{10, 1} = [0.5 0.5 0.5];

traverse(InputResults, customColor);

function traverse(InputResults, customColor)
idsResults = dir(InputResults);
for i = 1:length(idsResults)
    if idsResults(i, 1).name(1)=='.'
        continue;
    end
    if idsResults(i, 1).isdir==1
        traverse(strcat(InputResults, idsResults(i, 1).name,'/'), customColor);
    else
        figure;hold on;
        numColor = 1;
        numModel = dir(fullfile(InputResults, '*.mat'));
        modelCell = cell(1, numel(numModel));
        for curMatNum = 3:length(idsResults)
            if strcmp(idsResults(curMatNum, 1).name((end-3):end), '.mat')
                load(strcat(InputResults, idsResults(curMatNum, 1).name));
                [pathstr, name, ext] = fileparts(strcat(InputResults, idsResults(curMatNum, 1).name));
                modelCell{1, numColor}=name;
                lh = plot(recall, precision, 'LineWidth', 2);
                set(lh, 'Color', customColor{numColor, 1});
                numColor = numColor+1;
            else
                continue;
            end
        end
        series = regexp(InputResults, '/');
        titlename = InputResults((series(end-1)+1):(series(end)-1));
        title(titlename, 'FontName', 'Times');
        legend_handle = legend(modelCell);
        set(legend_handle, 'Location', 'SouthWest', 'FontName', 'Times');
        xlabel('Recall', 'FontName', 'Times');
        ylabel('Precision', 'FontName', 'Times');
        set(gca, 'FontName', 'Times');
        set(gcf, 'paperpositionmode', 'auto');
        grid;
        print('-dtiff', '-r1000', [InputResults, strcat('pr-', titlename, '.tif')]);
        break;
    end
end



clear; clc
p = genParams();
load customColor.mat
close all;
%% Prep
setNum = size(p.fixationSets, 1);
algNum = size(p.fixationAlgs, 1);


aucScore = zeros(algNum, setNum);

for curSetNum = 1:setNum
	figure(curSetNum); hold on;
	curSetName = p.fixationSets{curSetNum};
	
%% Draw curves
	for curAlgNum = 1:algNum
		curAlgName = p.fixationAlgs{curAlgNum};
		outFileName = sprintf('%s/auc/%s_%s.mat', p.outputDir, curSetName, curAlgName);
		if ~exist(outFileName, 'file')
			error('File not found! %s\n', outFileName);
		end
		load(outFileName, 'allAUC', 'sigmaList');
		lh = plot(sigmaList, allAUC, 'LineWidth', 2);
		set(lh,'Color', customColor(curAlgNum, :));
		set(lh,'LineStyle', customStyle{curAlgNum});
	end
	
% 	legend(upper(p.fixationAlgs));
	grid on;
	
	
%% Draw points
	for curAlgNum = 1:algNum
		curAlgName = p.fixationAlgs{curAlgNum};
		outFileName = sprintf('%s/auc/%s_%s.mat', p.outputDir, curSetName, curAlgName);
		
		load(outFileName, 'allAUC', 'sigmaList');
		[curAUC, optSigma] = max(allAUC);
		aucScore(curAlgNum, curSetNum) = curAUC;
		optSigma = sigmaList(optSigma);
		
		lh = scatter(optSigma, curAUC);
		set(lh,'MarkerFaceColor', customColor(curAlgNum, :));
		set(lh,'MarkerEdgeColor', customColor(curAlgNum, :));
		fprintf('Set %s, alg %s, AUC=%.3f at sigma=%.2f\n', curSetName, curAlgName, curAUC, optSigma);
	end
	
	title(sprintf('AUC Score on %s dataset', upper(curSetName)), 'FontSize', 12);
	xlabel( sprintf('Blur Width\n(STD of Gaussian kernel in image widths)') , 'FontSize', 11);
	ylabel( sprintf('AUC Score\n(averaged across all images)') , 'FontSize', 11);
	
	hold off;
	
	%% print to image files (quite slow)
	paperPosition=[0 0 7.2 6];
	set(gcf,'PaperUnits','inches','PaperPosition',paperPosition)
	fileName = sprintf('%s/figures/AUC%s', p.outputDir, curSetName);
% 	print(gcf,'-dpng', sprintf('%s.png', fileName));
	print(gcf,'-depsc2', sprintf('%s.eps', fileName));
end