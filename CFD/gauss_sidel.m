clear all;   
clc
close all

%% input variables 
N = [129,257,513]; %number of grid points
L = 1; %length of system
for num=1:1:3

h(num) = L/(N(num)-1);    % Grid spacing
x = (0:N(num)-1)*h;  % x coordinate

% Set initial guess and equations
phi0 = ((1/50).*sin(2.*pi.*x)+(1/200).*sin(64.*pi.*x));     % initial guess
phi_exact=sin(2.*pi.*x).*((5/4).*x.^4-x.^3);

% Set boundary conditions
phi0(1) = 0;  phi0(N(num)) = 0;
iteration=0;

phiGS = ((sin(2.*pi.*x)).*((-5.*pi^2.*x.^4)+(4.*pi^2.*x.^3)+(15.*x.^2)-(6.*x))+(cos(2.*pi.*x)).*((20.*pi.*x.^3)-(12.*pi.*x.^2))); 
  for iter=1:1:500 %loop through iteration numbers
      iteration=iteration+1;
    for i=2:(N(num)-1)        % interior points only
      phi0(i)= ((h^2*phiGS(i))-phi0(i+1)-phi0(i-1))/(-2);
       
        
    end
      

  end
  error=phi_exact-phi0;
  Linf(num)=max(abs(error));
  L1(num)=(1/N(num)).*sum(abs(error));
  L2(num)=sqrt(1/N(num)).*sum(error.^2);
  
  order(num)=cos(pi/N(num));
  
 
end


      