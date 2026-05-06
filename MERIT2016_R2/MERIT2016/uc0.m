time=[];
current=[];
icon='';
switch type0,
   case 1,
       %signal-threshold
       if sign ==1
          %S1>threshold
          aux=0;
          icon=sprintf('S1 > %g',Ipickup);
       else
          %S1<threshold
          aux=1;
          icon=sprintf('S1 < %g',Ipickup);
       end;
   case 2,
       %Signal-Signal
       if sign ==1
          %S1>S2
          aux=2;
          icon='S1>S2';
       else
          %S1<S2
          aux=3;
          icon='S1<S2';
      end;
   case 3,
      %signal-time
      if type3==1
         %instantaneous value of input signal
         switch type1,
         case 1,       
               %time defined
               aux=4;
               icon=sprintf('top = %g\n Ip =%g' ,k,Ipickup);
               time=[];
               current=[];
            case 2,
               %inverse time
               aux=6;
               m=1;
               Iop=1.5;
               while Iop<=20,
                  current(m)=Iop;
                  time(m)=0.14*k/(Iop^(0.02)-1);
                  m=m+1;
                  Iop=current(m-1)+0.5;
               end;
               time=log(time);
               current=log(current);
            case 3,
               %very inverse
               aux=7;
               m=1;
               Iop=1.5;
               while Iop<=20,
                  current(m)=Iop;
                  time(m)=13.5*k/(Iop-1);
                  m=m+1;
                  Iop=current(m-1)+0.5;
               end;
               time=log(time);
               current=log(current);               
            case 4,
               %extremely inverse
               aux=8;
               m=1;
               Iop=1.5;
               while Iop<=20,
                  current(m)=Iop;
                  time(m)=80*k/(Iop^2-1);
                  m=m+1;
                  Iop=current(m-1)+0.5;
               end;
               time=log(time);
               current=log(current);
            case 5,
               %RI inverse
               m=1;
               Iop=1.0;
               while Iop<=20,
                  current(m)=Iop;
                  time(m)=k*(3.1)*(1+2.2/Iop^2.2);
                  m=m+1;
                  Iop=current(m-1)+0.5;
               end;
               time=log(time);
               current=log(current);               
               aux=9;
            case 6,
               %Long time inverse
               aux=10;
               m=1;
               Iop=1.5;
               while Iop<=20,
                  current(m)=Iop;
                  time(m)=120*k/(Iop-1);
                  m=m+1;
                  Iop=current(m-1)+0.5;
               end;
               time=log(time);
               current=log(current);               
            otherwise,
               aux=0;
         end;
      else
         switch type1,
            case 1,
               %time defined
               aux=5;
               icon=sprintf('top = %g\n Ip =%g' ,k,Ipickup);              
            case 2,
               %inverse time
               aux=11;
               m=1;
               Iop=1.5;
               while Iop<=20,
                  current(m)=Iop;
                  time(m)=0.14*k/(Iop^(0.02)-1);
                  m=m+1;
                  Iop=current(m-1)+0.5;
               end;
               time=log(time);
               current=log(current);
            case 3,
               %very inverse
               aux=12;
               m=1;
               Iop=1.5;
               while Iop<=20,
                  current(m)=Iop;
                  time(m)=13.5*k/(Iop-1);
                  m=m+1;
                  Iop=current(m-1)+0.5;
               end;
               time=log(time);
               current=log(current);                             
            case 4,
               %extremely inverse
               aux=13;
               m=1;
               Iop=1.5;
               while Iop<=20,
                  current(m)=Iop;
                  time(m)=80*k/(Iop^2-1);
                  m=m+1;
                  Iop=current(m-1)+0.5;
               end;
               time=log(time);
               current=log(current);             
            case 5,
               %RI inverse
               aux=14;
               m=1;
               Iop=1.0;
               while Iop<=20,
                  current(m)=Iop;
                  time(m)=k*(3.1)*(1+2.2/Iop^2.2);
                  m=m+1;
                  Iop=current(m-1)+0.5;
               end;
               time=log(time);
               current=log(current);                            
            case 6,
               %Long time inverse
               aux=15;
                m=1;
               Iop=1.5;
               while Iop<=20,
                  current(m)=Iop;
                  time(m)=120*k/(Iop-1);
                  m=m+1;
                  Iop=current(m-1)+0.5;
               end;
               time=log(time);
               current=log(current);                           
            otherwise,
               aux=0;
         end;
      end;
   otherwise,
      aux=0;
   end;

