function [sys,x0,str,ts] = bm2(t,x,u,flag,tpost,plen)
%   bm2.m
%   version 0.1
%   04/17/98
%   The template of this s-function is sfundsc1.m

%SFUNDSC1 Example memory M-file S-function with inherited sample time
%   This M-file S-function is an example of how to implement an
%   inherited sample time S-function which has state. The actual sample
%   time will be determined by what is driving this S-function. It may
%   be continuous or discrete. This S-function uses one discrete state 
%   element as storage such that the previous input is provided at the 
%   output.
%   


switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
   [sys,x0,str,ts]=mdlInitializeSizes(plen);
  
  %%%%%%%%%%  
  % Update %
  %%%%%%%%%%
  case 2,                                               
    sys = mdlUpdate(t,x,u,plen);
    
  %%%%%%%%%%
  % Output %
  %%%%%%%%%%
  case 3,                                               
    sys = mdlOutputs(t,x,u,tpost,plen);    

  %%%%%%%%%%%%%
  % Terminate %
  %%%%%%%%%%%%%
  case {1,4,9},                                               
    sys = [];

  otherwise
    error(['unhandled flag = ',num2str(flag)]);
end

%end sfunoc92

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts]=mdlInitializeSizes(plen)

sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = plen;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;

sys = simsizes(sizes);

% state variable x
% 1:plen history value
% plen-th number of data which have been fed into
%			the post-process filter

x0 = zeros(plen,1);
x0(plen) = 1;
str = [];
ts  = [-1 0]; % Inherited sample time

% end mdlInitializeSizes

%
%=======================================================================
% mdlUpdate
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%=======================================================================
%
function sys = mdlUpdate(t,x,u,plen)

temp = x(plen) + 1;
if temp > plen
	temp = plen;
end;	
sys = [u; x(1:plen-2); temp];

% end mdlUpdate

%
%=======================================================================
% mdlOutputs
% Return the output vector for the S-function
%=======================================================================
%
function sys = mdlOutputs(t,x,u,tpost,plen)
switch tpost
case 1,	% none filter
   sys = u;
case 2,	% mean filter
   temp = x(plen);
   sys = ( u+sum( x(1:temp-1) )) / temp;
case 3,	% median filter
   temp = x(plen);
   tmpvec = [u; x(1:temp-1)];	
   sys = median( tmpvec );
end;
%end mdlOutputs
