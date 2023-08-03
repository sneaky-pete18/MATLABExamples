clear all
clc 
close all

A=imread('hw10_original_armstrong(1).jpg');%read in image

R=A(:,:,1);  %Define each color as own variable
G=A(:,:,2);
B=A(:,:,3);

Rnew=R./0.95;  %preform required edits here
Gnew=G.*0.95;
Bnew=B./.95;



NEW=cat(3,Rnew,Gnew,Bnew); %builds the new image
imwrite(NEW,'hw10_edit_armstrong.jpg') %writes new image to file

NEWbw= rgb2gray(NEW); %switches to grayscale via desaturation.

imwrite(NEWbw,'hw10_editBW_armstrong.jpg') %writes grayscale image to file



