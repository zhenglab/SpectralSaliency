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