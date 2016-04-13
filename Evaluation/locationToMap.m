clear
clc
load imgsalSize.mat;
load imgsalFix.mat;
imgNum = length(fixCell);
%imgsal = cell(1, imgNum);
for i = 1:imgNum
    hight = sizeData(i, 1);
    width = sizeData(i, 2);
    fixLocs = zeros(hight, width);
    fixations = fixCell{i, 1};
    fixationLocation = round(fixations(:, 1:2));
    validPos = fixationLocation(:,1)>0 & fixationLocation(:,2)>0 & fixationLocation(:,1)<=hight & fixationLocation(:,2)<=width;
    fixationLocation = fixationLocation(validPos, :);
    [m, n] = size(fixationLocation);
    for j = 1:m
       x = fixationLocation(j, 1);
       y = fixationLocation(j, 2);
       fixLocs(x, y) = 1;
    end
    %imgsal{1, i} = fixLocs;
    eval(['save ', strcat('./imgsal/', num2str(i), '.mat'), ' fixLocs'])
end
%save judd judd -v7.3