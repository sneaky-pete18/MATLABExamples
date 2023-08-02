clc
clear all
close all
format long
    
M=80; %number of elements, change for mesh refinement, record results.
endTime=2.1;
outputTime=[0.15;2]; %output time array values
%set domain
xmin=0;
xmax=2;
Lcalc=abs(xmax-xmin); %calc length of the domain

h=Lcalc/M; % calc step size
x=0-(h/2):h:2+(h/2); %set x values
time=0; %initial time
ITcount=0; %counter for iterations
eps=(1/10); %set error for entropy condition, h
%set initial Condition
u=zeros(1,M+2);
for i=2:1:M+1
    u(i)=0.25+0.5*sin(pi*x(i));
end
u(1)=u(M+1);
u(M+2)=u(2);

%preallocation or arrays
unew=zeros(1,M+2);
alphaplus=zeros(1,M+2);
duplushalf=zeros(1,M+2);
psiplus=zeros(1,M+2);
h_halfplus=zeros(1,M+2);

figure(1)%plot intial guess
plot(x,u)
hold on

figure(2)%plot initial guess
plot(x,u)
hold on

 while time<endTime

    ITcount=ITcount+1;
    E=0.5.*u.^2; %define E value array
    
    for i=2:1:M+1 %loop to set du, alpha, psi, and h
        duplushalf(i)=u(i+1)-u(i);

        %set alpha with 'if'
        if duplushalf(i)==0
            alphaplus(i)=u(i);
        else
            alphaplus(i)=(E(i+1)-E(i))/(duplushalf(i));
        end %end if for alpha
        

        
        if abs(alphaplus(i))>=eps
            psiplus(i)=abs(alphaplus(i));
        elseif abs(alphaplus(i))< eps
            psiplus(i)=(alphaplus(i)^2 + eps^2)/(2*eps);
        end %end psi if
        
        h_halfplus(i)=0.5*((E(i+1)+E(i))-abs(psiplus(i))*duplushalf(i));
    end %end variables loop
    
    %set BC's for all variables defined above
    alphaplus(1)=alphaplus(M+1);
    alphaplus(M+2)=alphaplus(2);
    
    psiplus(1)=psiplus(M+1);
    psiplus(M+2)=psiplus(2);   
    
    h_halfplus(1)=h_halfplus(M+1);
    h_halfplus(M+2)=h_halfplus(2);    
    
    dt=0.1*(h/max(abs(alphaplus))); %set time step
    for i=2:1:M+1 %loop to calculate time t^n+1
        unew(i)=u(i)-(dt/h)*(h_halfplus(i)-h_halfplus(i-1));
        
    end
    %set BC's for new time step
    unew(1)=unew(M+1);
    unew(M+2)=unew(2);
    u=unew;%redefine unew as u for use in the next iteration
    
    %%%plotting certain time points%%%
    
    %%% For output t=0.15 %%%
    if (time<outputTime(1)) && (time+dt>= outputTime(1))
        dtp=outputTime(1)-time; %set new dt to hit required plot point
        for i=2:1:M+1
            unew(i)=u(i)-(dtp/h)*(h_halfplus(i)-h_halfplus(i-1));
            
        end
        unew(1)=unew(M+1);%set BC's
        unew(M+2)=unew(2);
        u=unew;%redefine unew as u
        TVD=u;
        
        figure(1) %plot solution at time=0.15
        plot(x,u,'r')
        xlabel('X')
        ylabel(' Solution (u)')
        legend('Initial Guess t=0','time=0.15s','Location','Best')
        title('1st Order TVD solution "u"')
        
        figure(2) %plot soln at t=0.15 on fig 2 to overlay all solns
        plot(x,u,'k')
        break %un/comment to stop loop at t=0.15s
    end
    
    %%% For t=2s %%%
    if (time<outputTime(2)) && (time+dt>= outputTime(2))
        dtp=outputTime(2)-time; %set new dt to hit required plot point
        for i=2:1:M+1
            unew(i)=u(i)-(dtp/h)*(h_halfplus(i)-h_halfplus(i-1));
            
        end
        unew(1)=unew(M+1); %set BCs
        unew(M+2)=unew(2);
        u=unew; %redefine unew as u
        
        figure(2) %plot soln at t=2s 
        plot(x,u,'r')
        xlabel('X')
        ylabel('Solution (u)')
        legend('Initial Guess t=0','time=0.15s','time=2s','Location','Best')
        title('1st Order TVD solution "u"')
%         break %un/comment to stop loop at t=2s
    end
    
    
    time=time+dt;
    
end %end for/while overall loop
%% part c

tex=0.15; %time used to calculate the exact solution
    
for i=2:1:M+1 %loop through mesh points
    for f=1:1:1000 %perform 1000 iterations for each mesh point.
        %Newtons method
        uex(i)=u(i)-((u(i)-(.25+.5*(sin(pi.*(x(i)-u(i)*tex)))))/((pi/2)*tex*cos(pi*(x(i)-tex*u(i)))+1));
    u(i)=uex(i);
    end
    
end
uex=u;
e=zeros(1,M+1); %preallocate e
for i= 2:1:M+1
    e(i)=abs(uex(i)-TVD(i)); %calculate the error
end
linf=max(abs(e)); %calc the infinity norm
l1=(1/M)*(sum(abs(e))); %calc the 1 norm
