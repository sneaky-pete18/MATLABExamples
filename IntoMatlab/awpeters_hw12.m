clear all
clc
close all

%% 1.1 circles

syms('t'); %defines t as symbolic
x=cos(t);
y=sin(t);


figure %new fig.
ezplot(x,y,[0 2*pi]) %plots x vs. y over 0-2pi

%% 1.2 integration
syms('X'); %defines X as symbol
F=1./(X^2+X);   %functions
G=log(sinh(X^2));
H=3.*cosh(X./3);

Fint=int(F,X,1,inf) %integral of F
Gdiff=diff(G,X) %derivative of G
syms('a'); %defines a as symbol
Hint=int(H,X,-a,a) %integral of H

%% 1.3 Structures and cells

MyCell= cell(3,1);
MyCell{1,1}=F;
MyCell{2,1}=G;
MyCell{3,1}=H;
MyCell

MyCell_v2= cell(3,1);
MyCell_v2{1,1}='F=1./(X^2+X)';
MyCell_v2{2,1}='G=log(sinh(X^2))';
MyCell_v2{3,1}='H=3.*cosh(X./3)';
MyCell_v2

MyStructure.x='cos(t)';
MyStructure.y='sin(t)';
MyStructure.t=[0 2*pi];
MyStructure


