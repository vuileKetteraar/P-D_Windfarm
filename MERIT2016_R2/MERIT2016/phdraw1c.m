function [sys,x0,str,ts] = pd1(t,x,u,flag,Bactive)
%
%
switch flag,
  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
     [sys,x0,str,ts]=mdlInitializeSizes; 
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
   	 sys=mdlOutputs(t,x,u);

  %%%%%%%%%%%%%%%%%%%%%%%
  % GetTimeOfNextVarHit %
  %%%%%%%%%%%%%%%%%%%%%%%
  	case 4,
   	 sys=mdlGetTimeOfNextVarHit(t,x,u);

  %%%%%%%%%%%%%
  % Terminate %
  %%%%%%%%%%%%%
  	case 9,
   	 sys=mdlTerminate(t,x,u,Bactive);

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
function [sys,x0,str,ts]=mdlInitializeSizes;
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
ts  = [0 0];
global vn;
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
function sys=mdlOutputs(t,x,u)

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
function sys=mdlTerminate(t,x,u,Bactive)

if Bactive==1,
   temp1=gcb;
   tempo=length(gcb);
   bdwidth=5;
   topbdwidth=30;
   set(0,'Units','pixels');
   scnsize=get(0,'ScreenSize');
   fig=figure;
   figNum = 0;
   a=figure(fig);
   if isnumeric(fig)
       figNum = fig;
   else
       figNum = fig.Number;
       a = fig.Number;
   end
   pos=[bdwidth,scnsize(4)-(4/3*1/2*scnsize(4)+4*bdwidth),scnsize(3)/2-2*bdwidth,...
         scnsize(4)/2*4/3-(topbdwidth+bdwidth)];     
   % a=figure(fig);
   % a = fig.Number;
   %close(a);
   %figure(a);
   bdwidth=5;
   topbdwidth=30;
   set(0,'Units','pixels');
   set(a,'userdata',temp1);
   set(a,'position',pos);      
   % set(gcf,'name',strcat('Phasor Display No.',num2str(fig)),'numbertitle','off');         
   set(gcf,'name',strcat('Phasor Display No.',num2str(figNum)),'numbertitle','off');         
   % h(a)=axes('Position',[0 0 1 1],'Vis','off');
   h2(a)=axes('Position',[0.1 0.25 0.8 0.7],'xticklabel',[],'yticklabel',[]);
   % h2(a.Number)=axes('Position',[0.1 0.25 0.8 0.7],'xticklabel',[],'yticklabel',[]);
   set(gcf,'currentaxes',h2(a));
   % set(gcf,'currentaxes',h2(a.Number));
   
   Htitm=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[0 .10 .12 0.04],'string','Mag.');
   Htit(a,1)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.10 .14 .12 0.04],'string','Phase a');
   H_mag(a,1)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.10 .10 .12 0.04],'background',[1 1 1]);
   Htit(a,2)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.236 .14 .12 0.04],'string','Phase b');
   H_mag(a,2)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.236 .10 .12 0.04],'background',[1 1 1]);
   Htit(a,3)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.372 .14 .12 0.04],'string','Phase c');
   H_mag(a,3)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.372 .10 .12 0.04],'background',[1 1 1]);
   Htit(a,4)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.508 .14 .12 0.04],'string','Zero');  
   H_mag(a,4)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.508 .10 .12 0.04],'background',[1 1 1]);
   Htit(a,5)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.644 .14 .12 0.04],'string','Positive');
   H_mag(a,5)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.644 .10 .12 0.04],'background',[1 1 1]);
   Htit(a,6)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.78 .14 .12 0.04],'string','Negative');
   H_mag(a,6)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.78 .10 .12 0.04],'background',[1 1 1]);
   Htita=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.0 .05 .12 0.04],'string','Phase');
   H_ang(a,1)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.10 .05 .12 0.04],'background',[1 1 1]);
   H_ang(a,2)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.236 .05 .12 0.04],'background',[1 1 1]);
   H_ang(a,3)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.372 .05 .12 0.04],'background',[1 1 1]);
   H_ang(a,4)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.508 .05 .12 0.04],'background',[1 1 1]);
   H_ang(a,5)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.644 .05 .12 0.04],'background',[1 1 1]);
   H_ang(a,6)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.78 .05 .12 0.04],'background',[1 1 1]);
   set(a,'closereq','closereq');
   b=uicontrol('Parent',a, ...
	'Units','points', ...
   'Callback','drawphas', ...
   'units','normalized',...
	'Position',[0.45 0.19 .1 .05], ...
	'String','Continue', ...
   'Tag','PBtnDynamics');
   
   figure(fig);
   % set(gcf,'currentaxes',h2(fig));
   set(gcf,'currentaxes',h2(a));
   % figure(fig);
   % set(gcf,'currentaxes',h2(fig.Number));
   
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
   aa=cos(120*pi/180)+i*sin(120*pi/180);
   cont=0;
   temvar=temp;
   cla;
   norma=max(temvar);
   save phas tempx tempy cont aa norma;
   gx=line([-1,1],[0,0],'color','k','LineStyle',':');
   gy=line([0 0],[-1,1],'color','k','LineStyle',':');
   tempxn=tempx/norma;
   tempyn=tempy/norma;
   li=line(tempxn,tempyn,'Linewidth',1.25);
   text(tempxn(2,1)-0.2,tempyn(2,1)+0.1,'Phase a','color','b');
   text(tempxn(2,2),tempyn(2,2)-0.1,'Phase b','color','g');
   text(tempxn(2,3),tempyn(2,3)+0.1,'Phase c','color','r');
   m=0;
   for k=1:3
      %set(H_mag(fig,k),'string', [strm(k)]);
      %set(H_ang(fig,k),'string',[stra(k)]);
      
      set(H_mag(a,k),'string', [strm(k)]);
      set(H_ang(a,k),'string',[stra(k)]);
   end;
   set(gcf,'closereq','closereq');
else
   h=0;
   h2=0;
   H_mag=0;
   H_ang=0;
   fig=1;
end;
sys = [];

% end mdlTerminate
