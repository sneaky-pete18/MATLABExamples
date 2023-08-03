function [preformance,limit]= awpeters_hw5(T_c,T_h)



Tmenu=menu('What are the units of temperature','Fahrenheit','Centigrade','Kelvin','Rainkine')

switch Tmenu
    case 1
    
    T_c=(T_c+459.67)*(5/9)
    T_h=(T_h+459.67)*(5/9)
    
    case 2 
    T_c=T_c+273.15
    T_h=T_h+273.15
    
    case 3
    T_c=T_c
    T_h=T_h
    
    case 4 
        T_c=T_c*(5/9)
        T_h=T_h*(5/9)
        
    otherwise
        error('Please select a temperature input')
        
end

if T_h<T_c
    error('Please insure T_h is greater then T_c, Otherwise this computer may EXPLODE!!!')
    
end





preformance=T_c/(T_h-T_c)

h=50;
A=1;

limit=h*A*(preformance)

end

