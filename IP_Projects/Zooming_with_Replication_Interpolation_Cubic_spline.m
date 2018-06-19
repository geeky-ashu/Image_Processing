clc;
clear all;
Img=imread('D:\STUDY\DIP\img_lib\cameraman.bmp');
subplot(2,3,1);
imshow(Img);
title('Original Image');
[x,y] = size(Img);
R = 2;
Z = uint8(zeros(R*x,R*y));
% Zero interlacing
for x = 1:256
for y = 1:256
Z(R*x,R*y) = Img(x,y);
end
end
% Replication
M = [1 1;1 1];
REP_Img = uint8(conv2(Z,M));
subplot(2,3,2);
imshow(REP_Img);
title('Zoomed image using replication');
% Linear Interpolation
M_2 = conv2(M,M);
N = 0.25.*M_2;
LI_Img = uint8(conv2(Z,N));
subplot(2,3,3);
imshow(LI_Img);
title('Image Zoomed using linear interpolation');
M_3 = conv2(M_2,M);
M_4 = conv2(M_3,M);
M_5 = 0.015625*(M_4);
CS_Img = uint8(conv2(Z,M_5));
subplot(2,3,4);
imshow(CS_Img);
title('zoomed image using cubic spline technique');