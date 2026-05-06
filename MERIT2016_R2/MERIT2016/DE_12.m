function [sys,x0,str,ts] = DE_12(t,x,u,flag,alpha,beta,fs)
%
%
switch flag,
  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
     [sys,x0,str,ts]=mdlInitializeSizes(fs); 
  %%%%%%%%%%%%%%%
  % Derivatives %
  %%%%%%%%%%%%%%%
  	case 1,
   	 sys=mdlDerivatives(t,x,u);
  %%%%%%%%%%
  % Update %
  %%%%%%%%%%
   case 2,   
      sys=mdlUpdate(t,x,u);
      
  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  	case 3,
   	 sys=mdlOutputs(t,x,u,alpha,beta);
  %%%%%%%%%%%%%%%%%%%%%%%
  % GetTimeOfNextVarHit %
  %%%%%%%%%%%%%%%%%%%%%%%
  	case 4,
   	 sys=mdlGetTimeOfNextVarHit(t,x,u,fs);
  %%%%%%%%%%%%%
  % Terminate %
  %%%%%%%%%%%%%
  	case 9,
   	 sys=mdlTerminate(t,x,u);
  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
  otherwise,
    error(['Unhandled flag = ',num2str(flag)]);
end

% end sfuntmpl

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts]=mdlInitializeSizes(fs);
%
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

%
% initialize the initial conditions
%
x0  = [];
%
% str is always an empty matrix
%
str = [];
%
% initialize the array of sample times
%
ts  = [1/fs 0];
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
function sys=mdlUpdate(t,x,u)
%variable aux contains the type of comparison
sys = [];

% end mdlUpdate
%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t,x,u,alpha,beta)

dif=u(4)-u(2);
n=abs(fix(dif/360));
if dif>0
   dif=dif-n*360;
else
   dif=dif+n*360;
end;
if abs(dif)>180
   if dif>0
      dif=dif-360;
   else
      dif=dif+360;
   end;           
end;    
if alpha<dif & dif<beta
   sys=1;
else
   sys=0;
end;
% end mdlOutputs
%
%=============================================================================
% mdlGetTimeOfNextVarHit
% Return the time of the next hit for this block.  Note that the result is
% absolute time.  Note that this function is only used when you specify a
% variable discrete-time sample time [-2 0] in the sample time array in
% mdlInitializeSizes.
%=============================================================================
%
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
