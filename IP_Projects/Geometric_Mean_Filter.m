clc;
clear all ;
close all ;
 
%Original image
Img = double(imread('D:\STUDY\DIP\img_lib\lena512.bmp'));
[Row Column] = size(Img);
Input_Image_Fourier = fft2(Img);
[a,b] = meshgrid(1:Row,1:Column); 
 
%Blur Function.
Blur_Funct_1 = exp(-0.0025*(a.^2+b.^2).^(5/6));
Blur_Funct_2 = exp(-0.001*(a.^2+b.^2).^(5/6));
Blur_Funct_3 = exp(-0.00025*(a.^2+b.^2).^(5/6));
 
%Noise
Noise = randn(Row,Column);
Noise_Fourier = fft2(Noise);
 
%Blurred images. 
Blurred_Img_1 = Input_Image_Fourier.*Blur_Funct_1;
Blurred_Img_2 = Input_Image_Fourier.*Blur_Funct_2;
Blurred_Img_3 = Input_Image_Fourier.*Blur_Funct_3;
 
%Blurred and Noisy image
Total_Distortion1 = Blurred_Img_1 + Noise_Fourier;
Total_Distortion2 = Blurred_Img_2 + Noise_Fourier;
Total_Distortion3 = Blurred_Img_3 + Noise_Fourier;
 
Img_1 = abs(ifft2(Blurred_Img_1));
Img_2 = abs(ifft2(Blurred_Img_2));
Img_3 = abs(ifft2(Blurred_Img_3));
 
subplot(2,3,1);
imshow(uint8(Img_1));
title(' Blurred Image K=0.0025')
 
subplot(2,3,2);
imshow(uint8(Img_2));
title(' Blurred Image K=0.001')
 
subplot(2,3,3);
imshow(uint8(Img_3));
title(' Blurred Image K=0.000025')
 
Noisy_Image_Recovered1 = abs( ifft2(Total_Distortion1));
Noisy_Image_Recovered2 = abs( ifft2(Total_Distortion2));
Noisy_Image_Recovered3 = abs( ifft2(Total_Distortion3));
 
Weiner_Filt_1 = wiener2(Noisy_Image_Recovered1,[3 3],Noise); 
Weiner_Filt_2 = wiener2(Noisy_Image_Recovered2,[3 3],Noise);
Weiner_Filt_3 = wiener2(Noisy_Image_Recovered3,[3 3],Noise);
 
 
%Geometric Mean filter
s=1/2;
 
Funct_1=((Blur_Funct_1^s).*((Weiner_Filt_1).^(1-s)));
Funct_1_a=Total_Distortion1.*Funct_1;
Final_Image_1=ifft2(ifftshift(Funct_1_a));
subplot(2,3,4);
imagesc((abs(Final_Image_1)));
title(' S=1/2,K=0.0025');
 
Funct_1_1=((Blur_Funct_2^s).*((Weiner_Filt_2).^(1-s)));
Funct_1_b=Total_Distortion2.*Funct_1_1;
Final_Image_2=ifft2(ifftshift(Funct_1_b));
subplot(2,3,5);
imagesc((abs(Final_Image_2)));
title(' S=1/2,K=0.001');
 
Funct_1_2=((Blur_Funct_3^s).*((Weiner_Filt_3).^(1-s)));
Funct_1_c=Total_Distortion3.*Funct_1_2;
Final_Image_3=ifft2(ifftshift(Funct_1_c));
subplot(2,3,6);
imagesc((abs(Final_Image_3)));
title(' S=1/2,K=0.000025');
 
figure;
s=1/4;
Funct_2=((Blur_Funct_1^s).*((Weiner_Filt_1).^(1-s)));
Funct_2_a=Total_Distortion1.*Funct_2;
Final_Image_4=ifft2(ifftshift(Funct_2_a));
subplot(2,2,1);
imagesc((abs(Final_Image_4)));
colormap(gray);
title(' S=1/4,K=0.0025');
 
Function2_1=((Blur_Funct_2^s).*((Weiner_Filt_2).^(1-s)));
Funct_2_b=Total_Distortion2.*Function2_1;
Final_Image_5=ifft2(ifftshift(Funct_2_b));
subplot(2,2,2);
imagesc((abs(Final_Image_5)));
colormap(gray);
title(' S=1/4,K=0.001');
 
Funct_2_2=((Blur_Funct_3^s).*((Weiner_Filt_3).^(1-s)));
Funct_2_c=Total_Distortion3.*Funct_2_2;
Final_Image_6=ifft2(ifftshift(Funct_2_c));
subplot(2,2,3);
imagesc((abs(Final_Image_6)));
colormap(gray);
title(' S=1/4,K=0.000025');
 
figure;
s=3/4;
Funct_3=((Blur_Funct_1^s).*((Weiner_Filt_1).^(1-s)));
Funct_3_a=Total_Distortion1.*Funct_3;
Final_Image_7=ifft2(ifftshift(Funct_3_a));
subplot(2,2,1);
imagesc((abs(Final_Image_7)));
colormap(gray);
title(' S=3/4,K=0.0025');
 
Funct_3_1=((Blur_Funct_2^s).*((Weiner_Filt_2).^(1-s)));
Funct_3_b=Total_Distortion2.*Funct_3_1;
Final_Image_8=ifft2(ifftshift(Funct_3_b));
subplot(2,2,2);
imagesc((abs(Final_Image_8)));
colormap(gray);
title(' S=3/4,K=0.001');
 
Funct_3_2=((Blur_Funct_3^s).*((Weiner_Filt_3).^(1-s)));
Funct_3_c=Total_Distortion3.*Funct_3_2;
Final_Image_9=ifft2(ifftshift(Funct_3_c));
subplot(2,2,3);
imagesc((abs(Final_Image_9)));
colormap(gray);
title(' S=3/4,K=0.000025');
