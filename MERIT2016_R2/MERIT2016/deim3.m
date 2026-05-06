function [sys,x0,str,ts] =deim3(t,x,u,flag,Tsamp,nin,k)

switch flag,

% Initialization %
%%%%%%%%%%%%%%%%%%
case 0,
[sys,x0,str,ts]=mdlInitializeSizes(Tsamp,nin,k);


% Update %
%%%%%%%%%%
case 2,
sys=mdlUpdate(t,x,u,nin,k);

% Outputs %
%%%%%%%%%%%
case 3,
sys=mdlOutputs(t,x,u,nin,k);
    
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
function [sys,x0,str,ts]=mdlInitializeSizes(Tsamp,nin,k)
       
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = k;
sizes.NumOutputs     = k;
sizes.NumInputs      = nin;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);
x0  =zeros(k,1);

   
str = [];

ts  = [Tsamp 0];

% end mdlInitializeSizes

%=============================================================================
% mdlUpdate
%=============================================================================
function sys=mdlUpdate(t,x,u,nin,k)

if nin~=1
   sys=[];
else
   sys=[0;u;x(2:k-1)];  
end;
% end mdlUpdate

%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
function sys=mdlOutputs(t,x,u,nin,k)
if nin~=1
    sys=u;
 else
    x(1)=u;
    sys=x;
end;
  
%end md1Update
   
