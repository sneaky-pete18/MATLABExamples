% clc 
% close all
% clear all
% format long
% 
% %% Set variables 
% 
% % fill=27; %amount of empty spaces to allocate for loop answers
% % efill=27; %same for error terms
% 
% x=4; %looking for derivative of the function below at this point.
% F=@(x) (sin(x)*cos(x))/(x^3); %function we are looking for derivtive of.
% %called as anonomous function to allow for easy function values
% Fprimeactual=(2*x*cos(2*x)-3*sin(2*x))/(2*x^4); %actual derivative
% %evaluated at "x"
% 
% % k_plot=[-1:1:25]; %used for nice plotting without allocating an array
% % h_plot=2.^(-k_plot);
% 
% 
% 
% %% Difference
% % Fprimefwd=zeros(1,fill); %allocating array space for the loop answers.
% % Fprimebkwd=zeros(1,fill);
% % Fprimecentral2=zeros(1,fill);
% % Fprimecentral4=zeros(1,fill);
% % 
% % e_fwd=zeros(1,efill); %Allocating array space for error terms.
% % e_bwkd=zeros(1,efill); %Do not ask why the error arrays populate themselves 
% % e_central2=zeros(1,efill);%in the loop. ex: why they dont have "e_"(index)=
% % e_central4=zeros(1,efill);
% 
% 
% index=0;    %start for the index, used to fill the pre-allocated arrays with results
%             %cannot use k to allocate position in array because it has negative values.
%             
% h=[1,.1,.01,.001,.0001]; %"h" for every iteration
% for k=[1:1:5]
%     
%     index=index+1;
%     b=h(k); %current step size vector, named it 'b' 
%     
% 
%     Fprimefwd(index)=(F(x+b)-F(x))./(b); %Forward dofference method
%     %Fprimebkwd(index)=(F(x)-F(x-h))./(h); %bkwd difference
%     Fprimecentral2(index)=(F(x+b)-F(x-b))./(2*b); %central Difference 2nd order accurate
%     Fprimecentral4(index)=(F(x-2*b)-(8*F(x-b))+(8*F(x+b))-F(x+2*b))./(12*b); %central 4th order
%     
%     e_fwd=abs(Fprimeactual-Fprimefwd); %associated error terms
%     %e_bwkd=abs(Fprimeactual-Fprimebkwd);
%     e_central2=abs(Fprimeactual-Fprimecentral2);
%     e_central4=abs(Fprimeactual-Fprimecentral4);
%     
%     
%     
% end
% 
% 
% 
% %% Plotting
% 
% figure(1)
% loglog(h,e_fwd,'b+-') %forward error plot
% 
% hold on
% %loglog(h,e_bwkd,'ms-') %bkwd error 
% loglog(h,e_central2,'k^-') %central 2nd error plot
% loglog(h,e_central4,'r*-') %central 4th error plot
% 
% 
% hold off
% xlabel('Step Size (h)')
% ylabel('Error (actual-difference)')
% legend('First Order Forward','Second Order Central','Fourth Order Central','Location','Best')
% 
% 
% slope1order=(log(e_fwd(2))-log(e_fwd(5)))/(log(h(2))-log(h(5)))
% slope2order=(log(e_central2(1))-log(e_central2(5)))/(log(h(1))-log(h(5)))
% slope4order=(log(e_central4(1))-log(e_central4(4)))/(log(h(1))-log(h(4)))
% 
% 
% 
% 
% 
% 
