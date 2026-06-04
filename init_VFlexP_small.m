simulink_name = 'VFlexP_small';
block = [simulink_name '/Grid'];
load_system(simulink_name)

Vb = 400; % Base voltage
omegab = 2*pi*50; % 50 Hz nominal frequency
Sb = 15e3; % Base power 
Zb = Vb^2/Sb; 
Lb = Zb/omegab;
Ib = Sb/(1*Vb);
Cb = 1/(omegab*Zb);
 
% Control in real to pu
Tf = 0.01; % P&Q filter
mp =  2e-4*Sb/omegab;
Hv = 5;
mD = 0/Sb;
nq =  1e-4*Sb/Vb;
Kpv = 0.12*Vb/Ib; 
Kiv = 36.29*Vb/Ib; 
Kpc = 4.53*Ib/Vb;
Kic = 1.056e4*Ib/Vb;
Fi =  1;

% LCL fiter in pu
Rf = 0.001;
Rcf_Vcc = 100;
Lf = 0.01;
Cf = 0.1;
Rc = 0.001;
Lc = 0.01;

% Virtual impedance
VI_R = 0*0.005;
VI_L = 0*0.05;
WOF_Tf = 0*0.01;

% Control parameters
Kp_id = 0.4;
Kp_theta = 0.2;
Kp_w = 0.15;
Ki_w = 10;

% Control parameters
Kp_id = 0.7;
Kp_theta = 0.3;
Kp_w = 0.3;
Ki_w = 10;

set_param([block ...
    '/Dynamic/Generators/GFr'], 'mp', 'mp')
set_param([block ...
    '/Dynamic/Generators/GFr'], 'Tf', 'Tf')
% Set control parameters
set_param([block ...
    '/Dynamic/Generators/GFr'], 'dynamic_VCC', 'Static')
set_param([block ...
    '/Dynamic/Generators/GFr'], 'R_out', 'Rc')
set_param([block ...
    '/Dynamic/Generators/GFr'], 'L_out', 'Lc')
set_param([block ...
    '/Dynamic/Generators/GFr'], 'mD', 'mD')

% Set control parameters
set_param([block ...
    '/Dynamic/DCAC converters/DC_VSM'], 'dynamic_VCC', 'Dynamic with P limitation')
set_param([block ...
    '/Dynamic/DCAC converters/DC_VSM'], 'Hv', 'Hv')
set_param([block ...
    '/Dynamic/DCAC converters/DC_VSM'], 'Rv', 'mp')
set_param([block ...
    '/Dynamic/DCAC converters/DC_VSM'], 'Dv', '0')
set_param([block ...
    '/Dynamic/DCAC converters/DC_VSM'], 'Kext', 'Kpv')
set_param([block ...
    '/Dynamic/DCAC converters/DC_VSM'], 'Text', 'Kpv/Kiv')
set_param([block ...
    '/Dynamic/DCAC converters/DC_VSM'], 'Bext', '1')
set_param([block ...
    '/Dynamic/DCAC converters/DC_VSM'], 'Kint', 'Kpc')
set_param([block ...
    '/Dynamic/DCAC converters/DC_VSM'], 'Tint', 'Kpc/Kic')
set_param([block ...
    '/Dynamic/DCAC converters/DC_VSM'], 'Bint', '1')
set_param([block ...
    '/Dynamic/DCAC converters/DC_VSM'], 'Fi', 'Fi')

% Set LCL filter parameters
set_param([block ...
    '/Dynamic/DCAC converters/DC_VSM'], 'Rf', 'Rf')
set_param([block ...
    '/Dynamic/DCAC converters/DC_VSM'], 'Lf', 'Lf')
set_param([block ...
    '/Dynamic/DCAC converters/DC_VSM'], 'Cfi', 'Cf')
set_param([block ...
    '/Dynamic/DCAC converters/DC_VSM'], 'R_out', 'Rc')
set_param([block ...
    '/Dynamic/DCAC converters/DC_VSM'], 'L_out', 'Lc')

% Set virtual impedance parameters
set_param([block ...
    '/Dynamic/DCAC converters/DC_VSM'], 'VI_R', 'VI_R')
set_param([block ...
    '/Dynamic/DCAC converters/DC_VSM'], 'VI_L', 'VI_L')
set_param([block ...
    '/Dynamic/DCAC converters/DC_VSM'], 'WOF_Tf', 'WOF_Tf')

set_param([block ...
    '/Dynamic/Generators/IG/RL out'], 'dynamic', 'Dynamic')

set_param(block, 'define_SC_in_MATLAB', 'on')
set_param(block, 'SC_structure', 'No SC')


out = sim(simulink_name);
save results\out_small.mat