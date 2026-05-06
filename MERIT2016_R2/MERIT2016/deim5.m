function [sys,x0,str,ts] =deim5(t,x,u,flag,Tsamp,in)

switch flag,

% Initialization %
%%%%%%%%%%%%%%%%%%
case 0,
[sys,x0,str,ts]=mdlInitializeSizes(Tsamp,in);


% Update %
%%%%%%%%%%
case 2,
sys=mdlUpdate(t,x,u,in);

% Outputs %
%%%%%%%%%%%
case 3,
sys=mdlOutputs(t,x,u,in);
    
case {1,4,9} %Unused flags
sys=[];
      
otherwise
error(['Unhandled flag = ',num2str(flag)]);

end

% end sfuntmpl

%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
function [sys,x0,str,ts]=mdlInitializeSizes(Tsamp,in)
       
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = in;
sizes.NumOutputs     = in;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

x0 =zeros(in,1);

str = [];

ts  = [Tsamp 0];

% end mdlInitializeSizes

%=============================================================================
% mdlUpdate
%=============================================================================
function sys=mdlUpdate(t,x,u,in)

if in~=2
   if in==4
      sys=[u;0;0];
   else
      sys=[0;0;u;x(3:in-2)];
   end;   
else
   sys=[];
end;

% end mdlUpdate

%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
function sys=mdlOutputs(t,x,u,in)

if in~=2
   x(1:2)=u;
   sys=x;
else
   sys=u;
end;



%end md1Update
   
