function [sys,x0,str,ts] = bm1(t,x,u,flag)
%   bm1.m
%   version 0.1
%   03/30/98
%   The template of this s-function is sfundsc1.m

%SFUNDSC1 Example memory M-file S-function with inherited sample time
%   This M-file S-function is an example of how to implement an
%   inherited sample time S-function which has state. The actual sample
%   time will be determined by what is driving this S-function. It may
%   be continuous or discrete. This S-function uses one discrete state 
%   element as storage such that the previous input is provided at the 
%   output.
%   

switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
   [sys,x0,str,ts]=mdlInitializeSizes;
  
  %%%%%%%%%%  
  % Update %
  %%%%%%%%%%
%  case 2,                                               
%    sys = mdlUpdate(t,x,u);
    
  %%%%%%%%%%
  % Output %
  %%%%%%%%%%
  case 3,                                               
    sys = mdlOutputs(t,x,u);    

  %%%%%%%%%%%%%
  % Terminate %
  %%%%%%%%%%%%%
  case {1,2,4,9},                                               
    sys = [];

  otherwise
    error(['unhandled flag = ',num2str(flag)]);
end

%end sfunbm

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts]=mdlInitializeSizes

sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 2;
sizes.NumOutputs     = 6;
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;

sys = simsizes(sizes);

x0 = [0 0];
str = [];
ts  = [-1 0]; % Inherited sample time

% end mdlInitializeSizes

%
%=======================================================================
% mdlUpdate
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%=======================================================================
%
function sys = mdlUpdate(t,x,u)
sys=[];
% end mdlUpdate
%
%=======================================================================
% mdlOutputs
% Return the output vector for the S-function
%=======================================================================
%
function sys = mdlOutputs(t,x,u)

sys(1) = u(1);
sys(2) = u(3);
ang=u(2)*pi/180;
ang2=u(4)*pi/180;
temp= u(1)*cos(ang)+i*u(1)*sin(ang);
temp2= u(3)*cos(ang2)+i*u(3)*sin(ang2);
S=temp*conj(temp2);
sys(3) = real(S);
sys(4) = imag(S);
if temp2==0
   sys(5)=inf;
   sys(6)=inf;
else
   z=temp/temp2;
   sys(5)=real(z);
   sys(6)=imag(z);
end;
%end mdlOutputs


