clc;
clear;
close all;
%% Set path
rootInfo = what;root = rootInfo.path;root=strcat(root,'/functions/'); addpath(root)
%% Initializtion 
param=callHFTParams;
%% Compute saliency for each image
%for q=1%batch processing style using loop, for example q=1:30
 %disp(q)
%% Load image

imgDir='./BenchmarkIMAGES/';
ids=dir(fullfile((imgDir),'*.jpg'));

for i=1:numel(ids)
     imgfile=fullfile(imgDir,strcat(i,ids(i).name(1:end)));
     img=imread(imgfile);
     inImgd=double(img); 
[p1,p2,p3]=size(inImgd);

inImg1 = imresize(inImgd, [256, 256], 'bilinear');

%% Compute input feature maps
r = inImg(:,:,1);g = inImg(:,:,2);b = inImg(:,:,3);   
I = mean(inImgd,3);
%I=max(max(r,g),b);
R = r-(g+b)/2;G = g-(r+b)/2;B = b-(r+g)/2;Y = (r+g)/2-abs(r-g)/2-b;Y(Y<0) = 0;
RG = double(R - G);BY =double(B - Y);

%% Compute the Hypercomplex representation
f = quaternion(0.25*RG, 0.25*BY, 0.5*I);  % the default weigthed for each feature map is 0.25 0.25 0.5
% If we consider the Information noise level for each channel, we may get a better result
%      Krg=sqrt(INR(RG));Kby=sqrt(INR(BY));Ki=(sqrt(INR(I)));
%      f = convert(quaternion((Krg*1)*RG,(Kby*1)*BY,2*(Ki*1)*I),'double');
%% Compute the Scale space in frequency domain
[M,N]=size(r);S=MSQF(inImg1,f,M,N);   %%%
%% Find the optimal scale
[H,W,Ch]=size(inImg1.*0.5);
SalMap=mat2gray(S);

sgm=W*param.SmoothingValue;
SalMap = imfilter(SalMap, fspecial('gaussian',[round(4*sgm) round(4*sgm)],sgm));
SalMap = imresize(SalMap, [p1,p2], 'bilinear');
%-------------
if param.setCenterBias == 1
SalMap=CenterBias(SalMap,param.CenterBiasValue);
end

SalMap=mat2gray(SalMap);
%subplot(3,8,[4 5 12 13])
subplot(121);
imshow(inImg);
title('The original image')
subplot(122);
imshow(SalMap,[])
%imshow(heatmap_overlay( SalMap  , SalMap ));
title('The Saliency Map')
end
     
     
     