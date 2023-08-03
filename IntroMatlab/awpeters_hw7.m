%Please run each seperatly, I could not get the sub plots to open in their
%own figure...



%% Problem 1.1

load hw7_data;

[AX,H1,H2] = plotyy(t,Tref_hw,t,TTC_hw)

title('Problem 1.1: Critical Heat Flux')


ylabel(AX(1), 'Refridgerant')
ylabel(AX(2), 'Heated')
xlabel('Time')

legend('B','C','D','F','G','Inlet','Outlet','Location','NorthWest') 

%% Problem 1.2

Inlet=p_hw(:,1);
Outlet=p_hw(:,2);
Pdrop=Inlet-Outlet;


figure,(subplot(2,1,1))

plot(t,Inlet,'r')
hold on
plot(t,Outlet)
title('Problem 1.2: Pressure Drop')
xlabel('Time')
ylabel('Pressures')
legend('Inlet','Outlet','Location','SouthEast')


subplot(2,1,2)
plot(t,Pdrop)
xlabel('Time')
ylabel('Pressure Drop')


