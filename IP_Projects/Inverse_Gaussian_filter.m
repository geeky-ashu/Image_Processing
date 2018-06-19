clc;
clear all;
close all;
 
Input_Img1=double(imread('D:\STUDY\DIP\img_lib\lena512.bmp'));
Input_Img2=double(imread('D:\STUDY\DIP\img_lib\goldhill256.bmp'));
Input_Img3=double(imread('D:\STUDY\DIP\img_lib\girl512.bmp'));
Input_Img4=double(imread('D:\STUDY\DIP\img_lib\boat512.gif'));
 
Var_1=15707;
Var_2=28198;
Var_3=34657;
Var_4=41694;
 
Img_1F=fft2(Input_Img1);
Img_2F=fft2(Input_Img2);
Img_3F=fft2(Input_Img3);
Img_4F=fft2(Input_Img4);
 
New_Img2=zeros(1,128);
for a=1:1:128
for b=1:1:128
New_Img2(a,b)=exp(((a^2)+(b^2))/(2*Var_2));
end
end
 
New_Img1=zeros(1,256);
New_Img3=zeros(1,256);
New_Img4=zeros(1,256);
 
for a=1:1:256
for b=1:1:256
New_Img1(a,b)=exp(((a^2)+(b^2))/(2*Var_1));
New_Img3(a,b)=exp(((a^2)+(b^2))/(2*Var_3));
New_Img4(a,b)=exp(((a^2)+(b^2))/(2*Var_4));
        
if a<=128 && b>128
New_Img2(a,b)=New_Img2(a,257-b);
elseif a>128 && b<=128
New_Img2(a,b)=New_Img2(257-a,b);
elseif a>128 && b>128
New_Img2(a,b)=New_Img2(257-a,257-b);
end
end
end
 
for a=1:1:512
for b=1:1:512
if a<=256 && b>256
New_Img1(a,b)=New_Img1(a,513-b);
New_Img3(a,b)=New_Img3(a,513-b);
New_Img4(a,b)=New_Img4(a,513-b);
            
elseif a>256 && b<=256
New_Img1(a,b)=New_Img1(513-a,b);
New_Img3(a,b)=New_Img3(513-a,b);
N_B(a,b)=New_Img4(513-a,b);
            
elseif a>256 && b>256
New_Img1(a,b)=New_Img1(513-a,513-b);
New_Img3(a,b)=New_Img3(513-a,513-b);
New_Img4(a,b)=New_Img4(513-a,513-b);
end
end
end
 
surf(New_Img1,'EdgeColor','none'); 
colormap(hsv);
shading interp;
alpha(0.7);
axis tight;
grid on;
title('512x512 Mask');
 
figure;
surf(New_Img2,'EdgeColor','none'); 
colormap(hsv);
shading interp;
alpha(0.7);
axis tight;
grid on;
title('256x256 Mask');
 
Img1_f=Img_1F.*New_Img1;
Img2_f=Img_2F.*New_Img2;
Img3_f=Img_3F.*New_Img3;
Img4_f=Img_4F.*New_Img4;
 
Img1_ifft=ifft2(Img1_f);
Img2_ifft=ifft2(Img2_f);
Img3_ifft=ifft2(Img3_f);
Img4_ifft=ifft2(Img4_f);
 
figure;
subplot(1,2,1);imshow(uint8(Input_Img1));title('Actual Image');
subplot(1,2,2);imshow(uint8(Img1_ifft));title('Filtered Image ');
figure;
subplot(1,2,1);imshow(uint8(Input_Img3));title('Actual Image');
subplot(1,2,2);imshow(uint8(Img3_ifft));title('Filtered Image');
figure;
subplot(1,2,1);imshow(uint8(Input_Img2));title('Actual Image');
subplot(1,2,2);imshow(uint8(Img2_ifft));title('Filtered Image');
figure;
subplot(1,2,1);imshow(uint8(Input_Img4));title('Actual Image');
subplot(1,2,2);imshow(uint8(Img4_ifft));title('Filtered Image');
