clc;
clear all;
close all;
 
Img = fopen('D:\STUDY\DIP\img_lib\girl256color.raw','r');
Img_Ip = fread(Img);
 
RED = reshape(Img_Ip(1:3:length(Img_Ip)),256,256)';
GREEN = reshape(Img_Ip(2:3:length(Img_Ip)),256,256)';
BLUE = reshape(Img_Ip(3:3:length(Img_Ip)),256,256)';
 
%Input Image
I(:,:,1) = RED;
I(:,:,2) = GREEN;
I(:,:,3) = BLUE;
 
figure(1);
image(uint8(I));
title('Reconstructed Image');
 
figure(2);
subplot(3,3,1);
image(uint8(RED));
title('Red');
subplot(3,3,2);
 
image(uint8(GREEN));
title('Green');
 
subplot(3,3,3);
image(uint8(BLUE));
title('Blue');
 
%Y U V decompositions
Y = RED*0.299 + GREEN*0.587 + BLUE*0.114;
U = RED*-0.147 + GREEN*-0.289 + BLUE*0.436;
V = RED*0.615 + GREEN*-0.515 + BLUE*-0.1;
 
subplot(3,3,4);
image(uint8(Y));
title('y');
 
subplot(3,3,5);
image(uint8(U));
title('u');
 
subplot(3,3,6);
image(uint8(V));
title('v');
 
%y Cb Cr decompositions
Re_yd =RED*0.257 + GREEN*0.504 + BLUE*0.098 +16;
Re_cb = RED*-0.148 + GREEN*-0.291 + BLUE*0.439+128;
Re_cr = RED*0.439 + GREEN*-0.368 + BLUE*-0.071+128;
 
subplot(3,3,7);
image(uint8(Re_yd));
title('yd');
 
subplot(3,3,8);
image(uint8(Re_cb));
title('cb');
 
subplot(3,3,9);
image(uint8(Re_cr));
title('cr')

