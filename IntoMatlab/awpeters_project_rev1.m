%% Project

%data imported using Import wizard, workspace included with files.
clc 
close all

%% 1.1  

figure

[AX,H1,H2] = plotyy(x_value,TC_B_Outlet_Left_Wall_degC,x_value,Power)

hold(AX(1))
plot(AX(1),x_value,TC_C_Outlet_Mid_Short_degC,'r')
plot(AX(1),x_value,TC_D_Outlet_Right_Wall_degC,'m')
plot(AX(1),x_value,TC_F_Inlet_Mid_Short_degC,'c')
plot(AX(1),x_value,TC_G_Inlet_Right_Wall_degC,'k')

xlabel('Time')
set(get(AX(1),'Ylabel'),'String','Thermocouples B,C,D,F,G (degC)') 
set(get(AX(2),'Ylabel'),'String','Heat Input (power)')
title('Thermocouples/Heat Input vs. Time')
legend('TC_B','TC_C','TC_D','TC_F','TC_G','Heat Input')
hold off
%% 1.2
disp('The following pertains to Problem 1.2:')

%1st event
Time_index_1stevent=find((x_value>176) & (x_value<400)); %picks data according to time constraint for peak
timefit_TC1st=x_value(Time_index_1stevent);     % shifts data
timefit_TC1st=timefit_TC1st-timefit_TC1st(1); %scales from 0

TC_Bfit1st=TC_B_Outlet_Left_Wall_degC(Time_index_1stevent);%for TC_B
[Pb1,S]=polyfit(timefit_TC1st,TC_Bfit1st,1);

TC_Cfit1st=TC_C_Outlet_Mid_Short_degC(Time_index_1stevent);%for TC_C
[Pc1,S]=polyfit(timefit_TC1st,TC_Cfit1st,1);

TC_Dfit1st=TC_D_Outlet_Right_Wall_degC(Time_index_1stevent);%for TC_D
[Pd1,S]=polyfit(timefit_TC1st,TC_Dfit1st,1);

TC_Ffit1st=TC_F_Inlet_Mid_Short_degC(Time_index_1stevent);%for TC_F
[Pf1,S]=polyfit(timefit_TC1st,TC_Ffit1st,1);

TC_Gfit1st=TC_G_Inlet_Right_Wall_degC(Time_index_1stevent);%for TC_G
[Pg1,S]=polyfit(timefit_TC1st,TC_Gfit1st,1);


%second event

Time_index_2ndevent=find((x_value>7067) & (x_value<7215)); %picks data according to time condition
timefit_TC2nd=x_value(Time_index_2ndevent);  
timefit_TC2nd=timefit_TC2nd-timefit_TC2nd(1); %makes picked data scale from 0


%plot(timefit_TC2nd,TC_Bfit2nd) %optional plot for reassurance
TC_Bfit2nd=TC_B_Outlet_Left_Wall_degC(Time_index_2ndevent);%for TC_B
[Pb2,S]=polyfit(timefit_TC2nd,TC_Bfit2nd,1);


TC_Cfit2nd=TC_C_Outlet_Mid_Short_degC(Time_index_2ndevent);%for TC_C
[Pc2,S]=polyfit(timefit_TC2nd,TC_Cfit2nd,1);


TC_Dfit2nd=TC_D_Outlet_Right_Wall_degC(Time_index_2ndevent);%for TC_D
[Pd2,S]=polyfit(timefit_TC2nd,TC_Dfit2nd,1);


TC_Ffit2nd=TC_F_Inlet_Mid_Short_degC(Time_index_2ndevent);%for TC_F
[Pf2,S]=polyfit(timefit_TC2nd,TC_Ffit2nd,1);

TC_Gfit2nd=TC_G_Inlet_Right_Wall_degC(Time_index_2ndevent);%for TC_G
[Pg2,S]=polyfit(timefit_TC2nd,TC_Gfit2nd,1);

avg_1st_event=[Pb1(1),Pc1(1),Pd1(1),Pf1(1),Pg1(1)];
avg_2nd_event=[Pb2(1),Pc2(1),Pd2(1),Pf2(1),Pg2(1)];


Mean1st=mean(avg_1st_event)
Mean2nd=mean(avg_2nd_event)

%% 1.3
disp('The following pertains to Problem 1.3:')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1st event 
%time indexing
Time_index_1stevent=find((x_value>389.6) & (x_value<1832)); %picks data according to time constraint for peak
timefit_TC1st=x_value(Time_index_1stevent);     % shifts data
timefit_TC1st=timefit_TC1st-timefit_TC1st(1);


%fit for TC_B, 1st event
TC_Bfit1st=TC_B_Outlet_Left_Wall_degC(Time_index_1stevent);

TC_Blog1st=log(TC_Bfit1st);
[Pb1st,S]=polyfit(timefit_TC1st,TC_Blog1st,1);

%fit for TC_C, 1st event
TC_Cfit1st=TC_C_Outlet_Mid_Short_degC(Time_index_1stevent);
TC_Clog1st=log(TC_Cfit1st);
[Pc1st,S]=polyfit(timefit_TC1st,TC_Clog1st,1);

%fit for TC_D, 1st event
TC_Dfit1st=TC_D_Outlet_Right_Wall_degC(Time_index_1stevent);
TC_Dlog1st=log(TC_Dfit1st);
[Pd1st,S]=polyfit(timefit_TC1st,TC_Dlog1st,1);

%fit for TC_F, 1st event
TC_Ffit1st=TC_F_Inlet_Mid_Short_degC(Time_index_1stevent);
TC_Flog1st=log(TC_Ffit1st);
[Pf1st,S]=polyfit(timefit_TC1st,TC_Flog1st,1);

%fit for TC_G, 1st event
TC_Gfit1st=TC_G_Inlet_Right_Wall_degC(Time_index_1stevent);
TC_Glog1st=log(TC_Gfit1st);
[Pg1st,S]=polyfit(timefit_TC1st,TC_Glog1st,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%2nd event
%time index
Time_index_2ndevent=find((x_value>2184) & (x_value<4952)); %picks data according to time condition
timefit_TC2nd=x_value(Time_index_2ndevent);  
timefit_TC2nd=timefit_TC2nd-timefit_TC2nd(1);

%fit for TC_B, 2nd event
TC_Bfit2nd=TC_B_Outlet_Left_Wall_degC(Time_index_2ndevent);
TC_Blog2nd=log(TC_Bfit2nd);
[Pb2nd,S]=polyfit(timefit_TC2nd,TC_Blog2nd,1);

%fit for TC_C, 2nd event
TC_Cfit2nd=TC_C_Outlet_Mid_Short_degC(Time_index_2ndevent);
TC_Clog2nd=log(TC_Cfit2nd);
[Pc2nd,S]=polyfit(timefit_TC2nd,TC_Clog2nd,1);

%fit for TC_D,2nd event
TC_Dfit2nd=TC_D_Outlet_Right_Wall_degC(Time_index_2ndevent);
TC_Dlog2nd=log(TC_Dfit2nd);
[Pd2nd,S]=polyfit(timefit_TC2nd,TC_Dlog2nd,1);

%fit for TC_F, 2nd event
TC_Ffit2nd=TC_F_Inlet_Mid_Short_degC(Time_index_2ndevent);
TC_Flog2nd=log(TC_Ffit2nd);
[Pf2nd,S]=polyfit(timefit_TC2nd,TC_Flog2nd,1);

%fit for TC_G, 2nd event
TC_Gfit2nd=TC_G_Inlet_Right_Wall_degC(Time_index_2ndevent);
TC_Glog2nd=log(TC_Gfit2nd);
[Pg2nd,S]=polyfit(timefit_TC2nd,TC_Glog2nd,1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%3rd event
%time index
Time_index_3rdevent=find((x_value>5264) & (x_value<7073)); %picks data according to time condition
timefit_TC3rd=x_value(Time_index_3rdevent);  
timefit_TC3rd=timefit_TC3rd-timefit_TC3rd(1);

%fit for TC_B,3rd event
TC_Bfit3rd=TC_B_Outlet_Left_Wall_degC(Time_index_3rdevent);
TC_Blog3rd=log(TC_Bfit3rd);
[Pb3rd,S]=polyfit(timefit_TC3rd,TC_Blog3rd,1);

%fit for TC_C,3rd event
TC_Cfit3rd=TC_C_Outlet_Mid_Short_degC(Time_index_3rdevent);
TC_Clog3rd=log(TC_Cfit3rd);
[Pc3rd,S]=polyfit(timefit_TC3rd,TC_Clog3rd,1);

%fit for TC_D, 3rd event
TC_Dfit3rd=TC_D_Outlet_Right_Wall_degC(Time_index_3rdevent);
TC_Dlog3rd=log(TC_Dfit3rd);
[Pd3rd,S]=polyfit(timefit_TC3rd,TC_Dlog3rd,1);

%fit for TC_F, 3rd event
TC_Ffit3rd=TC_F_Inlet_Mid_Short_degC(Time_index_3rdevent);
TC_Flog3rd=log(TC_Ffit3rd);
[Pf3rd,S]=polyfit(timefit_TC3rd,TC_Flog3rd,1);

%fit for TC_G, 3rd event
TC_Gfit3rd=TC_G_Inlet_Right_Wall_degC(Time_index_3rdevent);
TC_Glog3rd=log(TC_Gfit3rd);
[Pg3rd,S]=polyfit(timefit_TC3rd,TC_Glog3rd,1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%4th event
%time index
Time_index_4thevent=find((x_value>7207) & (x_value<9495)); %picks data according to time condition
timefit_TC4th=x_value(Time_index_4thevent);  
timefit_TC4th=timefit_TC4th-timefit_TC4th(1);

%fit for TC_B, 4th event
TC_Bfit4th=TC_B_Outlet_Left_Wall_degC(Time_index_4thevent);
TC_Blog4th=log(TC_Bfit4th);
[Pb4th,S]=polyfit(timefit_TC4th,TC_Blog4th,1);

%fit for TC_C, 4th event
TC_Cfit4th=TC_C_Outlet_Mid_Short_degC(Time_index_4thevent);
TC_Clog4th=log(TC_Cfit4th);
[Pc4th,S]=polyfit(timefit_TC4th,TC_Clog4th,1);

%fit for TC_D, 4th event
TC_Dfit4th=TC_D_Outlet_Right_Wall_degC(Time_index_4thevent);
TC_Dlog4th=log(TC_Dfit4th);
[Pd4th,S]=polyfit(timefit_TC4th,TC_Dlog4th,1);

%fit for TC_F, 4th event
TC_Ffit4th=TC_F_Inlet_Mid_Short_degC(Time_index_4thevent);
TC_Flog4th=log(TC_Ffit4th);
[Pf4th,S]=polyfit(timefit_TC4th,TC_Flog4th,1);

%fit for TC_G, 4th event
TC_Gfit4th=TC_G_Inlet_Right_Wall_degC(Time_index_4thevent);
TC_Glog4th=log(TC_Gfit4th);
[Pg4th,S]=polyfit(timefit_TC4th,TC_Glog4th,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%finding H

%1st
expon_1st=[Pb1st(1) Pc1st(1) Pd1st(1) Pf1st(1) Pg1st(1)];
H_1st_event=(-expon_1st.*Mean1st)./(1832-389.6);

%2nd
expon_2nd=[Pb2nd(1) Pc2nd(1) Pd2nd(1) Pf2nd(1) Pg2nd(1)];
H_2nd_event=(-expon_2nd.*Mean1st)./(4952-2184);

%3rd
expon_3rd=[Pb3rd(1) Pc3rd(1) Pd3rd(1) Pf3rd(1) Pg3rd(1)];
H_3rd_event=(-expon_3rd.*Mean1st)./(7073-5264);

%4th
expon_4th=[Pb4th(1) Pc4th(1) Pd4th(1) Pf4th(1) Pg4th(1)];
H_4th_event=(-expon_4th.*Mean1st)./(9495-7207);

%All "H" values: rows=event, column=TC
H_total=[H_1st_event;H_2nd_event;H_3rd_event;H_4th_event];

H_avg=mean(mean(H_total))
STdev=std(std(H_total))

figure
plot([1:4],H_total(:,1),'*')

hold on
plot([1:1:4],H_total(:,2),'ro')
plot([1:1:4],H_total(:,3),'g+')
plot([1:1:4],H_total(:,4),'cx')
plot([1:1:4],H_total(:,5),'ms')
hold off
xlabel('Heat-Cool Cycle')
ylabel('H- Estimation')
legend('TC_B','TC_C','TC_D','TC_F','TC_G')
