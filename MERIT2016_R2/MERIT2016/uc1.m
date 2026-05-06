function [sys,x0,str,ts] = ucblock(t,x,u,flag,k,k1,aux,Ipickup,fs)
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
      sys=mdlUpdate(t,x,u,k,k1,aux,Ipickup,fs);
      
  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  	case 3,
   	 sys=mdlOutputs(t,x,u,k,k1,aux,Ipickup,fs);

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
sizes.NumDiscStates  = 4;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

%
% initialize the initial conditions
%
x0  = zeros(4,1);
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
function sys=mdlUpdate(t,x,u,k,k1,aux,Ipickup,fs)
%variable aux contains the type of comparison
switch aux,
case 0,
   %signal>threshold
   if x(1)==0
      comp=Ipickup;
   else
      comp=Ipickup*k1;
   end;
   if u(1)>comp
      sys=[1 0 0 0];
   else
      sys=[0 0 0 0];
   end;
case 1,
   %signal < threshold
   if x(1)==0
      comp=Ipickup;
   else
      comp=Ipickup*k1;
   end;
   if u(1)<comp
      sys=[1 0 0 0];
   else
      sys=[0 0 0 0];
   end;
case {4,6,7,8,10}
   if u(1)>Ipickup & x(3)==0
      sys=[0 t 1 0];
   else
      sys=[0 0 0 0];
   end;
   if x(3)==1
      In=u(1)/Ipickup;
      if In>1
         sys=[0 x(2) 1 0];
      else
         sys=[0 0 0 0];
      end;
   end;
case 9,
   if u(1)>=Ipickup & x(3)==0
      sys=[0 t 1 0];
   else
      sys=[0 0 0 0];
   end;
   if x(3)==1
      In=u(1)/Ipickup;
      if In>=1
         sys=[0 x(2) 1 0];
      else
         sys=[0 0 0 0];
      end;
   end;
case {5,11,12,13,15}   
   %Calculation of integral of current
   if u(1)<Ipickup
      x(3)=0;
   end; 
   if u(1)>Ipickup & x(3)==0
      sys=[0 t 1 u(1)];
   else
      sys=[0 0 0 0];
   end;
   if x(3)==1
      sum = u(1)+x(4);
      time = t-x(2);
      In=sum/(fs*2*time*Ipickup);
      sum=sum+u(1);
      if In>1
         sys=[0 x(2) 1 sum];
      else
         sys=[0 0 0 0];
      end;   
   end;
case 14,
   %Calculation of integral of current
   if u(1)<Ipickup
      x(3)=0;
   end;
   if u(1)>=Ipickup & x(3)==0
      sys=[0 t 1 u(1)];
   else
      sys=[0 0 0 0];
   end;
   if x(3)==1
      sum = u(1)+x(4);
      time = t-x(2);
      In=sum/(fs*2*time*Ipickup);
      sum=sum+u(1);
      if In>=1
         sys=[0 x(2) 1 sum];
      else
         sys=[0 0 0 0];
      end;   
   end;
otherwise,
   sys=[0 0 0 0];
end;
% end mdlUpdate
%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t,x,u,k,k1,aux,Ipickup,fs)
switch aux,
case 0,
   %signal>threshold
   if x(1)==0
      comp=Ipickup;
   else
      comp=Ipickup*k1;
   end;
   if u(1)>comp
      sys=1;
   else
      sys=0;
   end;
case 1,
   %signal < threshold
   if x(1)==0
      comp=Ipickup;
   else
      comp=Ipickup*k1;
   end;
   if u(1)<comp
      sys=1;
   else
      sys=0;
   end;
case 2,
   %signal > signal
   if u(1)>u(2)
      sys=1;
   else
      sys=0;
   end;
case 3,
   %signal < signal
   if u(1)<u(2)
      sys=1;
   else
      sys=0;
   end;
case 4,
   %time-defined, instantaneous value of input signal 
   if x(3)==1
      In=u(1)/Ipickup;
      if In>1
         time=t-x(2);
         if time>k
            sys=1;
         else
            sys=0;
         end;
      else
         sys=0;
      end;
   else
      sys=0;
   end;
case 5,
   %time-defined, Integral of input signal.
   if x(3)==1
      sum = u(1)+x(4);
      time=t-x(2);
      In = sum/(fs*2*time*Ipickup);
      if In>1
        if time>k
           sys=1;
        else
           sys=0;
        end;
      else
         sys= 0;   
      end;       
   else
      sys=0;
   end;
case 6
   %inverse-time. Instantaneous value of input signal.
   if x(3)==1
      In=u(1)/Ipickup;
      if In>1
         time=t-x(2);
         top=0.14*k/(In^(0.02)-1);
         if time>top
            sys=1;     
         else
            sys=0;
         end;
      else
         sys=0;
      end;
   else
      sys=0;
   end;
case 7
   %very inverse-time. Instantaneous value of signal.
   if x(3)==1
      In=u(1)/Ipickup;
      if In>1
         time=t-x(2);
         top=13.5*k/(In-1);
         if time>top
            sys=1;
         else
            sys=0;
         end;
      else
         sys=0;
      end;
   else
      sys=0;
   end;
case 8
   %extremely inverse. Instantaneous value of signal.
   if x(3)==1
      In=u(1)/Ipickup;
      if In>1
         time=t-x(2);
         top=80*k/(In^2-1);
         if time>top
            sys=1;
         else
            sys=0;
         end;
      else
         sys=0;
      end;   
   else
      sys=0;
   end;
case 9
   %R-I inverse. Instantaneous value of signal
   if x(3)==1
      In=u(1)/Ipickup;
      if In>=1
         time=t-x(2);
         top=k*(3.1)*(1+2.2/In^2.2);
         if time>top
            sys=1;
         else
            sys=0;
         end;
      else
         sys=0;
      end;   
   else
      sys=0;
   end;
case 10 
   %Long time inverse. Instantaneous value of signal.
   if x(3)==1
      In=u(1)/Ipickup;
      if In>1
         time=t-x(2);
         top=120*k/(In-1);
         if time>top
            sys=1;
         else
            sys=0;
         end;
      else
         sys=0;
      end;   
   else
      sys=0;
   end;
case 11, 
   %Inverse time. Integral of input signal.
   if x(3)==1
      sum = u(1)+x(4);
      time = t-x(2);
      In=sum/(fs*2*time*Ipickup);
      if In>1
         top=0.14*k/(In^(0.02)-1);
         if time>top
            sys=1;
         else
            sys=0;
         end;
      else
         sys=0;
      end;   
   else
      sys=0;
   end;
case 12,
   %Very Inverse time. Integral of input signal.
   if x(3)==1
      sum = u(1)+x(4);
      time = t-x(2);
      In=sum/(2*fs*time*Ipickup);
      if In>1
         top=13.5*k/(In-1);
         if time>top
            sys=1;
         else
            sys=0;
         end;
      else
         sys=0;
      end;   
   else
      sys=0;
   end;
case 13,
   %Extremely Inverse time. Integral of input signal.
   if x(3)==1
      sum = u(1)+x(4);
      time = t-x(2);
      In=sum/(2*fs*time*Ipickup);
      if In>1
         top=80*k/(In^2-1);
         if time>top
            sys= 1; 
         else
            sys=0; 
         end;
      else
         sys=0;
      end;
   else
      sys=0;
   end;
case 14,
   %R-I inverse. Integral of input signal.
   if x(3)==1
      sum = u(1)+x(4);
      time = t-x(2);
      In=sum/(2*fs*time*Ipickup);
      if In>=1
         top=k*(3.1)*(1+2.2/In^2.2);
         if time>top
            sys= 1;
         else
            sys=0;
         end;
      else
         sys=0;
      end;   
   else
      sys=0;
   end;
case 15,
   %Long time inverse. Integral of input signal.
   if x(3)==1
      sum = u(1)+x(4);
      time = t-x(2);
      In=sum/(2*fs*time*Ipickup);
      if In>1
         top=120*k/(In-1);
         if time>=top
            sys=1;
         else
            sys=0;
         end;
      else
         sys=0;
      end;   
   else
      sys=0;
   end;
otherwise,
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
