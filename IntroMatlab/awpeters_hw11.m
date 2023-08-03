clc 
close all

%data imported using import wizard


figure %ne figure
P0deg=polyfit(mdot_0(1:6),dP_0(1:6),1); %finds coefficients
F0deg=polyval(P0deg,mdot_0(1:6)); %eval polynomial at P0deg
plot(mdot_0(1:6),dP_0(1:6),'r*',mdot_0(1:6),F0deg,'r') %plots all data and fit line


hold on %plots all following on same graph

Phalf_deg=polyfit(mdot_05(1:6),dP_05(1:6),1);
Fhalf_deg=polyval(Phalf_deg,mdot_05(1:6));
plot(mdot_05(1:6),dP_05(1:6),'bp',mdot_05(1:6),Fhalf_deg,'b');



P1deg=polyfit(mdot_1,dP_1,1);
F1deg=polyval(P1deg,mdot_1);
plot(mdot_1,dP_1,'go',mdot_1,F1deg,'g')

P2deg=polyfit(mdot_2,dP_2,1);
F2deg=polyval(P1deg,mdot_2);
plot(mdot_2,dP_2,'k.',mdot_2,F2deg,'k')

title({'Microchannel Pressure Drop'});
ylabel({'Pressure Drop'});
xlabel({'Mass Flow Rate'});

legend('0 degrees','0 degree fit','1/2 degrees','1/2 degrees fit','1 degrees','1 degrees fit','2 degrees','2 degrees fit','Location','NorthWest')

hold off

