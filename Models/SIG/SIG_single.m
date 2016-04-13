%function SMresult=SIG_single(imgfile)
clear
clc
tic
labMap = signatureSal('001.jpg');
SMresult=labMap;
toc