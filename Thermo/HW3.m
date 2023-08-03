  
close all
clear
clc

Rta=0.255; %top to air, conv.
Rts=0.973;%top to sides,cond.
Rsw=0.0174;%sides to water, conv.
Rsb=0.0904;%sides to bottom, cond.
Rbw=0.619;%bottom to water, conv.


dTdt=zeros(3,1); %Initialize guess at dTdt vector, same components.
mcp=[61.69*434;776.89*434;1096.16*434];  %J/kg, thermal mass vector   
dt=1e-0;    %time step, we'll check to see how sensitive it is to this
t=0;
T_air=10*sin((pi.*t)./86400).^2+10;
Tw=278.15;
Q_sun=200*sin((pi.*(t-4))./86400).^2;
T=ones(3,1).*T_air+273.15; %K, Initialize temperature vector, contains, in order, T_top, T_side, T_bottom
mvmt=T_air;    %initialize my error term, the biggest dTdt

j=1;    %my time step indicator
while mvmt>.0001;
    j=j+1;
    t(j)=t(j-1)+dt; %Step the time
    dTdt(1)=(Q_sun - ((T_air - T(1,j-1))/Rta)-((T(2,j-1)-T(1,j-1))/Rts))/mcp(1);
    dTdt(2)=(((Tw-T(2,j-1))/Rsw) + ((T(1,j-1)-T(2,j-1))/Rts) + ((T(3,j-1)-T(2,j-1))/Rsb))/mcp(2);
    dTdt(3)=(-1*((Tw-T(3,j-1))/Rbw) - ((T(2,j-1)-T(3,j-1))/Rsb))/mcp(3);
    
    T(:,j)=T(:,j-1)+dTdt*dt;
    mvmt=max(abs(dTdt));
end
plot(t/3600,T-273.15)
xlabel('Time (hours)')
ylabel('Temperature (^oC)')
legend('Top','Sides','Bottom')

axis([0 50 -273 5000])

