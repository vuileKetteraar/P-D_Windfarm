function [sys,x0,str,ts] = deim4(t,x,u,flag,Tsamp,k,meth_sol,num_meth)

switch flag,

  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts]=mdInitializeSizes(Tsamp,k);

  % Update %
  %%%%%%%%%%
  case 2,
    sys=mdlUpdate(t,x,u);

  % Outputs %
  %%%%%%%%%%%
  case 3,
    sys=mdlOutputs(t,x,u,Tsamp,k,meth_sol,num_meth);

  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
  case {1,4,9} %Unused flags
    sys= [];
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);

end;
% end sfuntmpl
%=============================================================================
% md2InitializeSizes
%=============================================================================
function [sys,x0,str,ts]=mdInitializeSizes(Tsamp,k)

sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 2;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 2*k;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);
x0  =zeros(2,1);
str = [];

ts  = [Tsamp 0];

% end mdInitializeSizes
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
function sys=mdlOutputs(t,x,u,Tsamp,k,meth_sol,num_meth)

switch meth_sol, % type of method for solution  
   
   case 1,         %If succesive samples
     switch num_meth,
      case 1,    % If Euler    
        a=u(k+1)*u(2*k)-u(k+2)*u(2*k-1);
        b=u(1)*u(2*k-1)-u(k-1)*u(k+1);
        c=u(1)*u(2*k)-u(k-1)*u(k+2);
        if a~=0
           L=Tsamp*(b/a);
           R=(c-b)/a;
        else
           L=0;
           R=0;
        end;
              
      case 2,    %If Trapezoidal rule
        a=u(k+1)*u(2*k)-u(k+2)*u(2*k-1);
        b=(u(1)+u(2))*(u(2*k-1)+u(2*k))-(u(k-1)+u(k))*(u(k+1)+u(k+2));   
        c=(u(1)+u(2))*(u(2*k-1)-u(2*k))-(u(k-1)+u(k))*(u(k+1)-u(k+2));
        if a~=0
          L=(Tsamp/4)*(b/a);
          R=(-c)/(2*a);
        else 
          L=0;
          R=0;
        end;
             
     end;   
      
   case 2,          %If the least square
      switch num_meth,
         
        case 1,    %If Euler       
         a=sum(u(k+1:2*k-1).^2);
         b=sum(u(k+1:2*k-1).^2)-sum(u(k+1:2*k-1).*u(k+2:2*k));
         c=sum((u(k+1:2*k-1)-u(k+2:2*k)).^2);
         d=sum(u(1:k-1).*u(k+1:2*k-1));
         e=sum(u(1:k-1).*(u(k+1:2*k-1)-u(k+2:2*k)));
         if (a*c-b*b)~=0
           L=Tsamp*((d*b-a*e)/(b^2-a*c));  % Inductance
           R=(d*c-b*e)/(a*c-b^2);
         else
           L=0;
           R=0;
         end;
                 
       case 2,     %If trapezoidal rule     
  			a=sum((u(k+1:2*k-1)+u(k+2:2*k)).^2);
         b=sum(u(k+1:2*k-1).^2-u(k+2:2*k).^2);
         c=sum((u(k+1:2*k-1)-u(k+2:2*k)).^2);
         d=sum((u(1:k-1)+u(2:k)).*(u(k+1:2*k-1)+u(k+2:2*k)));
         e=sum((u(1:k-1)+u(2:k)).*(u(k+1:2*k-1)-u(k+2:2*k)));
         if (a*c-b*b)~=0
           L=(Tsamp/2)*((d*b-a*e)/(b^2-a*c));  % Inductance
           R=(d*c-b*e)/(a*c-b^2);
         else
            L=0;
            R=0;
         end;
      end;
 end;   
sys=[R 2*pi*60*L];       
% end mdlOutputs

