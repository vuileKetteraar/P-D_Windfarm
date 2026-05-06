function [sys,x0,str,ts] = test(t,x,u,flag,TH,p,q,SF,SN,METHOD,ti)
%
% The following outlines the general structure of an S-function.
%
switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes(SF,SN);

  %%%%%%%%%%%%%%%
  % Derivatives %
  %%%%%%%%%%%%%%%
  case 1,
    sys=[];

  %%%%%%%%%%
  % Update %
  %%%%%%%%%%
  case 2,
    sys=mdlUpdate(t,x,u,TH,p,q,SF,SN,METHOD,ti);

  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  case 3,
    sys=mdlOutputs(t,x,u);

  %%%%%%%%%%%%%%%%%%%%%%%
  % GetTimeOfNextVarHit %
  %%%%%%%%%%%%%%%%%%%%%%%
  case 4,
    sys=[];

  %%%%%%%%%%%%%
  % Terminate %
  %%%%%%%%%%%%%
  case 9,
    sys=[];

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
function [sys,x0,str,ts]=mdlInitializeSizes(SF,SN)

%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
% Note that in this example, the values are hard coded.  This is not a
% recommended practice as the characteristics of the block are typically
% defined by the S-function parameters.
%
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 4;
sizes.NumOutputs     = 1;
sizes.NumInputs      = SN;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

%
% initialize the initial conditions
%
x0  = [0,0,0,0];

%
% str is always an empty matrix
%
str = [];

%
% initialize the array of sample times
%
ts  = [1/SF 0];

% end mdlInitializeSizes

%
%
%=============================================================================
% mdlUpdate
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%=============================================================================
%
function sys=mdlUpdate(t,x,u,TH,p,q,SF,SN,METHOD,ti)

OUT=x(2);
PC=x(3);
QC=x(4);

%u
%pause
% CALCULATE TC
if t>=ti
   switch METHOD     
   case 1, % Value
      if abs(u(1))>=TH
         TC=1;
      else
         TC=0;
      end;

	case 2, % Sample to sample
      if abs(u(1)-u(2))>=TH
         TC=1;
      else
         TC=0;
      end;
      
   case 3, % Cycle to cycle
      if abs(u(1)-x(1))>=TH
         TC=1;
      else
         TC=0;
      end;
      
  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
   otherwise
      error(['Unhandled flag = ',num2str(flag)]);
   end;
else
   TC=0;
end;
if TC==1
   if OUT~=1
      PC=PC+1;
      if PC==p
         PC=0;
         QC=0;
         OUT=1;
      else
         OUT=0;
      end;
   else
      PC=0;
      QC=0;
      OUT=1;   
   end;
end;

if TC==0
   if OUT==1
      QC=QC+1;
      if QC==q
         OUT=0;
         PC=0;
         QC=0;
      else
         OUT=1;
      end;
   else
      PC=0;
      QC=0;
      OUT=0;
   end;
end;   

sys=[u(SN),OUT,PC,QC];
%sys=[COUNT,OUT,PC,QC];
% end mdlUpdate

%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t,x,u)

sys=x(2);

% end mdlOutputs

