% input image = flowers.bmp
Img= double(imread('D:\STUDY\DIP\img_lib\flowers.bmp'));
figure(2);
imshow('D:\STUDY\DIP\img_lib\flowers.bmp');
title('original image')
%Separating RGB components.
Red=Img(:,:,1);
Green=Img(:,:,2);
Blue=Img(:,:,3);
%converting RGB into Y Cg Co
Y_Lumi=1/2*(Green + (Red+Blue)/2);
Cg_Chro=1/2*(Green - (Red+Blue)/2);
Co_Chro=(Red- Blue)/2;
figure(3);
subplot(2,3,1);
image(uint8(Y_Lumi));
title('Y - Image');
subplot(2,3,2);
image(uint8(Cg_Chro));
title('Cg - Image');
subplot(2,3,3);
image(uint8(Co_Chro));
title('Co - Image');
%RGB Components
R_comp=2*Y_Lumi - 2*Cg_Chro + 2*Co_Chro;
G_comp=Y_Lumi + Cg_Chro;
B_comp=Y_Lumi-Cg_Chro-Co_Chro;
subplot(2,3,4);
image(uint8(R_comp));
title('R - Image');
subplot(2,3,5);
image(uint8(G_comp));
title('G - Image');
subplot(2,3,6);
image(uint8(B_comp));
title('B - Image');