clc; 
clear all;
close all; 
 
orignal_img_1 = imread('D:\STUDY\DIP\img_lib\cameraman.bmp');
subplot(2,2,1);
imshow('orignal_img_1');
title('Actual Image');
 
orignal_img = double(orignal_img_1);
 
for p=5:7
Variable= 2^p;
Variable_1=256/(Variable); 
 
tk(1)=0;
    for m=2:(Variable+1)
        tk(m)=tk(m-1)+Variable_1;
    end
    for m=1:(Variable)
        rk(m)=tk(m)+Variable_1/2;
    end
 
% Quantization process
 
    for m=1:256     
        for n=1:256
            for k=1:Variable
                if (orignal_img(m,n) < tk(k+1) && orignal_img(m,n) >= tk(k))
                    UNI_img(m,n)=rk(k);
                end
            end 
        end
    end
    
UNI_img1 = double(UNI_img);
y = orignal_img - UNI_img1;
 
MSE = sum(sum(power(y,2)))/(256^2);  %  standard equation for MSE
 
PSNR = 10*log10((255^2)/MSE); %  standard equation for PSNR
 
UNI_img=uint8(UNI_img);
 
subplot(2,2,p-3);
imshow(uint8(UNI_img));
title([num2str(Variable),'level Quantized images']);
end
