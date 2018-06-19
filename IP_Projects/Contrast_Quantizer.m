clc; 
clear all;
close all; 
 
orignal_img_1 = imread('D:\STUDY\DIP\img_lib\cameraman.bmp');
subplot(2,2,1);
imshow(orignal_img_1);
title('Actual Image');
 
orignal_img = double(orignal_img_1);
 
for m=5:7
variable= 2^m;
 
C = (1)*((orignal_img).^(1/3));
 
tk(1) = min(min(C));
tk(variable+1) = max(max(C));
 
variable_1 = (tk(variable+1)-tk(1))/variable;
 
for a=2:(variable)
      tk(a)=tk(a-1)+variable_1;
end
 
for a=1:(variable)
        rk(a)=tk(a)+variable_1/2;
end
 
% Quantization process
 
    for a=1:256     
        for p=1:256
            for q=1:variable
                if (C(a,p) < tk(q+1) && C(a,p) >= tk(q))
                    UNI_img(a,p)=rk(q);
                end
            end 
        end
    end
    
 
U = (UNI_img).^(3);
U_1 = double(U);
 
y = orignal_img - U_1;
 
%disp(U1);
 
MSE = sum(sum(power(y,2)))/(256^2);  %  standard equation for MSE
disp(MSE);
 
PSNR = 10*log10((255^2)/MSE); %  standard equation for PSNR
disp(PSNR);
 
subplot(2,2,m-3);
imshow(uint8(U_1));
title([num2str(variable),'level Quantized images']);
end
