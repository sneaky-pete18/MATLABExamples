

%% GCI
r=2; %ratio of mesh elements 1-->2 (#elements in 1/#elements in 2)

%%% U velocity GCI
USS=[-0.362419309483909,-0.359595497288853, -0.348513122180982]; %SS velocities input 
%by hand to save compute time
%USS=[256 mesh, 128 mesh, 64 mesh]
pu=log((USS(3)-USS(2))/(USS(2)-USS(1)))/log(r); %Calculates p
f0u=USS(1)+((USS(1)-USS(2))/(r^pu-1)); %calculates F at h=0

GCI12u=1.25*((abs((USS(1)-USS(2))/USS(1))/(r^pu-1))); %Grid Convergence 
%Index from mesh 1-->2
GCI23u=1.25*((abs((USS(2)-USS(3))/USS(2))/(r^pu-1))); %Grid Convergence 
%Index from mesh 2-->3

AROCu=(GCI12u/GCI23u)*r^pu; %Asymptotic Range Of Convergence

%%%% V velocity GCI
VSS=[0.059631647502226,0.059333124782174, 0.058124619972280];

pv=log((VSS(3)-VSS(2))/(VSS(2)-VSS(1)))/log(r); %Calculates p
f0v=USS(1)+((VSS(1)-VSS(2))/(r^pv-1)); %calculates F at h=0

GCI12v=1.25*((abs((VSS(1)-VSS(2))/VSS(1))/(r^pv-1))); %Grid Convergence 
%Index from mesh 1-->2
GCI23v=1.25*((abs((VSS(2)-VSS(3))/VSS(2))/(r^pv-1))); %Grid Convergence 
%Index from mesh 2-->3

AROCv=(GCI12v/GCI23v)*r^pv; %Asymptotic Range Of Convergence
