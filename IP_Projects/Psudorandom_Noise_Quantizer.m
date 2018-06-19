clc;
clear all;
close all;
 
orignal_Img=imread('D:\STUDY\DIP\img_lib\cameraman.bmp')
Img = double(orignal_Img);
subplot(2,2,1);
imshow(orignal_Img);
title('Actual image');
 
Y=5;   
 
for p = 1:3;
PSUDO = (-Y)+(2*Y).*rand(256,'double');
N_img = Img + PSUDO;
Bits = 3;
M = 2 ^ Bits;
 
Mini = min(min(N_img));
Maxi = max(max(N_img));
 
ci = (Maxi - Mini)/(M);
 
Tk(1) = Mini;
 
for a=1:(M)
Tk(a+1)=Tk(a)+ci;
end
for a=1:(M)
Rk(a)=Tk(a)+(ci/2);
end
for a=1:256
for b=1:256
for k=1:(M)
if N_img(a,b)<Tk(k+1) && N_img(a,b)>=Tk(k)
x1_img(a,b)=Rk(k);
end
end
end
end
x_1 = x1_img - PSUDO;
x_1 = round(x_1);
 
MSE = sum(sum(power((Img-x_1),2)))/(256^2);
disp(MSE);
 
PSNR = 10*log10((255^2)/MSE);
disp(PSNR);
 
x2_img=uint8(x_1);
 
subplot(2,2,p+1);
imshow(x2_img);
title(['Pseudorandom Image ',num2str(Y)]);
 
Y=Y+10;
end     
