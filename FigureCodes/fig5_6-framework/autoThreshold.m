function binaryMap = autoThreshold(I)
%迭代法自动阈值分割
%
%输入：I-要进行自动阈值分割的灰度图像
%输出：binaryMap-分割后的二值图像

thres = 0.5*(double(min(I(:)))+double(max(I(:)))); %初始阈值
done = false; %结束标志
while ~done
    g = I >=thres;
    Tnext = 0.4*(mean(I(g))+mean(I(~g)));
    done = abs(thres-Tnext)<0.5;
    thres = Tnext;
end;

binaryMap = im2bw(I,thres); %二值化