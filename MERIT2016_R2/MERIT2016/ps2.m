function [sys,x0,str,ts] = ps2(t,x,u,flag, THI, THV, THZ, THG, METHOD)

%
% The following outlines the general structure of an S-function.
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
     sys=[];

  %%%%%%%%%%
  % Update %
  %%%%%%%%%%
  case 2,
    sys=[];

  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  case 3,
    sys=mdlOutputs(t,x,u, THI, THV, THZ, THG, METHOD);

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
function [sys,x0,str,ts]=mdlInitializeSizes

%
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 12;
sizes.DirFeedthrough = 0;
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
ts  = [-1 0];

% end mdlInitializeSizes

%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t,x,u, THI, THV, THZ, THG, METHOD)

% check the FLAGs for each method
switch(METHOD),
   case 1, %CURRENT
      [A,B,C,G]=current(THI,THG,u);   
      
   case 2, %VOLTAGE
   	[A,B,C,G]=voltage(THV,THG,u);

   case 3, %IMPEDANCE
   	[A,B,C,G]=impedance(THZ,THG,u);
      
   case 4, %CURRENT AND VOLTAGE
   	[A,B,C,G]=candv(THI,THV,THG,u);
   
   case 5, %CURRENT OR VOLTAGE
   	[A,B,C,G]=corv(THI, THV,THG,u);
      
   case 6, %CURRENT AND IMPEDANCE
   	[A,B,C,G]=candi(THI,THZ,THG,u);
      
   case 7, %CURRENT OR IMPEDANCE
   	[A,B,C,G]=cori(THI,THZ,THG,u);
      
   case 8, %VOLTAGE AND IMPEDANCE
   	[A,B,C,G]=vori(THV,THZ,THG,u);
      
   case 9, %VOLTAGE OR IMPEDANCE
   	[A,B,C,G]=vori(THV,THZ,THG,u);
      
   case 10, %CURRENT AND VOLTAGE AND IMPEDANCE
   	[A,B,C,G]=candvandi(THI,THV,THZ,THG,u);
      
   case 11, %CURRENT OR VOLTAGE OR IMPEDANCE
   	[A,B,C,G]=corvori(THI,THV,THZ,THG,u);
      
   otherwise
    error(['Unhandled METHOD = ',num2str(METHOD)]);

end

sys=detect(A,B,C,G);

      % end mdlOutputs

% functions for different method

% METHOD 1: CURRENT
function	[A,B,C,G]=current(THI,THG,u)

i=sqrt(-1);

IA=u(1)*(cos(u(2)*pi/180)+i*sin(u(2)*pi/180));
IB=u(3)*(cos(u(4)*pi/180)+i*sin(u(4)*pi/180));
IC=u(5)*(cos(u(6)*pi/180)+i*sin(u(6)*pi/180));

IG=abs(IA+IB+IC);

IA=u(1);
IB=u(3);
IC=u(5);

if IA>THI
   A=1;
else
   A=0;
end;

if IB>THI
   B=1;
else
   B=0;
end;

if IC>THI
   C=1;
else
   C=0;
end;

if IG<THG
   G=1;
else
   G=0;
end;
% END OF METHOD 1

% METHOD 2: VOLTAGE
function	[A,B,C,G]=voltage(THV,THG,u)

i=sqrt(-1);

VA=u(7);
VB=u(9);
VC=u(11);

IG=u(1)*cos(u(2)*pi/180)+u(3)*cos(u(4)*pi/180)+u(5)*cos(u(6)*pi/180)+...
   i*(u(1)*sin(u(2)*pi/180)+u(3)*sin(u(4)*pi/180)+u(5)*sin(u(6)*pi/180));
IG=abs(IG);

if VA<THV
   A=1;
else
   A=0;
end;

if VB<THV
   B=1;
else
   B=0;
end;

if VC<THV
   C=1;
else
   C=0;
end;

if IG<THG
   G=1;
else
   G=0;
end;

% END OF METHOD 2

% METHOD 3: IMPEDANCE
function	[A,B,C,G]=impedance(THZ,THG,u)

i=sqrt(-1);

VA=u(7);
VB=u(9);
VC=u(11);

IA=u(1);
IB=u(3);
IC=u(5);

ZA=VA/IA;
ZB=VB/IB;
ZC=VC/IC;

IG=u(1)*cos(u(2)*pi/180)+u(3)*cos(u(4)*pi/180)+u(5)*cos(u(6)*pi/180)+...
   i*(u(1)*sin(u(2)*pi/180)+u(3)*sin(u(4)*pi/180)+u(5)*sin(u(6)*pi/180));
IG=abs(IG);

if ZA<THZ
   A=1;
else
   A=0;
end;

if ZB<THZ
   B=1;
else
   B=0;
end;

if ZC<THZ
   C=1;
else
   C=0;
end;

if IG<THG
   G=1;
else
   G=0;
end;

% END OF METHOD 3


% METHOD 4: CURRENT AND VOLTAGE
function	[A,B,C,G]=candv(THI,THV,THG,u)

i=sqrt(-1);

VA=u(7);
VB=u(9);
VC=u(11);

IA=u(1);
IB=u(3);
IC=u(5);

IG=u(1)*cos(u(2)*pi/180)+u(3)*cos(u(4)*pi/180)+u(5)*cos(u(6)*pi/180)+...
   i*(u(1)*sin(u(2)*pi/180)+u(3)*sin(u(4)*pi/180)+u(5)*sin(u(6)*pi/180));
IG=abs(IG);

if VA<THV & IA>THI 
   A=1;
else
   A=0;
end;

if VB<THV & IB>THI
   B=1;
else
   B=0;
end;

if VC<THV & IC>THI
   C=1;
else
   C=0;
end;

if IG<THG
   G=1;
else
   G=0;
end;

% END OF METHOD 4

% METHOD 5: CURRENT OR VOLTAGE
function	[A,B,C,G]=corv(THI,THV,THG,u)

i=sqrt(-1);

VA=u(7);
VB=u(9);
VC=u(11);

IA=u(1);
IB=u(3);
IC=u(5);

IG=u(1)*cos(u(2)*pi/180)+u(3)*cos(u(4)*pi/180)+u(5)*cos(u(6)*pi/180)+...
   i*(u(1)*sin(u(2)*pi/180)+u(3)*sin(u(4)*pi/180)+u(5)*sin(u(6)*pi/180));
IG=abs(IG);

if VA<THV | IA>THI 
   A=1;
else
   A=0;
end;

if VB<THV | IB>THI
   B=1;
else
   B=0;
end;

if VC<THV | IC>THI
   C=1;
else
   C=0;
end;

if IG<THG
   G=1;
else
   G=0;
end;

% END OF METHOD 5

% METHOD 6: CURRENT AND IMPEDANCE
function	[A,B,C,G]=candi(THI,THZ,THG,u)

i=sqrt(-1);

VA=u(7);
VB=u(9);
VC=u(11);

IA=u(1);
IB=u(3);
IC=u(5);

IG=u(1)*cos(u(2)*pi/180)+u(3)*cos(u(4)*pi/180)+u(5)*cos(u(6)*pi/180)+...
   i*(u(1)*sin(u(2)*pi/180)+u(3)*sin(u(4)*pi/180)+u(5)*sin(u(6)*pi/180));
IG=abs(IG);

ZA=VA/IA;
ZB=VB/IB;
ZC=VC/IC;

if ZA<THZ & IA>THI 
   A=1;
else
   A=0;
end;

if ZB<THZ & IB>THI
   B=1;
else
   B=0;
end;

if ZC<THZ & IC>THI
   C=1;
else
   C=0;
end;

if IG<THG
   G=1;
else
   G=0;
end;

% END OF METHOD 6

% METHOD 7: CURRENT OR IMPEDANCE
function	[A,B,C,G]=cori(THI,THZ,THG,u)

i=sqrt(-1);

VA=u(7);
VB=u(9);
VC=u(11);

IA=u(1);
IB=u(3);
IC=u(5);

IG=u(1)*cos(u(2)*pi/180)+u(3)*cos(u(4)*pi/180)+u(5)*cos(u(6)*pi/180)+...
   i*(u(1)*sin(u(2)*pi/180)+u(3)*sin(u(4)*pi/180)+u(5)*sin(u(6)*pi/180));
IG=abs(IG);

ZA=VA/IA;
ZB=VB/IB;
ZC=VC/IC;

if ZA<THZ | IA>THI 
   A=1;
else
   A=0;
end;

if ZB<THZ | IB>THI
   B=1;
else
   B=0;
end;

if ZC<THZ | IC>THI
   C=1;
else
   C=0;
end;

if IG<THG
   G=1;
else
   G=0;
end;

% END OF METHOD 7

% METHOD 8: VOLTAGE AND IMPEDANCE
function	[A,B,C,G]=vandi(THV,THZ,THG,u)

i=sqrt(-1);

VA=u(7);
VB=u(9);
VC=u(11);

IA=u(1);
IB=u(3);
IC=u(5);

IG=u(1)*cos(u(2)*pi/180)+u(3)*cos(u(4)*pi/180)+u(5)*cos(u(6)*pi/180)+...
   i*(u(1)*sin(u(2)*pi/180)+u(3)*sin(u(4)*pi/180)+u(5)*sin(u(6)*pi/180));
IG=abs(IG);

ZA=VA/IA;
ZB=VB/IB;
ZC=VC/IC;

if ZA<THZ & VA<THV 
   A=1;
else
   A=0;
end;

if ZB<THZ & VB<THV
   B=1;
else
   B=0;
end;

if ZC<THZ & VC<THV
   C=1;
else
   C=0;
end;

if IG<THG
   G=1;
else
   G=0;
end;

% END OF METHOD 8


% METHOD 9: VOLTAGE OR IMPEDNACE
function	[A,B,C,G]=vori(THV,THZ,THG,u)

i=sqrt(-1);

VA=u(7);
VB=u(9);
VC=u(11);

IA=u(1);
IB=u(3);
IC=u(5);

IG=u(1)*cos(u(2)*pi/180)+u(3)*cos(u(4)*pi/180)+u(5)*cos(u(6)*pi/180)+...
   i*(u(1)*sin(u(2)*pi/180)+u(3)*sin(u(4)*pi/180)+u(5)*sin(u(6)*pi/180));
IG=abs(IG);

ZA=VA/IA;
ZB=VB/IB;
ZC=VC/IC;

if ZA<THZ | VA<THV 
   A=1;
else
   A=0;
end;

if ZB<THZ | VB<THV
   B=1;
else
   B=0;
end;

if ZC<THZ | VC<THV
   C=1;
else
   C=0;
end;

if IG<THG
   G=1;
else
   G=0;
end;

% END OF METHOD 9


% METHOD 10: CURRENT AND VOLTAGE AND IMPEDANCE
function	[A,B,C,G]=candvandi(THI,THV,THZ,THG,u)

i=sqrt(-1);

VA=u(7);
VB=u(9);
VC=u(11);

IA=u(1);
IB=u(3);
IC=u(5);

IG=u(1)*cos(u(2)*pi/180)+u(3)*cos(u(4)*pi/180)+u(5)*cos(u(6)*pi/180)+...
   i*(u(1)*sin(u(2)*pi/180)+u(3)*sin(u(4)*pi/180)+u(5)*sin(u(6)*pi/180));
IG=abs(IG);

ZA=VA/IA;
ZB=VB/IB;
ZC=VC/IC;

if ZA<THZ & VA<THV & IA>THI
   A=1;
else
   A=0;
end;

if ZB<THZ & VB<THV & IB>THI
   B=1;
else
   B=0;
end;

if ZC<THZ & VC<THV & IC>THI
   C=1;
else
   C=0;
end;

if IG<THG
   G=1;
else
   G=0;
end;

% END OF METHOD 10

% METHOD 11: CURRENT OR VOLTAGE OR IMPEDNACE
function	[A,B,C,G]=corvori(THI,THV,THZ,THG,u)

i=sqrt(-1);

VA=u(7);
VB=u(9);
VC=u(11);

IA=u(1);
IB=u(3);
IC=u(5);

IG=u(1)*cos(u(2)*pi/180)+u(3)*cos(u(4)*pi/180)+u(5)*cos(u(6)*pi/180)+...
   i*(u(1)*sin(u(2)*pi/180)+u(3)*sin(u(4)*pi/180)+u(5)*sin(u(6)*pi/180));
IG=abs(IG);

ZA=VA/IA;
ZB=VB/IB;
ZC=VC/IC;

if ZA<THZ | VA<THV | IA>THI
   A=1;
else
   A=0;
end;

if ZB<THZ | VB<THV | IB>THI
   B=1;
else
   B=0;
end;

if ZC<THZ | VC<THV | IC>THI
   C=1;
else
   C=0;
end;

if IG<THG
   G=1;
else
   G=0;
end;

% END OF METHOD 11

% DETECT FAULT TYPE
function sys=detect(A,B,C,G)

sys=0;

if A==1 & B==0 & C==0 & G==0
   sys=1;
end;

if A==0 & B==1 & C==0 & G==0
   sys=2;
end;

if A==0 & B==0 & C==1 & G==0
   sys=3;
end;

if A==1 & B==1 & C==0 & G==0
   sys=4;
end;

if A==0 & B==1 & C==1 & G==0
   sys=5;
end;

if A==1 & B==0 & C==1 & G==0
   sys=6;
end;

if A==1 & B==1 & C==0 & G==1
   sys=7;
end;

if A==0 & B==1 & C==1 & G==1
   sys=8;
end;

if A==1 & B==0 & C==1 & G==1
   sys=9;
end;

if A==1 & B==1 & C==1 & G==0
   sys=10;
end;

if A==1 & B==1 & C==1 & G==1
   sys=11;
end;

% END OF FAULT DETECTION