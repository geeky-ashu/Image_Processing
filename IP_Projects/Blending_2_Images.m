clear all;
close all;
 
Input_Img=imread('D:\STUDY\DIP\img_lib\lena512.bmp');
Img=imresize(imread('D:\STUDY\DIP\img_lib\cameraman.bmp'),[512,512]);%converting image size to 512*512
 
%prompting for input alpha value at runtime.
prompt = 'What is the alpha value? ';
alpha = input(prompt)
 
%we need to enter alpha values between [0,1]
if(alpha<0||alpha>1)
    warning('you can not enter alpha value outside [0,1]')
else
    c=((1-alpha)*Input_Img)+(alpha*Img); %used the given expression to blend 2 images
    titl=sprintf('Blended Images for alpha=%0.1f',alpha);
imshow(c);title(titl);
end
