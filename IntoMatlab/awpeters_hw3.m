clear
clc

%Problem 1


disp('Problem 1:')

y=[0.05 -0.9 0 0 3 -2 -10];  %coefficients of the given polynomial

roots=roots(y)   %finds ALL roots


%Problem 2:
disp('Problem 2:')
disp('**results of given triangle 1,2, and 3 respectively')
%define matrices/ needed information

a=[3;2;1];
angle=[30;50;20];
triangle=[1;2;3];


%find side b
%B=sideA.*tan(angle given)
side_b=a.*tand(angle)

%find side c
%C=sideA./cos(angle given)
side_c=a./cosd(angle)

%find Area
%A=.5*base*height
area=.5*side_b.*a

