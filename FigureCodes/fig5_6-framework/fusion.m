map1=imread('./test/SalMap27_1.jpg');
map2=imread('./test/SalMap27_2.jpg');
map3=imread('./test/SalMap27_3.jpg');
map4=imread('./test/SalMap27_4.jpg');
map5=imread('./test/SalMap27_5.jpg');
map=map1.*0.2+map2.*0.2+map3.*0.2+map4.*0.2+map5.*0.2;
imshow(map);
imwrite (SalMap,strcat('./test/map/','SalMap_',num2str(1),'.jpg'));