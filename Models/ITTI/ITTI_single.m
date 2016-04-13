%function SMresult=ITTI_single(imgfile)
clear
clc
tic
s = ittikochmap('001.jpg');
SMresult=s.master_map_resized;
toc