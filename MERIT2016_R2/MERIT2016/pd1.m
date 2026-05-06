function [sys,x0,str,ts] = pd1(t,x,u,flag,Bactive,typed,dint,h,h2,H_mag,H_ang,fig)
%
%
switch flag,
  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
     [sys,x0,str,ts]=mdlInitializeSizes(dint); 
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
   	 sys=mdlOutputs(t,x,u,Bactive,typed,h,h2,H_mag,H_ang,fig);

  %%%%%%%%%%%%%%%%%%%%%%%
  % GetTimeOfNextVarHit %
  %%%%%%%%%%%%%%%%%%%%%%%
  	case 4,
   	 sys=mdlGetTimeOfNextVarHit(t,x,u);

  %%%%%%%%%%%%%
  % Terminate %
  %%%%%%%%%%%%%
  	case 9,
   	 sys=mdlTerminate(t,x,u,Bactive,typed,h,h2,H_mag,H_ang,fig);

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
function [sys,x0,str,ts]=mdlInitializeSizes(dint);
%
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 0;
sizes.NumInputs      = -1;
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
ts  = [dint 0];
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

sys=[];
% end mdlUpdate
%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t,x,u,Bactive,typed,h,h2,H_mag,H_ang,fig)

if Bactive == 1 & typed==1
   set(fig,'closereq','');
   figure(fig);
   set(gcf,'currentaxes',h2(fig));
   cla;
   gx=line([-1,1],[0,0],'color','k','LineStyle',':');
   gy=line([0 0],[-1,1],'color','k','LineStyle',':');
   tmpx=zeros(2,6);
   tmpy=zeros(2,6);
   siu=length(u);
   m=0;
   for k=1:2:12
      m=m+1;  
      if k<= siu
         temp(m)=u(k);
         tempy(2,m)=u(k)*sin(u(k+1)*pi/180);
         tempx(2,m)=u(k)*cos(u(k+1)*pi/180);
         strm(m)={num2str(u(k),'%5.2f')};
         stra(m)={num2str(u(k+1),'%5.0f')};
      else
         strm(m)={' '};
         stra(m)={' '};
         tempx(2,m)=0;
         tempy(2,m)=0;
      end;
   end;
   norm=max(temp);
   tmpx=tempx/norm;
   tmpy=tempy/norm;
   li=line(tmpx,tmpy,'Linewidth',1.25);
   m=0;
   for k=1:6
      set(H_mag(fig,k),'string', [strm(k)]);
      set(H_ang(fig,k),'string',[stra(k)]);
   end;
end;
sys=[];
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
function sys=mdlTerminate(t,x,u,Bactive,typed,h,h2,H_mag,H_ang,fig)


if Bactive == 1
   figure(fig);
   set(gcf,'currentaxes',h2(fig));
   cla;
   gx=line([-1,1],[0,0],'color','k','LineStyle',':');
   gy=line([0 0],[-1,1],'color','k','LineStyle',':');
   tempx=zeros(2,6);
   tempy=zeros(2,6);
   siu=length(u);
   m=0;
   for k=1:2:12
      m=m+1;  
      if k<= siu
         temp(m)=u(k);
         tempx(2,m)=u(k)*cos(u(k+1)*pi/180);
         tempy(2,m)=u(k)*sin(u(k+1)*pi/180);
         strm(m)={num2str(u(k),'%5.2f')};
         stra(m)={num2str(u(k+1),'%5.0f')};
      else
         strm(m)={' '};
         stra(m)={' '};
         tempx(2,m)=0;
         tempy(2,m)=0;
      end;
   end;
   norm=max(temp);
   tempx=tempx/norm;
   tempy=tempy/norm;
   li=line(tempx,tempy,'Linewidth',1.25);
   m=0;
   for k=1:6
      set(H_mag(fig,k),'string', [strm(k)]);
      set(H_ang(fig,k),'string',[stra(k)]);
   end;
   set(gcf,'closereq','closereq');
end;
sys = [];

% end mdlTerminate
