clc
close all
clear all
 
IP_Image = imread('D:\STUDY\DIP\img_lib\elaine.512.tiff');
subplot(1,2,1);
imshow(IP_Image);
title('Orignal Image');
 
% Histogram of Image (Part 1)
subplot(1,2,2);
imhist(IP_Image);
title('Histogram of orignal image');
 
% Local Histogram Equalization (Part 2)
Lcl_Eq_2 = adapthisteq(IP_Image,'clipLimit',0.02,'Distribution','rayleigh');
figure;
subplot(1,2,1);
imshow(Lcl_Eq_2);
title('Image after Local Histogram equalization');
subplot(1,2,2);
imhist(Lcl_Eq_2);
title('histogram of Local Histtogram Equalization');
 
% Global Histogram Equalization (Part 3)
Global_Eq = histeq(IP_Image);
figure;
subplot(1,2,1);
imshow(Global_Eq);
title('Image after Global Histogram Equalization');
subplot(1,2,2);
imhist(Global_Eq);
title('histogram of Global Histogram Equalization');
 
% (Part 4)
ln = linspace(0,1,256);
Histogram = histeq(IP_Image,ln);
figure;
subplot(1,2,1);
imshow(Histogram);
title('Image after Direct Histogram Specification');
subplot(1,2,2);
imhist(Histogram);
title('Histogram');
plot(ln);
title('Desired Histogram Shape'),ylim([0 1]), xlim([1 256])
 
 
% For Pout Image
Ip_Image_2 = imread('pout.tif');
figure;
subplot(1,2,1);
imshow(Ip_Image_2);
title('pout.tif');
subplot(1,2,2);
imhist(Ip_Image_2);
title('Histogram of input image(2)');
 
Lcl_Eq_2 = adapthisteq(Ip_Image_2,'clipLimit',0.02,'Distribution','rayleigh');
figure;
subplot(1,2,1);
imshow(Lcl_Eq_2);
title('Image after Local Histogram Equalization');
subplot(1,2,2);
imhist(Lcl_Eq_2);
title('Histogram of Local Histogram Equalization');
 
Global_Equalization2 = histeq(Ip_Image_2);
figure;
subplot(1,2,1);
imshow(Global_Equalization2);
title('Image after Global Histogram Equalization');
subplot(1,2,2);
imhist(Global_Equalization2);
title('Histogram of Global Histogram Equalization');
 
ln=linspace(0,1,256);
Histogram2 = histeq(Ip_Image_2,ln);
figure;
subplot(1,2,1);
imshow(Histogram2);
title('image(2) after direct Histogram specification');
subplot(1,2,2);
imhist(Histogram2);
title('Corresponding histogram')
plot(ln), title('Desired Histogram Shape'),ylim([0 1]), xlim([1 256])
