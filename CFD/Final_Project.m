clc
clear all
close all
format long
tic %begin timing

M=64; %Change mesh here to perform GCI analysis, for loop to change mesh
%spacing is wayyyy to slow.

centerm=M/2+1; %center minus point
centerp=M/2+2; %center plus point

Re=400;
A=1; %top lid speed
B=0.5; %bottom lid speed
e=1e-05;

%set domain
xymin=0;
xymax=1;

Lcalc=abs(xymax-xymin); %calc length of the domain
h=Lcalc/M; % calc step size
h2=h^2;

x=0-(h/2):h:1+(h/2); %set x values
y=0-(h/2):h:1+(h/2); %set y values
[Xplot,Yplot]=meshgrid(x,y); %set up grid for plotting

%initialize
time=0;
vstar=zeros(M+2,M+1); %set initial for 'unew'
ustar=zeros(M+1,M+2); %set initial for 'vnew'
v=zeros(M+2,M+1); %set initial for 'u'
u=zeros(M+1,M+2); %set initial for 'v'
phi=zeros(M+2);
vnew=zeros(M+2,M+1);
unew=zeros(M+1,M+2);
f=zeros(M+2);

%BC's for u array
u(1,:)=0;
u(M+1,:)=0;
u(:,1)=2*B-u(:,2);
u(:,M+2)=2*A-u(:,M+1);

%BC's for v array
v(1,:)=-v(2,:);
v(M+2,:)=-v(M+1,:);
v(:,1)=0;
v(:,M+1)=-0;

ITcount=0; %initialize iteration counting array

Linfu=1; %used to initiate infinity norm value such that code with enter
%while loop
Linf=1;

while Linf>e
    ITcount=ITcount+1;
    
    [dt,REc]=timestep(u,v,h,Re);
    
    [ustar,vstar]=predictFTCS(u,v,M,dt,h,h2,Re,A,B,ustar,vstar);
    
    %%%% RHS calculation %%%
    Crhs=1/(h*dt);
    for i=2:1:M+1
        for j=2:1:M+1
            f(i,j)=Crhs*((ustar(i,j)-ustar(i-1,j))+(vstar(i,j)-vstar(i,j-1)));
        end
    end
    
    [phi,err]=V_cycle(M,h,phi,f,10000,1e-5,2);
    
    %     %%% Gauss Seidel %%%
    %     Linf_gs=1e5;
    %     GScount=0;
    %     %     for i=1:9000
    %     while Linf_gs>1e-2
    %         GScount=GScount+1;
    %
    %         phi=GaussSeidel(phi,f,h,M);
    %
    %         if mod(GScount,400)==0
    %             R=calcResidual(phi,f,h,M);
    %             Linf_gs=max(max(abs(R)));
    %             disp(Linf_gs)
    %         end
    %     end
    
    
    %%%% Projection %%%
        %Solves for u and v at time level t^n+1
    Const=dt/h;
    for i=2:1:M
        for j=2:1:M+1
            unew(i,j)=ustar(i,j)-Const*(phi(i+1,j)-phi(i,j));
        end
    end
    
    for i=2:M+1;
        for j=2:M;
            vnew(i,j)=vstar(i,j)-Const*(phi(i,j+1)-phi(i,j));
        end
    end
    %BC's for u array at t^n+1
    unew(1,:)=0;
    unew(M+1,:)=0;
    unew(:,1)=2*B-unew(:,2);
    unew(:,M+2)=2*A-unew(:,M+1);
    
    %BC's for v array at t^n+1
    vnew(1,:)=-vnew(2,:);
    vnew(M+2,:)=-vnew(M+1,:);
    vnew(:,1)=0;
    vnew(:,M+1)=-0;
    
    %%% Display settings %%%%
    if mod(ITcount,10)==0
        convergence=[max(max((unew-u)/dt)), max(max((vnew-v)/dt))];
        Linf=max(convergence);
        disp('Time Step=')
        disp(dt)
        disp('Current Time=')
        disp(time)
        disp('Infinity Norm=')
        disp(Linf)
    end

    %%% Reset variables %%%
    u=unew;
    v=vnew;
    
    time=time+dt;
    
    %%% Vorticity %%%
    %Cvort=1/h;
    for i=1:1:M+1
        for j=1:1:M+1
            vort(i,j)=(v(i+1,j)-v(i,j))/h-(u(i,j+1)-u(i,j))/h;
        end
    end
    
end

%averaging center points to find the velocity at the center.
Ucenter=(u((M/2)+1,(M/2)+1)+u((M/2)+1,(M/2)+2))/2;%center of the u array
Vcenter= (v((M/2)+1,(M/2)+1)+v((M/2)+2,(M/2)+1))/2;%center of the v array
disp('M=')
disp(M)
disp('The velocity at U center=')
disp(Ucenter)
disp('The velocity at V center=')
disp(Vcenter)
%vort=flipud(vort);
u=flipud(u);
%v=flipud(v);

figure(1)
contour(0:h:1,0:h:1,vort',-5:1:5)
title('Isoline Plot at Steady State')
xlabel('y')
ylabel('x')

figure(2)
plot(x,u((M/2)+1,:))
title('U velocity at center line (x=0.5)')
xlabel('y')
ylabel('U')

figure(3)
plot(y,v(:,(M/2)+1))
title('V velocity at center line (y=0.5)')
xlabel('x')
ylabel('V')

toc

%% GCI
r=2; %ratio of mesh elements 1-->2 (#elements in 1/#elements in 2)

%%% U velocity GCI
USS=[-0.363117584683576,-0.362419390023633, -0.359595497288853]; %SS velocities input 
%by hand to save compute time
%USS=[256 mesh, 128 mesh, 64 mesh]
pu=log((USS(3)-USS(2))/(USS(2)-USS(1)))/log(r); %Calculates p
f0u=USS(1)+((USS(1)-USS(2))/(r^pu-1)); %calculates F at h=0

GCI12u=1.25*((abs((USS(1)-USS(2))/USS(1))/(r^pu-1))); %Grid Convergence 
%Index from mesh 1-->2
GCI23u=1.25*((abs((USS(2)-USS(3))/USS(2))/(r^pu-1))); %Grid Convergence 
%Index from mesh 2-->3

AROCu=(GCI12u/GCI23u)*r^pu; %Asymptotic Range Of Convergence

%%%% V velocity GCI
VSS=[0.059705126358148,0.059631406184300, 0.059333124782174];

pv=log((VSS(3)-VSS(2))/(VSS(2)-VSS(1)))/log(r); %Calculates p
f0v=USS(1)+((VSS(1)-VSS(2))/(r^pv-1)); %calculates F at h=0

GCI12v=1.25*((abs((VSS(1)-VSS(2))/VSS(1))/(r^pv-1))); %Grid Convergence 
%Index from mesh 1-->2
GCI23v=1.25*((abs((VSS(2)-VSS(3))/VSS(2))/(r^pv-1))); %Grid Convergence 
%Index from mesh 2-->3

AROCv=(GCI12v/GCI23v)*r^pv; %Asymptotic Range Of Convergence

