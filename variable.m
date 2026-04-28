Vac = 225000;
default = 0;
if default == 1
    %Default values  
    sub_posR = 0.1153;
    sub_zeroR = 0.4138;

    sub_posInd = 1.05e-3;
    sub_zeroInd = 3.32e-3;

    sub_posCap = 11.33e-009;
    sub_zeroCap = 5.01e-009;
    
    ohl_posR = 0.111;
    ohl_zeroR = 0.4138;
    
    ohl_posInd = 1.05e-3;
    ohl_zeroInd = 3.32e-3;
    
    ohl_posCap = 11.33e-009; 
    ohl_zeroCap = 5.01e-009;
    
    transfo_R1 = 0.00083333;
    transfo_L1 = 0.025;
    transfo_R2 = 0.00083333;
    transfo_L2 = 0.025;
    transfo_Rm = 500;
    transfo_Lm = Inf;
elseif default == 0
    % Onze submarine waarden submarine
    sub_posR = 0.036;
    sub_zeroR = 0.09;
    
    sub_posR = sub_posR/2;
    sub_zeroR = sub_zeroR/2;

    sub_posInd = 0.0014;
    sub_zeroInd = 0.0035;
    
    sub_posInd = sub_posInd/2;
    sub_zeroInd = sub_zeroInd/2;

    sub_posCap = 0.16e-006;
    sub_zeroCap = 0.064e-006;
    
    sub_posCap = sub_posCap*2;
    sub_zeroCap = sub_zeroCap*2;

    
%     sub_posCap = 0.005e-006;
%     sub_zeroCap = 0.0016e-006;
    
%     ohl_posR = 0.069/2;
%     ohl_zeroR = 0.207/2;
%     %     ohl_posInd = 0.001145916/2;
%     ohl_zeroInd = 0.00343775/2;
    
%     ohl_posCap = 0.01e-006/2; 
%     ohl_zeroCap = 0.003333e-006/2;
%ONZE OHL WAARDEN
%     ohl_posR = 0.1153/16;
%     ohl_zeroR = 0.4138/16;
%     
%     ohl_posInd = (1.05e-3)/16;
%     ohl_zeroInd = (3.32e-3)/16;
%     
%     ohl_posCap = (11.33e-009)*16; 
%     ohl_zeroCap = (5e-009)*16;
    
    ohl_posR = 0.0702/12;
    ohl_zeroR = 0.2184/12;
    
    ohl_posInd = (1.2742e-3)/12;
    ohl_zeroInd = (2.2385e-3)/12;
    
    ohl_posCap = (0.00903e-009)*12; 
    ohl_zeroCap = (0.00542e-009)*12;
    
    
    
    
%     ohl_posR = ohl_posR*5;
%     ohl_zeroR = ohl_zeroR*5;
%     
%     %ohl_posInd = ohl_posInd*5;
%     %ohl_zeroInd = ohl_zeroInd*5;
%     
%     ohl_posCap = ohl_posCap*5; 
%     ohl_zeroCap = ohl_zeroCap*5;
%     
    
%     sum_posR = sub_posR + ohl_posR;
%     sum_zeroR = sub_zeroR + ohl_zeroR;
%     
%     sum_posInd = sub_posInd + ohl_posInd;
%     sum_zeroInd = sub_zeroInd + ohl_zeroInd;
%     
%     sum_posCap = sub_posCap + ohl_posCap;
%     sum_zeroCap = sub_zeroCap + ohl_zeroCap;
%     
    compensate_power = 2*pi*Vac^2*57*sub_posCap*50;
%     sub_Ind = 40e6;
    sub_Ind = compensate_power/2;
    sub_Cap = 0;
    
    ohl_Ind = 0;
%     ohl_Cap = 2*pi*Vac^2*57*ohl_posInd*50;
    ohl_Cap = 75e6;
    
    transfo_R1 = 0.000866667;
    transfo_L1 = 0.05999374;
    transfo_R2 = 0.00086667;
    transfo_L2 = 0.05999374;
    transfo_Rm = 1875;
    transfo_Lm = 409.4252;
    
    feeder_posR = 0.14;
    feeder_zeroR = 0.42;
    
    feeder_posInd = 0.00040107;
    feeder_zeroInd = 0.00120321;
    
    feeder_posCap = 0.2e-006;
    feeder_zeroCap = 0.08;
    
    compensation = 11e3;
end
    

