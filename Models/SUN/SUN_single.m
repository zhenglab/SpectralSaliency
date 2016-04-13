%function SMresult = SUN_single(imgfile)
%  imgfile='001.jpg';
clear
clc
tic
sunMap = saliencyimage('001.jpg');
SMresult = mat2gray(sunMap);
toc