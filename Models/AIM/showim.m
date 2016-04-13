function showim(inimage)

inimage = inimage - min(min(inimage));
inimage = inimage./max(max(inimage));

imshow(inimage)
%colormap(jet)