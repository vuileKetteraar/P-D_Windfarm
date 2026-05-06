%%%%%%%%%%%%%%%%%
%This is for SC-Symmetrical component block
%%%%%%%%%%%%%%%%%
function [sys,x0,str,ts]=sc1(t,x,u,flag,ortho_instant,powerfre,samplefre);
%ortho_instant: 0 represent orthogonal inputs
%               1 for instantaneous value inputs
% samplefre : sampling frequency
% powerfre  : input signal fundamental frequency.
switch flag, 
   case 0
   	[sys,x0,str,ts]=mdlInitializeSizes(ortho_instant,samplefre);
   case 3
      sys=mdlOutputs(t,x,u,ortho_instant,powerfre,samplefre);
   case {1,2,4,9}
      sys=[];
   otherwise
      error(['Unhandled flag=',num2str(flag)]);
end;
%End of function scblock
 
function [sys,x0,str,ts]=mdlInitializeSizes(ortho_instant,samplefre);
sizes=simsizes;
sizes.NumContStates=0;
sizes.NumDiscStates=0;
sizes.NumInputs=-1;
if ortho_instant==1
   sizes.NumOutputs=6;
else
  sizes.NumOutputs=3;
end;  
sizes.DirFeedthrough=1;
sizes.NumSampleTimes=1;
sys=simsizes(sizes);
x0=[];
str=[];
ts=[1/samplefre 0];
%End of mdlInitializeSizes;

function sys=mdlOutputs(t,x,u,ortho_instant,powerfre,samplefre);
if ortho_instant==1 % u=[a_r a_i b_r b_i c_r c_i]
   alfa=exp(i*120*pi/180);
   tmpa=u(1)*exp(i*u(2)*pi/180);
   tmpb=u(3)*exp(i*u(4)*pi/180);
   tmpc=u(5)*exp(i*u(6)*pi/180);
   temp=1/3*[1 1 1;1 alfa alfa^2;1 alfa^2 alfa]*[tmpa;tmpb;tmpc];
   abtemp=abs(temp);
   angtemp=angle(temp)*180/pi;
   sys=[abtemp(1),angtemp(1),abtemp(2),angtemp(2),abtemp(3),angtemp(3)]
else % u=[x_a(n),x_a(n-1),...x_a(n-m1+1)...
     %    x_b(n),x_b(n-1),...x_b(n-m1+1)...
     %    x_c(n),x_c(n-1),...x_c(n-m1+1)]
     %      1       2            m1
     m=samplefre/powerfre;
     m1=length(u)/3;
     x_a=u(1:m1);
     x_b=u(m1+1:2*m1);
     x_c=u(2*m1+1:3*m1);
     %Interpolation if m/6 or m/3 is not an integer.     
     if (rem(m,6)==0)
        x_b6=x_b(m/6+1);
        x_c6=x_c(m/6+1);
     end;   
     if (rem(m,3)==0)
        x_b3=x_b(m/3+1);
        x_c3=x_c(m/3+1);
     end;   
     if ~(rem(m,6)==0)
        k=fix(m/6+1);r=m/6+1-k;
        x_b6=(1-r)*x_b(k)+r*x_b(k+1);%x_b(m/6+1)=x_b6;
        x_c6=(1-r)*x_c(k)+r*x_c(k+1);%x_c(m/6+1)=x_c6;
     end;
     if ~(rem(m,3)==0)
        k=fix(m/3+1); r=m/3+1-k;
        x_b3=(1-r)*x_b(k)+r*x_b(k+1);%x_b(m/3+1)=x_b3;
        x_c3=(1-r)*x_c(k)+r*x_c(k+1);%x_c(m/3+1)=x_c3;
     end;
     sys=[1/3*(x_a(1)+x_b(1)+x_c(1)),...
          1/3*(x_a(1)-x_b6+x_c3),...
          1/3*(x_a(1)+x_b3-x_c6)];
end;     
%End of mdlOutputs.
 