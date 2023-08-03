function [C] = awpeters_hw_4(x)


clc
close all
%% Part 1 - Euler
        x=[0;pi/4;2*pi];   %defines the values we want to evaluate.
        C=exp(sqrt(-1).*x).*(-sqrt(-1).*sin(x)); %defines the function.
        disp('Q1.1 Solution is:') %displays the answer in a nice format.
        disp(C)
        
        



%% Part 2 - Euler Error
x=[0;pi/4;2*pi]; %defines "x"
C=(exp(sqrt(-1).*x).*(-sqrt(-1).*sin(x)))-cos(x); %defines new function
disp('Q1.2 Solution is:') %desplays result
disp(C)

%% Part 3 - Anonymous
z=[-1;.25;1]; %defines input

sinh=(exp(z)-exp(-z))./2; %defines each function
cosh=(exp(z)+exp(-z))./2;

disp('Q1.3 sinh Solution is:')
disp(sinh)   

disp('Q1.3 cosh Solution is:')
disp(cosh)   

end
