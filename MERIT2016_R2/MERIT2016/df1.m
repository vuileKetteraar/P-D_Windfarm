%%%%%%%%%
% This is for the initialization commands line of DigitalFilter block.
%%%%%%%%%
%function df1;
p=DataWindow-1;
Den=[1];  %for all FIR filters.
if FilterType==1 %Fourier_sine;
   if p<1; p=1;end;
   p=p+rem(p-1,2); %modify p to an odd number.
   Num(1:(p+1)/2)=sin(frequency0*2*pi/fs*(0.5+[(p-1)/2:-1:0]))*2/(p+1);
   Num((p+1)/2+1:(p+1))=-sin(frequency0*2*pi/fs*(0.5+[0:(p-1)/2]))*2/(p+1);
   DIFI=sprintf('FIR Filter \nFourier Sine');
end;
if FilterType==2 %Fourier_cosine;
   if p<1; p=1;end;
   p=p+rem(p-1,2); %modify p to an odd number.
   Num(1:(p+1)/2)=cos(frequency0*2*pi/fs*(0.5+[(p-1)/2:-1:0]))*2/(p+1);
   Num((p+1)/2+1:(p+1))=cos(frequency0*2*pi/fs*(0.5+[0:(p-1)/2]))*2/(p+1);
   DIFI=sprintf('FIR Filter \nFourier Cosine');   
end;
if FilterType==3 %Walsh1;
   if p<1; p=1;end;
   p=p+rem(p-1,2); %modify p to an odd number.
   Num(1:(p+1)/2)=1*pi/2/(p+1);
   Num((p+1)/2+1:p+1)=-1*pi/2/(p+1);
   DIFI=sprintf('FIR Filter \nWalsh 1');  
end;
if FilterType==4 %Walsh2;
   if p<2; p=2;end;
   p=round((p+1)/4)*4-1; %modify p to make (p+1)/4 an integer.
   Num(1:(p+1)/4)=-1*pi/2/(p+1);
   Num((p+1)/4+1:3*(p+1)/4)=1*pi/2/(p+1);
   Num(3*(p+1)/4+1:p+1)=-1*pi/2/(p+1);
   DIFI=sprintf('FIR Filter \nWalsh 2');   
end;
if FilterType==5 %Walsh3;
   if p<2; p=2;end;
   p=round((p+1)/4)*4-1; %modify p to make (p+1)/4 an integer.
   Num(1:(p+1)/4)=1*pi/2/(p+1);
   Num((p+1)/4+1:(p-1)/2+1)=-1*pi/2/(p+1);
   Num((p+1)/2+1:3*(p+1)/4)=1*pi/2/(p+1);
   Num(3*(p+1)/4+1:p+1)=-1*pi/2/(p+1);
   DIFI=sprintf('FIR Filter \nWalsh 3');
end;
if FilterType==6 %Walsh4;
   if p<3; p=3;end;
   p=round((p+1)/8)*8-1; %modify p to make (p+1)/8 an integer.
   Num(1:(p+1)/8)=1*pi/2/(p+1);
   Num((p+1)/8+1:3*(p+1)/8)=-1*pi/2/(p+1);
   Num(3*(p+1)/8+1:5*(p+1)/8)=1*pi/2/(p+1);
   Num(5*(p+1)/8+1:7*(p+1)/8)=-1*pi/2/(p+1);
   Num(7*(p+1)/8+1:p+1)=1*pi/2/(p+1);
   DIFI=sprintf('FIR Filter \nWalsh 4');
end;
if (FilterType==7) %Butterworth
   DIFI=sprintf('Butterworth\n');
   if IIROrder==1
      DIFI=strcat(DIFI,'1st order');
      d0=1;d1=0;d2=0;d3=0;e0=1;e1=1;e2=0;e3=0;
   end;
   if IIROrder==2
      DIFI=strcat(DIFI,'2nd order');
      d0=1;d1=0;d2=0;d3=0;e0=1;e1=sqrt(2);e2=1;e3=0;
   end;
   if IIROrder==3 & PassType<3
      DIFI=strcat(DIFI,'3rd order');
      d0=1;d1=0;d2=0;d3=0;e0=1;e1=2;e2=2;e3=1;
   elseif IIROrder==3 & PassType>2
      DIFI=strcat(DIFI,'2nd order');
      d0=1;d1=0;d2=0;d3=0;e0=1;e1=sqrt(2);e2=1;e3=0;
   end;
end;   
if FilterType==8  %Bessel
   DIFI=sprintf('Bessel\n');
   if IIROrder==1
      DIFI=strcat(DIFI,'1st order');
      d0=3;d1=0;d2=0;d3=0;e0=3;e1=1;e2=0;e3=0;
   end;
   if IIROrder==2
      DIFI=strcat(DIFI,'2nd order');
      d0=3;d1=0;d2=0;d3=0;e0=3;e1=3;e2=1;e3=0;
   end;
   if IIROrder==3 & PassType<3
      DIFI=strcat(DIFI,'3rd order');
      d0=15;d1=0;d2=0;d3=0;e0=15;e1=15;e2=6;e3=1;
   elseif IIROrder==3 &PassType>2
      DIFI=strcat(DIFI,'2nd order');
      d0=3;d1=0;d2=0;d3=0;e0=3;e1=3;e2=1;e3=0;      
   end;
end;
if FilterType==9  %Chebyshev
   DIFI=sprintf('Chebyshev\n');
   if IIROrder==1
      DIFI=strcat(DIFI,'1st order');
      d0=2.86;d1=0;d2=0;d3=0;;e0=2.86;e1=1;e2=0;e3=0;
   end;
   if IIROrder==2
      DIFI=strcat(DIFI,'2nd order');
      d0=1.43;d1=0;d2=0;d3=0;e0=1.52;e1=1.42;e2=1;e3=0;
   end;
   if IIROrder==3 & PassType<3
      DIFI=strcat(DIFI,'3rd order');
      d0=0.716;d1=0;d2=0;d3=0;e0=0.716;e1=1.53;e2=1.25;e3=1;
   elseif IIROrder==3 & PassType>2
      DIFI=strcat(DIFI,'2nd order');
      d0=1.43;d1=0;d2=0;d3=0;e0=1.52;e1=1.42;e2=1;e3=0;
   end;
end;
if ((FilterType==7)|(FilterType==8)|(FilterType==9))& PassType==1 %lowpass
   DIFI=strcat('Low-pass\n',DIFI);
   if IIROrder==1 % one-order;
      c=1/tan(2*pi*CutFre(1)/fs/2);
      R=(e0+e1*c);
      A0=(d0+d1*c)/R;
      A1=(d0-d1*c)/R;
      B1=(e0-e1*c)/R;
      A2=0;A3=0;A4=0;B2=0;B3=0;B4=0;
   end;
   if IIROrder==2 % two-order;
      c=1/tan(2*pi*CutFre(1)/fs/2);
      R=(e0+e1*c+e2*c^2);
      A0=(d0+d1*c+d2*c^2)/R;            
      A1=(2*d0-2*d2*c^2)/R;
      A2=(d0-d1*c+d2*c^2)/R;
      B1=(2*e0-2*e2*c^2)/R;
      B2=(e0-e1*c+e2*c^2)/R;
      A3=0;A4=0;B3=0;B4=0;
   end;
	if IIROrder==3 % three-order;
      c=1/tan(2*pi*CutFre(1)/fs/2);
      R=(e0+e1*c+e2*c^2+e3*c^3);
      A0=(d0+d1*c+d2*c^2+d3*c^3)/R;
      A1=(3*d0+d1*c-d2*c^2-3*d3*c^3)/R;
      A2=(3*d0-d1*c-d2*c^2+3*d3*c^3)/R;
      A3=(d0-d1*c+d2*c^2-d3*c^3)/R;
      B1=(3*e0+e1*c-e2*c^2-3*e3*c^3)/R;
      B2=(3*e0-e1*c-e2*c^2+3*e3*c^3)/R;
      B3=(e0-e1*c+e2*c^2-e3*c^3)/R;
      A4=0;B4=0;
   end;
end;  %lowpass
if ((FilterType==7)|(FilterType==8)|(FilterType==9))& PassType==2 %highpass
   DIFI=strcat('High-pass\n',DIFI);
   if IIROrder==1 % first order;
      c=tan(2*pi*CutFre(1)/fs/2);
      R=(e0+e1*c);
      A0=(d0+d1*c)/R;
      A1=-(d0-d1*c)/R;
      B1=-(e0-e1*c)/R;
      A2=0;A3=0;A4=0;B2=0;B3=0;B4=0;
   end;
   if IIROrder==2 % second order;
      c=tan(2*pi*CutFre(1)/fs/2);
   	R=(e0+e1*c+e2*c^2);
	   A0=(d0+d1*c+d2*c^2)/R;
	   A1=-(2*d0-2*d2*c^2)/R;
	   A2=(d0-d1*c+d2*c^2)/R;
	   B1=-(2*e0-2*e2*c^2)/R;
	   B2=(e0-e1*c+e2*c^2)/R;
   	A3=0;A4=0;B3=0;B4=0;
   end;
	if IIROrder==3 % third order;
      c=tan(2*pi*CutFre(1)/fs/2);
      R=(e0+e1*c+e2*c^2+e3*c^3);
      A0=(d0+d1*c+d2*c^2+d3*c^3)/R;
      A1=-(3*d0+d1*c-d2*c^2-3*d3*c^3)/R;
      A2=(3*d0-d1*c-d2*c^2+3*d3*c^3)/R;
      A3=-(d0-d1*c+d2*c^2-d3*c^3)/R;
      B1=-(3*e0+e1*c-e2*c^2-3*e3*c^3)/R;
      B2=(3*e0-e1*c-e2*c^2+3*e3*c^3)/R;
      B3=-(e0-e1*c+e2*c^2-e3*c^3)/R;
      A4=0;B4=0;
   end;
end;  %highpass
if ((FilterType==7)|(FilterType==8)|(FilterType==9))& PassType==3 %bandpass
   DIFI=strcat('Bandpass\n',DIFI);
%   if (IIROrder==1)|(IIROrder==2)|(IIROrder==3) % two-order;one order analog
      c=1/tan(2*pi*(CutFre(2)-CutFre(1))/fs/2);
      alfa=cos(2*pi*(CutFre(2)+CutFre(1))/fs/2)/...
         cos(2*pi*(CutFre(2)-CutFre(1))/fs/2);
      R=(e0+e1*c);
      A0=(d0+d1*c)/R;
      A1=(-2*alfa*d1*c)/R;
      A2=(d1*c-d0)/R;
      B1=(-2*alfa*e1*c)/R;
      B2=(e1*c-e0)/R;
      A3=0;A4=0;B3=0;B4=0;
%   end;
%   if (IIROrder==3)|(IIROrder==4) % three-order;four order analog
%      c=1/tan(2*pi*(CutFre(2)-CutFre(1))/fs/2);
%     alfa=cos(2*pi*(CutFre(2)+CutFre(1))/fs/2)/...
%         cos(2*pi*(CutFre(2)-CutFre(1))/fs/2);
%      R=(e0+e1*c+e2*c^2);
%      A0=(d0+d1*c+d2*c^2)/R;
%      A1=(-2*alfa*d1*c-4*alfa*d2*c^2)/R;
%      A2=(-2*d0+4*alfa^2*d2*c^2+2*d2*c^2)/R;
%      A3=(2*alfa*d1*c-4*alfa*d2*c^2)/R;
%      A4=(d0-d1*c+d2*c^2)/R;
%      B1=(-2*alfa*e1*c-4*alfa*e2*c^2)/R;
%      B2=(-2*e0+4*alfa^2*e2*c^2+2*e2*c^2)/R;
%      B3=(2*alfa*e1*c-4*alfa*e2*c^2)/R;
%      B4=(e0-e1*c+e2*c^2)/R;
%   end;
end;  %bandpass
if ((FilterType==7)|(FilterType==8)|(FilterType==9))& PassType==4 %bandstop
   DIFI=strcat('Bandstop\n',DIFI);
%   if (IIROrder==1)|(IIROrder==2)|(IIROrder==3) % two-order;one order analog
      c=tan(2*pi*(CutFre(2)-CutFre(1))/fs/2);
      alfa=cos(2*pi*(CutFre(2)+CutFre(1))/fs/2)/...
         cos(2*pi*(CutFre(2)-CutFre(1))/fs/2);
      R=(e0+e1*c);
      A0=(d0+d1*c)/R;
      A1=(-2*alfa*d0)/R;
      A2=(d0-d1*c)/R;
      B1=(-2*alfa*e0)/R;
      B2=(e0-e1*c)/R;
      A3=0;A4=0;B3=0;B4=0;
%   end;
%   if (IIROrder==3)|(IIROrder==4) % three-order;four order analog
%      c=tan(2*pi*(CutFre(2)-CutFre(1))/fs/2);
%      alfa=cos(2*pi*(CutFre(2)+CutFre(1))/fs/2)/...
%         cos(2*pi*(CutFre(2)-CutFre(1))/fs/2);
%      R=(e0+e1*c+e2*c^2);
%      A0=(d0+d1*c+d2*c^2)/R;
%      A1=(-4*alfa*d0-2*alfa*d1*c)/R;
%      A2=(4*alfa^2*d0+2*d0-2*d2*c^2)/R;
%      A3=(-4*alfa*d0+2*alfa*d1*c)/R;
%      A4=(d0-d1*c+d2*c^2)/R;
%      B1=(-4*alfa*e0-2*alfa*e1*c)/R;
%      B2=(4*alfa^2*e0+2*e0-2*e2*c^2)/R;
%      B3=(-4*alfa*e0+2*alfa*e1*c)/R;
%      B4=(e0-e1*c+e2*c^2)/R;
%   end;
end;  %bandstop
if ((FilterType==7)|(FilterType==8)|(FilterType==9))
   Num=[A0 A1 A2 A3 A4];
   Den=[1 B1 B2 B3 B4];
end;   
if FilterType==10  %FreeZform
   Num=FreeZformNum;
   Den=FreeZformDen;
end;
