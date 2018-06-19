clc;
clear all;
close all;
Image= double(imread('D:\STUDY\DIP\img_lib\flowers.bmp'));
figure(1);
imshow('D:\STUDY\DIP\img_lib\flowers.bmp');
title('Orignal Image');
RedColor_component=Image(:,:,1);
GreenColor_component=Image(:,:,2);
BlueColor_component=Image(:,:,3);
figure(2);
subplot(3,3,1);
imshow(uint8(RedColor_component));
title('Red Color Component image');
subplot(3,3,2);
imshow(uint8(GreenColor_component));
title('Green Color Component image');
subplot(3,3,3);
imshow(uint8(BlueColor_component));
title('Blue Color Component image');
Y_Luminance=RedColor_component*0.257 + GreenColor_component*0.504 + BlueColor_component*0.098 +16; 
Cb_Chrominance= RedColor_component*-0.148 + GreenColor_component*-0.291 + BlueColor_component*0.439+128;
Cr_Chrominance= RedColor_component*0.439 + GreenColor_component*-0.368 + BlueColor_component*-0.071+128;
subplot(3,3,4);
imshow(uint8(Y_Luminance));
title('Y Image');
subplot(3,3,5);
imshow(uint8(Cb_Chrominance));
title('Cb Image');
subplot(3,3,6);
imshow(uint8(Cr_Chrominance));
title('Cr Image');
filter=1/8*[1 3 3 1];
for x=1:362
Cb_deci(x,:)=conv(Cb_Chrominance(x,:),filter);
Cr_deci(x,:)=conv(Cr_Chrominance(x,:),filter);
end
%Image downsampling.
Down_Samp_Cb=Cb_Chrominance(:,1:2:500);
Down_Samp_Cr=Cr_Chrominance(:,1:2:500);
%Image upsampling.
up_Samp_Cb=zeros(362,500);
up_Samp_Cr=zeros(362,500);
up_Samp_Cb(:,1:2:500)=Down_Samp_Cb;
up_Samp_Cr(:,1:2:500)=Down_Samp_Cr;
%Image Interpolation,horizontal filtering.
for x=1:362
Cb_up(x,:)=conv(up_Samp_Cb(x,:),filter);
Cr_up(x,:)=conv(up_Samp_Cr(x,:),filter);
end
Cb_up=Cb_up(:,1:500);
Cr_up=Cr_up(:,1:500);
%Image Reconstruction
Red_reconst=1.164*(Y_Luminance-16)+1.596*(Cr_up-128);
Green_reconst=1.164*(Y_Luminance-16)-0.813*(Cr_up-128)- 0.392*(Cb_up-128);
Blue_reconst=1.164*(Y_Luminance-16)+2.017*(Cb_up-128);
subplot(3,3,7);
imshow(uint8(Red_reconst));
title('Reconst Red Image');
subplot(3,3,8);
imshow(uint8(Green_reconst));
title('Reconst Green Image');
subplot(3,3,9);
imshow(uint8(Blue_reconst));
title('Reconst Blue Image')
