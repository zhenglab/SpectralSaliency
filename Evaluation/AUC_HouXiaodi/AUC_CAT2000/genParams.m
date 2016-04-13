function p = genParams()
% Generate environment and user-specific parameters.
%   Xiaodi Hou <xiaodi.hou@gmail.com>, 2014
%   Please email me if you find bugs or have questions.


%% Generate Environment Parameters
p.useGPU = false;	% CUDA gpu required.
p.verbose = true;

%% Generating salObject parameters
p.salObjSets = {'ft'; 'imgsal'; 'pascal'};
p.salObjAlgs = {'sf'; 'gc'; 'pcas'; 'ft'; 'aws'; 'aim'; 'sig'; 'itti'; 'dva'; 'gbvs'; 'sun'};
p.smoothOption = [0;0;0;0;1;1;1;1;1;1;1;0];


p.gtThreshold = 0.5;
p.beta = sqrt(0.3);
p.thNum = 100;
p.thList = linspace(0, 1, p.thNum);


%% Generating fixation parameters
%CVBIOUC% p.fixationSets = {'bruce'; 'cerf'; 'judd'; 'imgsal'; 'pascal'};
p.fixationSets = {'bruce'; 'judd'; 'imgsal'; 'pascal'}; %CVBIOUC%
%CVBIOUC% p.fixationAlgs = {'aws'; 'aim'; 'sig'; 'dva'; 'gbvs'; 'sun'; 'itti'};
p.fixationAlgs = {'AIM'; 'COV'; 'GBVS'; 'HFT'; 'ITTI'; 'PFDN'; 'PQFT'; 'SeR';...
    'SHFT'; 'SHFTnoCenterBias'; 'SIG'; 'SIM'; 'SR'; 'SUN'}; %CVBIOUC%

p.sigmaList = 0:0.01:0.08;
p.sigmaLen = length(p.sigmaList);
p.defaultSigma = 0.04;

%% Directories
p.datasetDir = '../datasets';
p.algMapDir = '../algmaps';
p.outputDir = '../results';

%%
p.salObjSets = p.salObjSets(:);
p.salObjAlgs = p.salObjAlgs(:);

p.fixationSets = p.fixationSets(:);
p.fixationAlgs = p.fixationAlgs(:);

%%
setNum = length(p.salObjSets);
p.salObjSetSize = zeros(setNum, 1);
for curSetNum = 1:setNum
	curSetName = p.salObjSets{curSetNum};
	fileList = dir(sprintf('%s/imgs/%s/*.jpg', p.datasetDir, curSetName));
	p.salObjSetSize(curSetNum) = length(fileList);
end

setNum = length(p.fixationSets);
p.fixationSetSize = zeros(setNum, 1);
for curSetNum = 1:setNum
	curSetName = p.fixationSets{curSetNum};
	%CVBIOUC% fileList = dir(sprintf('%s/imgs/%s/*.jpg', p.datasetDir, curSetName));
    fileList = dir(sprintf('%s/Images/%s/*.jpg', p.datasetDir, curSetName)); %CVBIOUC%
	p.fixationSetSize(curSetNum) = length(fileList);
end

end

