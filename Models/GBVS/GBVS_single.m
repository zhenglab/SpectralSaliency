%function SMresult=GBVS_single(imgfile)
clear
clc
tic
s = gbvs('001.jpg');
SMresult=s.master_map_resized;
toc