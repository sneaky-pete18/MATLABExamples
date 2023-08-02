function [T,tay,fib]=awpeters_hw6(val); %x= the number you wish to calculate the function value of

%Problem 1.1:
 disp('Problem 1.1')

a=0; %defines known point of the function
Er=1; %starting error

n=0; %starting iteration for the loop, ie. the first calculation the loop preforms.
while Er >= 1*(10^-9); %runs while Error is more then .000000001
    
    
    T(n+1)=(exp(a)./factorial(n)).*(val-a).^(n); %taylor series eqn.
    
    tay=sum(T) %the taylor series is the sum of all the calculations above
   
    Er=abs(tay-exp(0.05)) %euqation for error between the guess and actual MATLAB value.
    n=n+1 %moves "n" up one number so that loop preforms the next calc.
    
end

%Problem 1.2:
disp('Problem 1.2')


format long


fib(1)=1; %defines required first numbers
fib(2)=2;


for f= 3:50; %50 loops, the first 2 were defined already
  fib(f)=fib(f-1)+fib(f-2); %defines relationship between fib sequence numbers.
end
disp(fib)

%Problem 2:


x=0:0.05:1; %defines domain and interval to eval
title({'Problem 2'}) %gives title
N1=(exp(x)./factorial(1)).*x; %defines n=1
N2=(exp(x)./factorial(2)).*x.^2; %defines n=2
N3=(exp(x)./factorial(3)).*x.^3; %defines n=3
plot(N1,'k+--') %black plot, plus signs at data, dashed
xlabel('Domain')%axis titles
ylabel('Range')
hold on         %makes sure to plot all on same graph
plot(N2,'rx-.') %plots red, x's at data, dash dotted
plot(N3,'go:') %green, 'o' at data, dotted
plot(exp(x),'b.-')%blue, dots at data, solid

legend('n=1','n=2','n=3','exp(x)') %gives legend for graph and line styles




end


