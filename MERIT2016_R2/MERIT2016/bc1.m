function [sys,x0,str,ts] = bc1(t,x,u,flag,BC,fs);

[a b] = size(BC);

%Consecutively re-arrange the bias characteristics from the smallest to the largest values 
%of the horizontal axis. 
R = BC(:,1);

for i = 1:a
   for j = (i+1):a
      if R(i) > R(j)
         bin_R 	= R(i);
      	R(i)		= R(j);
      	R(j)		= bin_R;
			
      	bin_BC 	= BC(i,:);
      	BC(i,:)	= BC(j,:);
      	BC(j,:)	= bin_BC;
      end
   end   
end

R = BC(:,1);
O = BC(:,2);

switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes(fs,a);

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
    sys=mdlOutputs(u,R,O,a);    
    
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
function [sys,x0,str,ts]=mdlInitializeSizes(fs,a);


% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
% Note that in this example, the values are hard coded.  This is not a
% recommended practice as the characteristics of the block are typically
% defined by the S-function parameters.
%
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 2;
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

sys = [];

% end mdlUpdate

%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(u,R,O,a);

%determine the region of linear bias characteristic in horizontal exis where contains
%the constraining signal,R. Then, calculate a signal at that value of R. 

if u(2) <= R(1)
   if (R(1)-R(2))==0,
      A=inf;
   else
      A = O(2) + (u(2)-R(2))*(O(1) - O(2))/(R(1) - R(2));
   end;    
elseif u(2) <= R(a-1)   
   for i = 1:(a-1)
      if and((R(i) < u(2)),(u(2)  <= R(i+1)))   
         A = O(i+1) + (u(2)-R(i+1))*(O(i) - O(i+1))/(R(i) - R(i+1));
      end
   end
   
else A = O(a) + (u(2)-R(a))*(O(a-1) - O(a))/(R(a-1) - R(a));
   
end


%conpare the signal computed above with the input-operating signal,O.

if u(1) > A
    sys = 1;
else
    sys = 0;
end
   

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

sampleTime = 1;    %  Example, set the next hit to be one second later.
sys = t + sampleTime;

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
