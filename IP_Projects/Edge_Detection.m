function[]=EDGE()
 clc;
clear all;
close all;
 
Image=imread('D:\STUDY\DIP\img_lib\girl512.bmp');
Image=double(Image);
 
%Sobel Method
 
A1 = [1,0,-1;2,0,-2;1,0,-1];
B1 = A1'';
 
G_Sobel = conv2(Image,A1,'same');
H_Sobel = conv2(Image,B1,'same');
 
Sobel_M = G_Sobel+H_Sobel;
a = mean(mean(Image));
 
[Threshold_Sobel] = edge_fn(Sobel_M,a);
subplot(2,2,4);imshow(uint8(Threshold_Sobel));title('Thresholded Edge');
subplot(2,2,1);imshow(uint8(G_Sobel));title('Edge along X');
subplot(2,2,2);imshow(uint8(H_Sobel));title('Edge along Y');
subplot(2,2,3);imshow(uint8(Sobel_M));title('Edges for Sobel method');
 
 
%Prewitt Method
 
X2 = [1,0,-1;1,0,-1;1,0,-1];
Y2 = X2';
G_Prewitt = conv2(Image,X2,'same');
H_Prewitt = conv2(Image,Y2,'same');
Prewitt_M = G_Prewitt+H_Prewitt;
[Threshold_Prewitt]=edge_fn(Prewitt_M,a);
figure;
subplot(2,2,4);imshow(uint8(Threshold_Prewitt));title('Thresholded Edge');
subplot(2,2,1);imshow(uint8(G_Prewitt));title('Edges along X');
subplot(2,2,2);imshow(uint8(H_Prewitt));title('Edges along Y');
subplot(2,2,3);imshow(uint8(Prewitt_M));title('Edge Detection by Prewitt method');
 
%Roberts Method
 
X3 = [1,0;0,-1];
Y3 = [0,1;-1,0];
G_Roberts = conv2(Image,X3,'same');
H_Roberts = conv2(Image,Y3,'same');
Roberts_M = G_Roberts+H_Roberts;
[Threshold_Roberts] = edge_fn(Roberts_M,30);
figure;
subplot(2,2,4);imshow(uint8(Threshold_Roberts));title('Thresholded Edge');
subplot(2,2,1);imshow(uint8(G_Roberts));title('Edge using mask 1');
subplot(2,2,2);imshow(uint8(H_Roberts));title('Edge using mask 2');
subplot(2,2,3);imshow(uint8(Roberts_M));title('Edge Detection by Roberts method');
 
%Gaussian Method
 
Gau = [2,4,5,4,2;4,9,12,9,4;5,12,15,12,5;4,9,12,9,4;2,4,5,4,2];
Gau = Gau./159;
H2 = [1,1,1;1,-8,1;1,1,1];
Gau_f = conv2(Image,Gau,'same');
Gau2_f = conv2(Gau_f,H2,'same');
[Threshold_Gaussian] = edge_fn(Gau2_f,20);
figure;
subplot(2,2,1);imshow(uint8(Image));title('Original Image for Gaussian method');
subplot(2,2,2);imshow(uint8(Gau_f));title('Gaussian Filtered Image');
subplot(2,2,3);imshow(uint8(Gau2_f));title('Edge Detection');
subplot(2,2,4);imshow(uint8(Threshold_Gaussian));title('Thresholded Edge');
 
%Canny Edge
 
im_can = conv2(Image,Gau,'same');
X_Can = [-1,0,1;-2,0,2;-1,0,1];
Y_Can = [1,2,1;0,0,0;-1,-2,-1];
G_Can = conv2(im_can,X_Can,'same');
H_Can = conv2(im_can,Y_Can,'same');
Canny_M = G_Can+H_Can;
[Threshold_Canny] = edge_fn(Canny_M,50);
figure;
subplot(3,2,1);imshow(uint8(Image));title('Original Image');
subplot(3,2,3);imshow(uint8(X_Can));title('Edge along X');
subplot(3,2,5);imshow(uint8(Canny_M));title('Overall Edge Detection');
subplot(3,2,2);imshow(uint8(im_can));title('Filtered Image');
subplot(3,2,4);imshow(uint8(Y_Can));title('Edge along Y');
subplot(3,2,6);imshow(uint8(Threshold_Canny));title('Thresholded Edge');
end
 
%Function:
function [out]=edge_fn(input,K)
for i=1:1:512
for j=1:1:512
if input(i,j)>K
out(i,j)=255;
else
out(i,j)=0;
end
end
end
end