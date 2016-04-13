%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%   Some psychophysics style examples                        %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%  Comments on use for psychophysical stimuli:               %%%%%%
%%%%%%  There are two points worth mentioning regarding use on    %%%%%%
%%%%%%  psychophysics style stimuli:                              %%%%%% 
%%%%%%  1. The set of cells employed are learned based on ICA     %%%%%%
%%%%%%     as described in [1]. They correspond to oriented Gabor %%%%%%
%%%%%%     like cells, and color opponent cells. Although these   %%%%%%
%%%%%%     share considerable similarity with V1 cells, they are  %%%%%%
%%%%%%     not a perfect match to the color opponency and spatial %%%%%%
%%%%%%     frequency tuning observed cortically and in general    %%%%%%
%%%%%%     offer a greatly simplified functional model of V1.     %%%%%%
%%%%%%                                                            %%%%%%
%%%%%%     That said, they do in general make reasonable          %%%%%%
%%%%%%     predictions, but some caution should be exercised      %%%%%%
%%%%%%     in interpreting results, in particular insofar as      %%%%%%
%%%%%%     determining whether any unexpected results emerge      %%%%%%
%%%%%%     by virtue of an impoverished model of the cells        %%%%%%
%%%%%%     involved, or the underlying theory. In failing to      %%%%%%
%%%%%%     reproduce expected results of an experiment it is      %%%%%%
%%%%%%     more often the former and not the latter that is       %%%%%%
%%%%%%     at fault.                                              %%%%%%
%%%%%%                                                            %%%%%%
%%%%%%  2. Owing to the rather unnatural statistics (as compared  %%%%%%
%%%%%%     with natural images) of these stimuli, the output      %%%%%%
%%%%%%     contrast may be very high (in particular between the   %%%%%%
%%%%%%     target items and background). To examine the relative  %%%%%%
%%%%%%     salience of stimuli, it is often useful to rescale the %%%%%%
%%%%%%     contrast of the output. This is demonstrated in        %%%%%%
%%%%%%     several cases. Note that it is important that within   %%%%%%
%%%%%%     any given "experiment" it is important that any        %%%%%%        
%%%%%%     scaling or contrast adjustment remain the same across  %%%%%%
%%%%%%     examples to avoid misleading results. It is also       %%%%%%
%%%%%%     important to use a large number of bins within the     %%%%%%
%%%%%%     parameters, especially for subtle differences in the   %%%%%%
%%%%%%     stimuli.                                               %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Examples include:
% Example 0: Pop-out vs. serial search with basic features (2s and 5s)
%            Notice that the two doesn't pop-out but the red, diagonal and
%            small 5's do
% Example 1: Other pop-out examples based on orientation, color and spatial
%            frequency
% Example 2: Distractor homogenity in orientation domain 
% Example 3: Distractor homogeneity in chromatic domain
% Example 4: A classic presence/absence asymmetry (+'s vs. -'s)
% Example 5: A background asymmetry of the type described by Rosenholtz

p=10;
% Enables or disables the various examples involved
doexample0=1;
doexample1=1;
doexample2=1;
doexample3=1;
doexample4=1; 
doexample5=1;
 

iptsetpref('ImshowBorder','tight')

if (doexample0 == 1)

    
info1t=AIM('conj1.png');
info2t=AIM('conj2.png');
info3t=AIM('conj3.png');

p=7;
info1 = filter2(fspecial('gaussian',20,7),info1t).^p;
info2 = filter2(fspecial('gaussian',20,7),info2t).^p;
info3 = filter2(fspecial('gaussian',20,7),info3t).^p;
min1 = min(min(info1)); min2 = min(min(info2)); min3 = min(min(info3)); 
max1 = max(max(info1)); max2 = max(max(info2)); max3 = max(max(info3));
minval = min(min(min1,min2),min3);
maxval = max(max(max1,max2),max3);

figure, 
subplot(2,3,1), imshow('conj1.png');
subplot(2,3,2), imshow('conj2.png');
subplot(2,3,3), imshow('conj3.png');
subplot(2,3,4), imshow(info1,[minval maxval])
colormap(jet);
subplot(2,3,5), imshow(info2,[minval maxval])
colormap(jet);
subplot(2,3,6), imshow(info3,[minval maxval])
colormap(jet);
end


if (doexample1 == 1)
p=3;
info2s=AIM('2sand5s.png');
f = figure
subplot(1,2,1)
imshow('2sand5s.png');
subplot(1,2,2)
showim(filter2(fspecial('gaussian',30,15),info2s).^p);
colormap(jet)
end


if (doexample2 == 1)
info2s1=AIM('tdo1.png');
info2s2=AIM('tdo2.png');
info2s3=AIM('tdo3.png');

p=10;
info1 = filter2(fspecial('gaussian',20,7),info2s1).^p;
info2 = filter2(fspecial('gaussian',20,7),info2s2).^p;
info3 = filter2(fspecial('gaussian',20,7),info2s3).^p;


min1 = min(min(info1)); min2 = min(min(info2)); min3 = min(min(info3)); 
max1 = max(max(info1)); max2 = max(max(info2)); max3 = max(max(info3)); 
minval = min(min(min1,min2),min3);
maxval = max(max(max1,max2),max3);

figure
subplot(2,3,1), imshow('tdo1.png');
subplot(2,3,2), imshow('tdo2.png');
subplot(2,3,3), imshow('tdo3.png');
subplot(2,3,4),
imshow(info1,[minval maxval]);
colormap(jet);
subplot(2,3,5)
imshow(info2,[minval maxval]);
colormap(jet);
subplot(2,3,6)
imshow(info3,[minval maxval]);
colormap(jet);
end



if (doexample3 == 1)
info1t=AIM('dds1.png');
info2t=AIM('dds2.png');
info3t=AIM('dds3.png');

p=10;
info1 = filter2(fspecial('gaussian',20,7),info1t).^p;
info2 = filter2(fspecial('gaussian',20,7),info2t).^p;
info3 = filter2(fspecial('gaussian',20,7),info3t).^p;

min1 = min(min(info1)); min2 = min(min(info2)); min3 = min(min(info3)); 
max1 = max(max(info1)); max2 = max(max(info2)); max3 = max(max(info3)); 
minval = min(min(min1,min2),min3);
maxval = max(max(max1,max2),max3);

figure
subplot(2,3,1), imshow('dds1.png');
subplot(2,3,2), imshow('dds2.png');
subplot(2,3,3), imshow('dds3.png');
subplot(2,3,4),
imshow(info1,[minval maxval]);
colormap(jet);
subplot(2,3,5)
imshow(info2,[minval maxval]);
colormap(jet);
subplot(2,3,6)
imshow(info3,[minval maxval]);
colormap(jet);


end


if (doexample4 == 1)
info1=AIM('plusdash.png');
info2=AIM('dashplus.png');
p=2;
info1 = filter2(fspecial('gaussian',20,7),info1).^p;
info2 = filter2(fspecial('gaussian',20,7),info2).^p;
min1 = min(min(info1)); min2 = min(min(info2));
max1 = max(max(info1)); max2 = max(max(info2));

minval = min(min1,min2);
maxval = max(max1,max2);

figure
subplot(2,2,1), imshow('plusdash.png');
subplot(2,2,2), imshow('dashplus.png');
subplot(2,2,3), imshow(info1,[minval maxval])
colormap(jet);
subplot(2,2,4), imshow(info2,[minval maxval])
colormap(jet);
end


if (doexample5 == 1)
    p=8;
info1=AIM('rrca-1.png');
info2=AIM('rrca-2.png');
info3=AIM('rrca-3.png');
info4=AIM('rrca-4.png');

info1 = filter2(fspecial('gaussian',20,7),info1).^p;
info2 = filter2(fspecial('gaussian',20,7),info2).^p;
info3 = filter2(fspecial('gaussian',20,7),info3).^p;
info4 = filter2(fspecial('gaussian',20,7),info4).^p;

min1 = min(min(info1)); min2 = min(min(info2)); min3 = min(min(info3)); min4 = min(min(info4));
max1 = max(max(info1)); max2 = max(max(info2)); max3 = max(max(info3)); max4 = max(max(info4));
minval = min(min(min(min1,min2),min3),min4);
maxval = max(max(max(max1,max2),max3),max4);


figure, 
subplot(2,4,1), imshow('rrca-1.png')
subplot(2,4,2), imshow('rrca-3.png')
subplot(2,4,3), imshow('rrca-2.png')
subplot(2,4,4), imshow('rrca-4.png') 
subplot(2,4,5), imshow(info1,[minval maxval])
colormap(jet);
subplot(2,4,6), imshow(info3,[minval maxval])
colormap(jet);
subplot(2,4,7), imshow(info2,[minval maxval])
colormap(jet);
subplot(2,4,8), imshow(info4,[minval maxval]) 
colormap(jet);
end