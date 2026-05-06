function [sys,x0,str,ts] = dft1(t,x,u,flag,window_size,fo,harmonic)
switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes(window_size,fo);

  %%%%%%%%%%%%%%%
  % Derivatives %
  %%%%%%%%%%%%%%%
  case 1,
    sys=mdlDerivatives(t,x,u);

  %%%%%%%%%%
  % Update %
  %%%%%%%%%%
  case 2,
    sys=mdlUpdate(t,x,u,window_size);

  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  case 3,
    sys=mdlOutputs(t,x,u,window_size,fo,harmonic);

  %%%%%%%%%%%%%%%%%%%%%%%
  % GetTimeOfNextVarHit %
  %%%%%%%%%%%%%%%%%%%%%%%
  case 4,
    sys=mdlGetTimeOfNextVarHit(t,x,u);

  %%%%%%%%%%%%%
  % Terminate %
  %%%%%%%%%%%%%
  case 9,
    sys=mdlTerminate(t,x,u);

  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);

end

% end sfuntmpl

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts]=mdlInitializeSizes(window_size,fo)
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = window_size;
sizes.NumOutputs     = 10;
sizes.NumInputs      = window_size;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   
sys = simsizes(sizes);
%
% initialize the initial conditions
%
x0  = zeros(window_size,1);
str = [];
%
% initialize the array of sample times
%
ts  = [1/(window_size*fo) 0];	
% end mdlInitializeSizes
%
%=============================================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%=============================================================================
%
function sys=mdlDerivatives(t,x,u)

sys = [];

% end mdlDerivatives

%
%=============================================================================
% mdlUpdate
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%=============================================================================
%
function sys=mdlUpdate(t,x,u,window_size)

sys = [];

% end mdlUpdate
%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t,x,u,window_size,fo,harmonic)


%Compute coefficient for each harmonic. 
coeff = 2*fft(u)/window_size;

%The zero harmonic(dc signal) 
coeff(1) = coeff(1)/2;
     

%Check for the number of the requested harmonics.
[a b] = size(harmonic);
number_harmonic  = max([a,b]);

w    = -i*2*pi*fo*t;
degree = 180/pi;
sys  = zeros(10,1);
for j = 1:number_harmonic
   order = harmonic(j);
   X     = coeff(order+1)/exp(w*order);
   sys(2*j-1) = abs(X);
   sys(2*j)   = -angle(X)*degree;
end
% end mdlOutputs

function sys=mdlGetTimeOfNextVarHit(t,x,u)

sys = [];

% end mdlGetTimeOfNextVarHit

%
%=============================================================================
% mdlTerminate
% Perform any end of simulation tasks.
%=============================================================================
%
function sys=mdlTerminate(t,x,u)

sys = [];

% end mdlTerminate
