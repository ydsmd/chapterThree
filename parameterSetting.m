clc;
clear;
%% 车辆模型
r = 0.42;
vkmh = 100;
v = vkmh/3.6;
A = 0.0001;
Kv = 1.5e6;
Jv = 3044;
Mv = 4060/2;
Cv = 5000;
Kb = 0.267e6;
Jb = 927.8;
Mb = 23000/2;
Cb = 11e3;
d = 2.6;
Mw = 1670/2;
mw = 1670/2;
R = 0.42;
base = Mb*9.8/4+mw*9.8+0.5*9.8*Mv;
%% 弹性轨模型
m = 7800*(7684e-6); % the linear density - kg/m
L = 210; % the span of the simply support bridge - m
E = 2.1e11; % the elastic modulus - N*m^-2
I = 3055e-8; % the innertial moment - m^4
kf = 6.67e7;
position = 0.5*L;
