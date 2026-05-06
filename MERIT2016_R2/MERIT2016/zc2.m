function [sys,x0,str,ts] = zc2(t,x,u,flag,z1,z2,z3,z4,zr,typez,fs,n,minx,flagc,m,b)
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
      sys=mdlUpdate(t,x,u);

  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  	case 3,
   	 sys=mdlOutputs(t,x,u,z1,z2,z3,z4,zr,typez,n,minx,flagc,m,b);

  %%%%%%%%%%%%%%%%%%%%%%%
  % GetTimeOfNextVarHit %
  %%%%%%%%%%%%%%%%%%%%%%%
  	case 4,
   	 sys=mdlGetTimeOfNextVarHit(t,x,u,fs);

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
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 5;
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
%variable aux contains the type of comparison
sys = [];
% end mdlUpdate
%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t,x,u,z1,z2,z3,z4,zr,typez,n,minx,flagc,m,b)
switch typez,
case 1,
   %mho characteristic
   
   sys(1)=double(((z1(1,1)-u(1))^2+(z1(1,2)-u(2))^2)<(z1(1,1)^2+z1(1,2)^2));
   if sys(1)==0
      sys(2)=double(((z2(1,1)-u(1))^2+(z2(1,2)-u(2))^2)<(z2(1,1)^2+z2(1,2)^2));
      if sys(2)==0
         sys(3)=double(((z3(1,1)-u(1))^2+(z3(1,2)-u(2))^2)<(z3(1,1)^2+z3(1,2)^2));
         if sys(3)==0
            sys(4)=double(((z4(1,1)-u(1))^2+(z4(1,2)-u(2))^2)<(z4(1,1)^2+z4(1,2)^2));
            if sys(4)==0
               sys(5)=double(((zr(1,1)-u(1))^2+(zr(1,2)-u(2))^2)<(zr(1,1)^2+zr(1,2)^2));
            else
               sys(5)=0;
            end;
         else
            sys(4:5)=[0 0];
         end;
      else
         sys(3:5)=[0 0 0];
      end;
   else
      sys(2:5)=zeros(1,4);
   end;
case 2,
   %Free expression
   sys(1:5)=0;
   c=0;
   k=0;
   zflag=1;
   while zflag,
      k=k+1;
      cont=1;
      fup=0;
      up=inf;
      flo=0;
      lo=-inf;
      fle=0;
      le=-inf;
      fri=0;
      ri=inf;
      flagn=1;
      switch k,
      case 1,
         z=z1;
      case 2,
         z=z2;
      case 3,
         z=z3;
      case 4,
         z=z4;
      case 5,
         z=zr;
         zflag=0;
      otherwise,
         zflag=0;
      end;
      if c==0
         c=1;
         while flagn,
            if cont==1
               next=n(k);
            else
               next=cont-1;
            end;
            if cont==2
               flagn=0;
            end;
            if (u(1)<=z(cont,1)&u(1)>z(next,1))|(u(1)>z(cont,1)&u(1)<=z(next,1))
               rangey=1;
            else
               rangey=0;
            end;
            if (u(2)<=z(cont,2)&u(2)>z(next,2))|(u(2)>z(cont,2)&u(2)<=z(next,2))
               rangex=1;
            else
               rangex=0;
            end;
            if rangey~=0 & rangex==0
               y=m(k,next)*u(1)+b(k,next);
               if y>u(2) & up>y
                  up=y;
                  fup=next;
               else
                  if y<u(2) & lo<y
                     lo=y;
                     flo=next;
                  end;
               end;
            else
               if rangey==0 & rangex~=0
                  if m(k,next)==inf 
                     x=z(next,1);
                  else
                     x=(u(2)-b(k,next))/m(k,next);
                  end;
                  if x>u(1) & ri>x
                     ri=x;
                     fri=next;
                  elseif x<u(1) & le<x
                     le=x;
                     fle=next;
                  end;
               elseif rangey~=0 & rangex~=0
                  y=m(k,next)*u(1)+b(k,next);
                  if flagc(k,next)==1               
                     c=(u(2)<y)*c;
                     if c==1
                        if up>y
                           up=y;
                           fup=-1;
                        end;
                        if m(k,next)==0
                           x=inf;
                        else                       
                           x=(u(2)-b(k,next))/m(k,next);
                        end;   
                        if m(k,next)<0
                           if ri>x
                              ri=x;
                              fri=-1;
                           end;
                        else
                           if le<x
                              le=x;
                              fle=-1;
                           end;
                        end;
                     end;
                  else                    
                     c=(u(2)>y)*c;
                     if c==1
                        if lo<y
                           lo=y;
                           flo=-1;
                        end;
                        x=(u(2)-b(k,next))/m(k,next);
                        if m(k,next)>0
                           if ri>x
                              ri=x;
                              fri=-1;
                           end;
                        else
                           if le<x
                              le=x;
                              fle=-1;
                           end;
                        end;
                     end;
                  end;
               end;
            end;
            cont=next;
         end;
         if c~=0
            if fup==0|flo==0|fri==0|fle==0
               c=0;
            end;

            if c~=0 & fup>0
               if flagc(k,fup)==2
                  c=0;
               end;
            end;
            if c~=0 & flo>0,
               if flagc(k,flo)==1
                  c=0;
               end;
            end;
            if c~=0 & fle>0
               if m(k,fle)==inf
                  if flagc(k,fle)==1
                     c=0;
                  end;                        
               else                  
                  if m(k,fle)>0
                     if flagc(k,fle)==2
                        c=0;
                     end;
                  else
                     if flagc(k,fle)==1
                        c=0;
                     end;
                  end;            
               end;
            end;               
            if c~=0 & fri>0
               if m(k,fri)==inf
                  if flagc(k,fri)==2
                     c=0;
                  end;                  
               else                  
                  if m(k,fri)>0
                     if flagc(k,fri)==1
                        c=0;
                     end;
                  else
                     if flagc(k,fri)==2
                        c=0;
                     end;
                  end;
               end;
            end;
         end;
         sys(k)=c;
      else
         zflag=0;
      end;
   end;   
otherwise,
   sys=[0 0 0 0 0];
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
function sys=mdlGetTimeOfNextVarHit(t,x,u,fs)

sys = t + 1/fs;

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
