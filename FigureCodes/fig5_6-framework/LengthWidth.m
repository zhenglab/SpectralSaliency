function [LW Mid]=LengWidth(img)

% 设定输入图像的个数
%numImgs = 11;


% 读入并显示图像
 img = imread('imgp1883.png');
%imshow(img);
 
% 设定图像通道
% % % paramRGB = default_signature_param;
% % % paramRGB.colorChannels = 'rgb';

% Hou的signature处理
% % % rgbMap = signature( img , paramRGB );
rgbMap = signature( img );
smap = mat2gray( imresize(rgbMap,[size(img,1) size(img,2)]) );
[p1,p2]=size(smap);

% 设定阈值进行二值化
for i=1:p1
    for j=1:p2
        if smap(i,j)>0.5939;
            smap(i,j)=1;
       else
           smap(i,j)=0;
        end
    end
end

%PengZhang=imdilate(smap,ones(25,25));

% 运用最大类间方差法进行阈值化处理
% % % smap=autoThreshold(smap);
% 总最小外接矩形找出显著区域的大致轮廓，并求出轮廓的长度和宽度
bw = smap;
% imshow(bw);
[L n] = bwlabel(bw);
stats = regionprops(L,'Area'); % 区域属性
%figure,imshow(bw);hold on
% figure,imcontour(bw);hold on
num=max(max(L));
LW=zeros(num,2);
for i=1:num;
%  imshow(bw); 
imshow(bw)
[r c]=find(L==i);
[rectx,recty,area,perimeter] = minboundrect(c,r,'a'); % 'a'是按面积算的最小矩形，如果按边长用'p'.
line(rectx,recty,'color','r','LineWidth',3);
% print(gcf,'-painters ','-depsc','-r1000','image');
set(gca,'position',[0,0,1,1]);
set(gcf,'paperpositionmode','auto');
%axis normal;
print('-dbmp','fenkai');
l1=sqrt(((rectx(2,1)-rectx(1,1))^2)+(recty(2,1)-recty(1,1))^2); % l1、l2求出图像的长度和宽度.
l2=sqrt(((rectx(4,1)-rectx(1,1))^2)+(recty(4,1)-recty(1,1))^2);
mx=0.5.*(rectx(1,1)+rectx(3,1));
my=0.5.*(recty(1,1)+recty(3,1));
LW(i,1)=l1;
LW(i,2)=l2;
Mid(i,1)=mx;
Mid(i,2)=my;
end





