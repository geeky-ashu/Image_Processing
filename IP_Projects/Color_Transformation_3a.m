clc;
clear all;
close all;
img_file = fopen('D:\STUDY\DIP\img_lib\girl256color.raw','r');
Img_read = fread(img_file);
Red=Img_read(1:3:length(Img_read));
Green=Img_read(2:3:length(Img_read));
Blue=Img_read(3:3:length(Img_read));
%Converting row vector into a 2D matrix.
Red=(reshape(Red,256,256))';
Green=(reshape(Green,256,256))';
Blue=(reshape(Blue,256,256))';
%Build Y I Q components
Y_Lumi= Red*0.299 + Green*0.587 + Blue*0.114;
I_Chro= Red*0.596 + Green*-0.274 + Blue*-0.322;
Q_Chro= Red*0.211 + Green*-0.523 + Blue*0.312;
figure(1);
subplot(2,3,1);
image(uint8(Y_Lumi));
title('Y-Luminance ');
subplot(2,3,2);
image(uint8(I_Chro));
title('I-Chrominance');
subplot(2,3,3);
image(uint8(Q_Chro));
title('Q-Chrominance');
% Reconstruction of RGB components from Y I Q
recon_R=Y_Lumi+0.956*I_Chro+0.621*Q_Chro;
recon_G=Y_Lumi-0.272*I_Chro-0.647*Q_Chro;
recon_B=Y_Lumi-1.106*I_Chro+1.703*Q_Chro;
subplot(2,3,4);
image(uint8(recon_R));
title('R-Image');
subplot(2,3,5);
image(uint8(recon_G));
title('G-Image');
subplot(2,3,6);
image(uint8(recon_B));
title('B-Image');