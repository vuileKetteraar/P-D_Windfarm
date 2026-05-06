function [sys,x0,str,ts] =deim6(t,x,u,flag,Tsamp,in,type_post)

switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes(Tsamp,in);
    
  %%%%%%%%%%
  % Update %
  %%%%%%%%%%
case 2,
    sys=mdlUpdate(t,x,u);

  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
case 3,
    sys=mdlOutputs(t,x,u,in,type_post);

case {1,4,9}  %Unhandled flags
   sys=[];

otherwise
    error(['Unhandled flag = ',num2str(flag)]);

end;

% end sfuntmpl
%=============================================================================
% mdlInitializeSizes
%=============================================================================
function [sys,x0,str,ts]=mdlInitializeSizes(Tsamp,in)

sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 2;
sizes.NumOutputs     = 2;
sizes.NumInputs      = in;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

x0  =zeros(2,1);

str = [];

ts  = [Tsamp 0];

% end mdlInitializeSizes
%=============================================================================
% mdlUpdate
%=============================================================================
function sys=mdlUpdate(t,x,u)

sys = [];

% end mdlDerivatives
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
function sys=mdlOutputs(t,x,u,in,type_post)

switch type_post   
    case 1,
      sys=u;
      
   case 2,
      z=0;
      z1=0;
       for i=1:2:in-1
          z=z+u(i);
          z1=z1+u(i+1);
          
       end;         
      sys(1)=z/(in/2);
      sys(2)=z1/(in/2);
      
   case 3,
      k=0;
      for i=1:2:in-1
         k=k+1;
         z(k)=u(i);
         z1(k)=u(i+1);
     end;
      k=sort(z);
      k1=sort(z1);
      sys(1)=k(round(in/4));
      sys(2)=k1(round(in/4));

end;

% end mdlOutputs

