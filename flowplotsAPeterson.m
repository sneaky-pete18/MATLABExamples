function flowplotsAPeterson
%This guy plots some superposed plane flows in CARTESIAN
close all
clear all
clc
%Let's define our stream functions for various elementary flows:

%The uniform flow at angle alph, velocity U
psi_u=@(U,alph,x,y) U*cos(alph)*y - U*sin(alph)*x;

%Irrotational vortex, xirv, yirv, strength K_irv
psi_irv=@(K_irv, xirv, yirv, x, y) -K_irv/(2*pi)*log(sqrt((x-xirv).^2+(y-yirv).^2));

%Doublet, strength L_d, center at xd, yd
psi_d=@(L_d, xd, yd, x, y) -L_d*sin(atan((y-yd)./(x-xd)))./36.83; %sqrt((x-xd).^2+(y-yd).^2);

%The above functions may be linearly superposed, and then velocity fields
%may be extracted by taking apropos partial derivatives.  Let's define our
%control panel of terms and our domain of interest:

K_irv=10; %strength
L_d=0.06104; %lamda
U=45; %m/s
alph=0; %angle of flow
% q_dot_sc=2;
% q_dot_sk=1;


%for doublet and vortex centers?
xirv=0;
yirv=0;
xd=0;
yd=0;

%USE AN EVEN NUMBER OF POINTS TO AVOID ZEROS!
xmin=-.2;
xmax=-xmin;
ymin=-.2;
ymax=-ymin;
x=linspace(xmin,xmax,30);
y=linspace(ymax,ymin,30);

%Let's superpose a sink at (1,0), a source at (-1,0), and uniform flow
%along the x-axis.  We'll need to map this FOR EACH x,y PAIR ON OUR DOMAIN!
%We'll make our stream function psi_c, for compound, since psi is already a
%MATLAB fxn.

% xsc=-0.5;
% ysc=0;
% xsk=0.5;
% ysk=0;

%Initialise psi_c, u, v
psi_c=zeros(length(y),length(x));
u=psi_c;
v=u;
for i=1:length(x)
    for j=1:length(y)
        psi_c(j,i)= psi_u(U, alph, x(i), y(j)) +...
                    psi_irv(K_irv, xirv, yirv, x(i), y(j)) +...
                    psi_d(L_d, xd, yd, x(i), y(j));
                
    end
end

%Now take the partials of the stream fxn
for i=2:length(x)-1
    for j=2:length(y)-1
        u(j,i)=-(psi_c(j+1,i)-psi_c(j-1,i))/(y(j-1)-y(j+1));    %Signs are funny because y gets smaller as j increases
        v(j,i)=(psi_c(j,i+1)-psi_c(j,i-1))/(x(i+1)-x(i-1));
    end
end
figure(1)
quiver(x,y,u,v)

title('Combined flow around cylinder D=2.9"=73.66mm')
xlabel('x (m)')
ylabel('y (m)')
axis([-.1 .1 -.1 .1])
hold on
circle(0,0,0.07366/2) %see attached function 

end


function circle(x,y,r)
%x and y are the coordinates of the center of the circle
%r is the radius of the circle
%0.01 is the angle step, bigger values will draw the circle faster but
%you might notice imperfections (not very smooth)
ang=0:0.001:2*pi; 
xp=r*cos(ang);
yp=r*sin(ang);
plot(x+xp,y+yp,'k');
end








