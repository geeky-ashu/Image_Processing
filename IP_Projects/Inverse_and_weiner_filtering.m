clc;
close all ;
clear all ;
 
Img = double(imread('D:\STUDY\DIP\img_lib\lena512.bmp'));
[row col] = size(Img);
inv_F1 = fft2(Img);
[u,v]=meshgrid(1:row,1:col); 
 
%Blurring functions.
BF_1 = exp(-0.0025*(u.^2+v.^2).^(5/6));
BF_2 = exp(-0.001*(u.^2+v.^2).^(5/6));
BF_3 = exp(-0.00025*(u.^2+v.^2).^(5/6));
 
%Noise Function
Noise = randn(row,col);
Noise_1 = fft2(Noise);
 
%Blurred images. 
Blur_1 = inv_F1.*BF_1;
Blur_2 = inv_F1.*BF_2;
Blur_3 = inv_F1.*BF_3;
G_1 = Blur_1 + Noise_1;
G_2 = Blur_2 + Noise_1;
G_3 = Blur_3 + Noise_1;
 
%Blurred and Noisy image
Img_Noise1 = abs(ifft2(Blur_1));
Img_Noise2 = abs(ifft2(Blur_2));
Img_Noise3 = abs(ifft2(Blur_3));
subplot(2,2,1);imshow(uint8(Img_Noise1));title(' Blurred Image,K=0.0025')
subplot(2,2,2);imshow(uint8(Img_Noise2));title(' Blurred Image,K=0.001')
subplot(2,2,3);imshow(uint8(Img_Noise3));title(' Blurred Image,K=0.000025')
 
%Inverse filtering
Inv_Filter_1 = (1./BF_1);
Inv_Filter_2 = (1./BF_2);
Inv_Filter_3 = (1./BF_3);
for a=1:row
for b=1:col
if Inv_Filter_1(a,b)>=100
        Inv_Filter_1(a,b)=0; 
end
if Inv_Filter_2(a,b)>=100
        Inv_Filter_2(a,b)=0;
end
if Inv_Filter_3(a,b)>=100
        Inv_Filter_3(a,b)=0;
end
end
end
 
 
Inv_g1 = abs( ifft2(G_1.*Inv_Filter_1) );
Inv_g2 = abs( ifft2(G_2.*Inv_Filter_2) );
Inv_g3 = abs( ifft2(G_3.*Inv_Filter_3) );
figure;
subplot(2,3,1);imshow(uint8(Inv_g1));title('Inverse Filtered ,K=0.0025')
subplot(2,3,2);imshow(uint8(Inv_g2));title('Inverse Filtered ,K=0.001')
subplot(2,3,3);imshow(uint8(Inv_g3));title('Inverse Filtered ,K=0.000025')
J1 = abs( ifft2(G_1));
J2 = abs( ifft2(G_2));
J3 = abs( ifft2(G_3));
 
% Weiner Filtering
WF_J1 = wiener2(J1,[3 3],Noise); 
WF_J2 = wiener2(J2,[3 3],Noise);
WF_J3 = wiener2(J3,[3 3],Noise);
subplot(2,3,4);imagesc(uint8(WF_J1));title('Weiner Filtered ,K=0.0025')
subplot(2,3,5);imagesc(uint8(WF_J2));title('Weiner Filtered ,K=0.001')
subplot(2,3,6);imagesc(uint8(WF_J3));title('Weiner Filtered ,K=0.000025')
