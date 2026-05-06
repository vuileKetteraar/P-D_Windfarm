function [sys,x0,str,ts] =deim2(t,x,u,flag,N,nin,Tsamp,Tw,type_pre)

switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes(N,nin,Tsamp);
 
  %%%%%%%%%%
  % Update %
  %%%%%%%%%%
  case 2,
    sys=mdlUpdate(t,x,u);

  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  case 3,
     sys=mdlOutputs(t,x,u,N,Tsamp,Tw,type_pre);
 
 case {1,4,9} %Unused flags
    sys= [];
 otherwise
    error(['Unhandled flag = ',num2str(flag)]);

end;
% end sfuntmpl
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
function [sys,x0,str,ts]=mdlInitializeSizes(N,nin,Tsamp,type_pre)

sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = N;
sizes.NumOutputs     = nin;
sizes.NumInputs      = N;
sizes.DirFeedthrough = N;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

% x0  =[];
x0 = zeros(N,1);

str = [];

ts  = [Tsamp 0];

% end mdlInitializeSizes
%=============================================================================
% mdlUpdate
%=============================================================================
function sys=mdlUpdate(t,x,u)
sys=[];
% end mdlUpdate
%=============================================================================
% mdlOutputs
%=============================================================================
function sys=mdlOutputs(t,x,u,N,Tsamp,Tw,type_pre)
l=0;
if t==0
    u=zeros(length(u),1);
end
switch type_pre
   case 3,
    for i=0:(round(N/2))
       ak=sin((pi*Tsamp/Tw)*((round(N/4))-i));
       l=l+ak*u(N-i);
    end;
        
   case 2,
     for i=0:(round(N/4))
      ak=sin((pi*Tsamp/(2*Tw))*((round(N/8))-i));
      l=l+ak*u(N-i);
     end;
     
   case 5,
      for i=0:(round(N/2))
       l=l+u(N-i);
      end;   
       
   
   case 4,
      for i=0:(round(N/4))
       l=l+u(N-i);
      end;   
      
    case 1,
       l=u;
end; 
sys=l;

% end mdlOutputs

