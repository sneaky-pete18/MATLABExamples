function awpeters_hw8
%% Problem 1.1
clear 
close all
func1=@(x,y) sin(x).*exp(-y*.2) +.01*cos(x).*exp(y*.2);   %Define vector-tolerant anonymous function (a common solution format to a PDE, with constants made up)
x=0:.1:(2*pi);y=0:.1:(4*pi);        %x-data are Space (m), y-data are Time (s), z-data are wave height (m).
[X,Y]=meshgrid(x,y);Z=func1(X,Y);   %Make a meshgrid of the x-y pairs and get z-data for each point on the mesh
%PS - While not required, I suggest you think through what the above lines
%are doing, and even look up meshgrid - MJM

%Surface plot code here     %10pts total
surf(X,Y,Z)
xlabel('Space')
ylabel('Time')
zlabel('Wave Height')
title('Billows')


%% Contour 1.2

figure  %Make a new figure
%Contour plot code here    %10pts total
[C,H]=contour(X,Y,Z)
clabel(C, H)
xlabel('Space')
ylabel('Time')
zlabel('Wave Height')
title('Contours')


