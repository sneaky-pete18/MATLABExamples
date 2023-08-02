
%% Multigrid solver V-Cycle
clc 
clear all
close all
clear
format long

%Define variables that dont change
p=8; %used to set number of grid levels
N=[257;129;65;33;17;9;5;3]; %number of elements in each grid
ITplot=1:1:100; %used to plot solution
L = 1;          % length
h(:,1) = L./(N(:)-1); % spacing
x(:,1) = (0:N(1)-1).*h(1);  % x coordinate
xc(:,1) = (0:128).*.0078; %x coordinate of course mesh

%function value below
rhs{1,1}=((sin(2.*pi.*x)).*((-5.*pi^2.*x.^4)+(4.*pi^2.*x.^3)+(15.*x.^2)-...
    (6.*x))+(cos(2.*pi.*x)).*((20.*pi.*x.^3)-(12.*pi.*x.^2)));
%set boundaries
rhs{1,1}(1)=0; 
rhs{1,1}(N(1))=0;


phi_f=((1/50).*sin(2.*pi.*x)+(1/200).*sin(64.*pi.*x)); %initial guess fine 
%grid
phi_f(1)=0; %overwrite initial guess array for boundary conditions
phi_f(N(1))=0; %"  "


figure(2)
plot(x,phi_f) %plot initial guess
legend('Initial Guess')
 hold on
ITcount=0; %count initiation



for iteration=1:1:100 %iteration loop
    ITcount=ITcount+1; %iteration counter
    
    [phi_f]=my_gauss_seidel(phi_f,N(1),rhs{1,1},h(1));
    R{1,1}=residual(phi_f,rhs{1,1},h(1),N(1));
    
        
    for q=2:1:p %% used in case of v-cycle
        
        rhs{1,q}=restriction(R{1,q-1},N,q); %Computes restricted values on next coarsest mesh
        eps{1,q}= zeros(1,N(q));
        eps{1,q}=my_gauss_seidel(eps{1,q},N(q),rhs{1,q},h(q)); %computes one iteration of G.S.
        R{1,q}=residual(eps{1,q},rhs{1,q},h(q),N(q)); %computes residual after G.S.

    end
    
    for r=p-1:-1:2 %%Used in case of V-cycle
        
        epsc{1,r}=prolong(eps{1,r+1},N,r); %prolongs data to fine grid
        eps{1,r}=correct(epsc{1,r},phi_f,r); %corrects phi on fine grid using epcs
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%Below, used in case of v-cycle,ran out of time to code the rest.
        
        eps{1,r}=my_gauss_seidel(eps{1,r},N(r),rhs{1,r},h(r));
        
    end  
    epsc{1,1}=prolong(eps,N,r);
    phi_f=correct(phi_f,epsc);
    
    %used to plot at given iteration numbers
    if ITcount==1
        figure(2)
        title('Dual Grid')
        xlabel('x')
        ylabel('solution (phi)')
        plot(x,phi_f,'r')
        legend('Initial Guess','I=1')
    elseif ITcount==2
        figure(2)
        plot(x,phi_f,'c')
        legend('Initial Guess','I=1','I=2')
    elseif ITcount==50
        figure(2)
        plot(x,phi_f,'y')
        legend('Initial Guess','I=1','I=2','I=50')
    elseif ITcount==100
        figure(2)
        plot(x,phi_f,'m')
        legend('Initial Guess','I=1','I=2','I=50','I=100')
    end
    
    R_it=residual(phi_f,rhsF,h(1),N(1));%computes residual of each overall 
    %iteration
    L_inf(iteration)=max(abs(R_it));%infinity norm of residual
    
        
end

%Below: plots infinity norm of residual of Dual grid and GS on same plot
figure(3)
semilogy(ITplot,L_inf,'r') %semilogy makes y axis log 
hold on
semilogy(ITplot,L_inf_GS,'k')
legend('Dual Grid','Gauss Seidel')
xlabel('Iteration')
ylabel('Infinity Norm of Residual')
title('Residual of Dual Grid vs Gauss Seidel')



















