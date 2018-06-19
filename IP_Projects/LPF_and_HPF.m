
clc;
clear all;
close all;
 
Input_Img = imread('D:\STUDY\DIP\img_lib\girl512.bmp');
[m,n] = size(Input_Img);
figure(1);
imshow(Input_Img);
title('Original Image');
 
Image_Double = im2double(Input_Img);
Img_DFT = fft2(Image_Double);
figure(2);
subplot(1,2,1);
imshow(Img_DFT);
title('Fourier Transform of Original Image');
 
Img_DFT_Shift = log(1 + abs(fftshift(Img_DFT)));
subplot(1,2,2);
imshow(Img_DFT_Shift);
title('Shifted Fourier Transform of Original Image');
 
a = 0:(m-1);
b = 0:(n-1);
i = find(a > m/2);
a(i) = a(i)-m;
j = find(b > n/2);
b(j)=b(j)-n;
[k,l]=meshgrid(b,a);
D=sqrt((k.^2+l.^2));
 
figure(3);
mesh(real(fftshift(D)));
title('D');
 
Image1  = Ideal_Low_Pass_Filter(40,D);
Image2  = Ideal_Low_Pass_Filter(60,D);
 
Image3 = Gaussian_Low_Pass_Filter(16,D);
Image4 = Gaussian_Low_Pass_Filter(24,D);
 
Image5 = Butterworth_Low_Pass_Filter(50,3,D);
Image6 = Butterworth_Low_Pass_Filter(50,4,D);
 
Image7  = Ideal_High_Pass_Filter(30,D);
Image8  = Ideal_High_Pass_Filter(50,D);
 
Image9 = Gaussian_High_Pass_Filter(16,D);
Image10 = Gaussian_High_Pass_Filter(24,D);
 
Image11 = Butterworth_High_Pass_Filter(50,3,D);
Image12 = Butterworth_High_Pass_Filter(50,4,D);
 
Image1 = Image1.*Img_DFT;
Image1_ifft = real(ifft2(Image1));
 
figure();
subplot(2,2,1);
imshow(log(1+abs(fftshift(Image1))));
title('filtered DFT image when D0 = 40');
 
subplot(2,2,2);
imshow(Image1_ifft);
title('filtered Original image when D0 = 40');
 
Image2 = Image2.*Img_DFT;
Image2_ifft = real(ifft2(Image2));
 
subplot(2,2,3);
imshow(log(1+abs(fftshift(Image2))));
title('filtered DFT image when D0 = 60');
 
subplot(2,2,4);
imshow(Image2_ifft);
title('filtered Original image when D0 = 40');
 
Image3 = Image3.*Img_DFT;
Image3_ifft = real(ifft2(Image3));
 
figure();
subplot(2,2,1);
imshow(log(1+abs(fftshift(Image3))));
title('filtered DFT image when sigma = 16');
 
subplot(3,2,2);
imshow(Image3_ifft);
title('filtered Original image when sigma = 16');
 
Image4 = Image4.*Img_DFT;
Image4_ifft = real(ifft2(Image4));
 
subplot(2,2,3);
imshow(log(1+abs(fftshift(Image4))));
title('filtered DFT image when sigma = 24');
 
subplot(2,2,4);
imshow(Image4_ifft);
title('filtered Original image when sigma = 24');
 
Image5 = Image5.*Img_DFT;
Image5_ifft = real(ifft2(Image5));
 
figure();
subplot(2,2,1);
imshow(log(1+abs(fftshift(Image5))));
title('filtered DFT image when n = 3 & D0 = 50');
 
subplot(2,2,2);
imshow(Image5_ifft);
title('filtered Original image when n = 3 & D0 = 50');
 
Image6 = Image6.*Img_DFT;
Image6_ifft = real(ifft2(Image6));
 
subplot(2,2,3);
imshow(log(1+abs(fftshift(Image6))));
title('filtered DFT image when n = 4 & D0 = 50');
 
subplot(2,2,4);
imshow(Image6_ifft);
title('filtered Original image when n = 4 & D0 = 50');
 
Image7 = Image7.*Img_DFT;
Image7_ifft = real(ifft2(Image7));
 
figure();
subplot(2,2,1);
imshow(log(1+abs(fftshift(Image7))));
title('filtered DFT image when D0 = 30');
 
subplot(2,2,2);
imshow(Image7_ifft);
title('filtered Original image when D0 = 30');
 
Image8 = Image8.*Img_DFT;
Image8_ifft = real(ifft2(Image8));
 
subplot(2,2,3);
imshow(log(1+abs(fftshift(Image8))));
title('filtered DFT image when D0 = 50');
 
subplot(2,2,4);
imshow(Image8_ifft);
title('filtered Original image when D0 = 50');
 
Image9 = Image9.*Img_DFT;
Image9_ifft = real(ifft2(Image9));
 
figure();
subplot(2,2,1);
imshow(log(1+abs(fftshift(Image9))));
title('filtered DFT image when sigma = 16');
 
subplot(2,2,2);
imshow(Image9_ifft);
title('filtered Original image when sigma = 16'); 
 
Image10 = Image10.*Img_DFT;
Image10_ifft = real(ifft2(Image10));
 
subplot(2,2,3);
imshow(log(1+abs(fftshift(Image10))));
title('filtered DFT image when sigma = 24');
 
subplot(2,2,4);
imshow(Image10_ifft);
title('filtered Original image when sigma = 24');
 
Image11 = Image11.*Img_DFT;
Image11_ifft = real(ifft2(Image11));
 
figure();
subplot(2,2,1);
imshow(log(1+abs(fftshift(Image11))));
title('filtered DFT image when n = 3 & D0 = 50');
 
subplot(2,2,2);
imshow(Image11_ifft);
title('filtered Original image when n = 3 & D0 = 50');
 
Image12 = Image12.*Img_DFT;
Image12_ifft = real(ifft2(Image12));
 
subplot(2,2,3);
imshow(log(1+abs(fftshift(Image12))));
title('filtered DFT image when n = 4 & D0 = 50');
 
subplot(2,2,4);
imshow(Image12_ifft);
title('filtered Original image when n = 4 & D0 = 50');
 
 
Function for Ideal Low Pass Filter:
 
function H = Ideal_Low_Pass_Filter(D0,D)
 
for u = 1:512
    for v = 1:512
        if(D(u,v) <= D0)
            H(u,v) = 1;
        else
            H(u,v) = 0;
        end
    end
end
 
figure();
mesh(fftshift(H)),
str = sprintf('Low Pass Filter for D0 = %d',D0);
title(str);
axis tight; 
 
figure();
imshow(fftshift(H));
str = sprintf('Low Pass Filter for D0 = %d',D0);
title(str);
end
 
 
%Function for Ideal High Pass Filter:
 
function H = Ideal_High_Pass_Filter(D0,D)
 
for u = 1:512
    for v = 1:512
        if(D(u,v)<=D0)
            H(u,v) = 0;
        else
            H(u,v) = 1;
        end
    end
end
 
figure();
mesh(fftshift(H)),
str = sprintf('High Pass Filter for D0 = %d',D0);
title(str);
axis tight;
 
figure();
imshow(fftshift(H));
str = sprintf('High Pass Filter for D0 = %d',D0);
title(str);
end
 
 
%Function for Gaussian Low Pass Filter:
 
function H = Gaussian_Low_Pass_Filter(sigma,D)
 
for u = 1:512
    for v = 1:512
        H(u,v) = exp(-1*(D(u,v)^2)/(2*sigma^2));
    end
end
 
figure();
mesh(fftshift(H)),
str = sprintf('Gaussian Low Pass Filter for sigma = %d',sigma);
axis tight;
title(str);
 
figure();
imshow(fftshift(H));
str = sprintf('Gaussian Low Pass Filter for sigma = %d',sigma);
title(str);
 
end
 
 
%Function for Gaussian High Pass Filter:
 
function H = Gaussian_High_Pass_Filter(sigma,D)
 
for u = 1:512
    for v = 1:512
        H(u,v) = 1-exp(-1*(D(u,v)^2)/(2*sigma^2));
    end
end
figure();
mesh(fftshift(H)),
str = sprintf('Gaussian High Pass Filter for sigma = %d',sigma);
axis tight;
title(str);
 
figure();
imshow(fftshift(H));
str = sprintf('Gaussian High Pass Filter for sigma = %d',sigma);
title(str);
 
end
 
 
%Function for Butterworth Low Pass Filter:
 
function H = Butterworth_Low_Pass_Filter(D0,N,D)
 
for u=1:512
    for v=1:512
        H(u,v) = 1/(1+(D(u,v)/D0)^(2*N));
    end
end
 
figure();
mesh(fftshift(H)),
str = sprintf('Butterworth Low Pass Filter for D0 = %d & n = %d',D0,N);
title(str);
axis tight;
 
figure();
imshow(fftshift(H));
str = sprintf('Butterworth Low Pass Filter for D0 = %d & n = %d',D0,N);
title(str);
 
end
 
%Function for Butterworth High Pass Filter:
 
function H =  Butterworth_High_Pass_Filter(D0,N,D)
 
for u = 1:512
    for v = 1:512
        H(u,v) = 1/(1+(D0/D(u,v))^(2*N));
    end
end
figure();
mesh(fftshift(H)),
str = sprintf('Butter High Pass Filter for D0 = %d & n = %d',D0,N);
axis tight;
title(str);
 
figure();
imshow(fftshift(H));
str = sprintf('Butterworth High Pass Filter for D0 = %d & n = %d',D0,N);
title(str);
end
