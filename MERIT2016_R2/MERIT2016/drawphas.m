function drawphas()

load phas;
switch cont
case 0,
   %display of zero sequence components
   cla;
   gx=line([-1,1],[0,0],'color','k','LineStyle',':');
   gy=line([0 0],[-1,1],'color','k','LineStyle',':');
   cont=cont+1;
   %vector components of the zero sequence 
   tem0x=zeros(2,3);
   tem0y=zeros(2,3);
   tem0x(2,1)=1/3*tempx(2,1);
   tem0y(2,1)=1/3*tempy(2,1);
   tem0x(1,2)=tem0x(2,1);
   tem0y(1,2)=tem0y(2,1);
   tem0x(2,2)=tem0x(2,1)+1/3*tempx(2,2);
   tem0y(2,2)=tem0y(2,1)+1/3*tempy(2,2);
   tem0x(1,3)=tem0x(2,2);
   tem0y(1,3)=tem0y(2,2);
   tem0x(2,3)=tem0x(2,2)+1/3*tempx(2,3);
   tem0y(2,3)=tem0y(2,2)+1/3*tempy(2,3);
   mag0=sqrt(tem0x(2,3)^2+tem0y(2,3)^2);
   ang0=atan2(tem0y(2,3),tem0x(2,3))*180/pi;
   if abs(mag0)<0.000001
      mag0=0.00;
      ang0=0.00;
   end;
   strm0={num2str(mag0,'%5.2f')};
   stra0={num2str(ang0,'%5.1f')};
   fig = gcf;
   fRow = fig;
   if ~isnumeric(fig)
       fRow = fig.Number;
   end
%    H_mag(gcf,4)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
%       'posi',[.508 .10 .12 0.04],'background',[1 1 1]);
%    H_ang(gcf,4)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
%       'posi',[.508 .05 .12 0.04],'background',[1 1 1]);
%    set(H_mag(gcf,4),'string', [strm0]);
%    set(H_ang(gcf,4),'string', [stra0]);
   H_mag(fRow,4)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.508 .10 .12 0.04],'background',[1 1 1]);
   H_ang(fRow,4)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.508 .05 .12 0.04],'background',[1 1 1]);
   set(H_mag(fRow,4),'string', [strm0]);
   set(H_ang(fRow,4),'string', [stra0]);

   tempxn=tempx/norma;
   tempyn=tempy/norma;
   tem0x=tem0x/norma;
   tem0y=tem0y/norma;
   li=line(tempxn,tempyn,'Linewidth',1.25);
   text(tempxn(2,1)-0.2,tempyn(2,1)+0.1,'Phase a','color','b');
   text(tempxn(2,2),tempyn(2,2)-0.1,'Phase b','color','g');
   text(tempxn(2,3),tempyn(2,3)+0.1,'Phase c','color','r');
   lz=line(tem0x,tem0y,'Linewidth',1.25, 'Linestyle',':'); %zero sequence
   vzx=[0;tem0x(2,3)];
   vzy=[0;tem0y(2,3)];
   I0=text(tem0x(2,3)-0.05,tem0y(2,3)-0.05,'(0)','color','c');
   vz=line(vzx,vzy,'Linewidth',1.25,'Linestyle','-','color','c');  
   save phas tempx tempy cont aa norma;
case 1,
   %diplay of positive sequence components
   cla;
   gx=line([-1,1],[0,0],'color','k','LineStyle',':');
   gy=line([0 0],[-1,1],'color','k','LineStyle',':'); 
   cont=cont+1;
   %Vector components of the positive sequence
   tem1x=zeros(2,3);
   tem1y=zeros(2,3);
   tem1x(2,1)=1/3*tempx(2,1);
   tem1y(2,1)=1/3*tempy(2,1);
   tem1x(1,2)=tem1x(2,1);
   tem1y(1,2)=tem1y(2,1);
   valp=1/3*aa*(tempx(2,2)+i*tempy(2,2));
   tem1x(2,2)=tem1x(1,2)+real(valp);
   tem1y(2,2)=tem1y(1,2)+imag(valp);
   tem1x(1,3)=tem1x(2,2);
   tem1y(1,3)=tem1y(2,2);
   valp=1/3*aa^2*(tempx(2,3)+i*tempy(2,3));
   tem1x(2,3)=tem1x(1,3)+real(valp);
   tem1y(2,3)=tem1y(1,3)+imag(valp);
   mag1=sqrt(tem1x(2,3)^2+tem1y(2,3)^2);
   ang1=atan2(tem1y(2,3),tem1x(2,3))*180/pi;
   if abs(mag1)<0.000001
      mag1=0.00;
      ang1=0.00;
   end;
   strm1={num2str(mag1,'%5.2f')};
   stra1={num2str(ang1,'%5.1f')};
   
   fig = gcf;
   fRow = fig;
   if ~isnumeric(fig)
       fRow = fig.Number;
   end
   
%    H_mag(gcf,5)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
%       'posi',[.644 .10 .12 0.04],'background',[1 1 1]);
%    H_ang(gcf,5)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
%       'posi',[.644 .05 .12 0.04],'background',[1 1 1]);
%    set(H_mag(gcf,5),'string', [strm1]);
%    set(H_ang(gcf,5),'string', [stra1]);

   H_mag(fRow,5)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.644 .10 .12 0.04],'background',[1 1 1]);
   H_ang(fRow,5)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.644 .05 .12 0.04],'background',[1 1 1]);
   set(H_mag(fRow,5),'string', [strm1]);
   set(H_ang(fRow,5),'string', [stra1]);
   
   tempxn=tempx/norma;
   tempyn=tempy/norma;
   tem1x=tem1x/norma;
   tem1y=tem1y/norma;
   li=line(tempxn,tempyn,'Linewidth',1.25);
   text(tempxn(2,1)-0.2,tempyn(2,1)+0.1,'Phase a','color','b');
   text(tempxn(2,2),tempyn(2,2)-0.1,'Phase b','color','g');
   text(tempxn(2,3),tempyn(2,3)+0.1,'Phase c','color','r');
   lp=line(tem1x,tem1y,'Linewidth',1.25, 'Linestyle',':'); %Positive sequence
   vpx=[0;tem1x(2,3)];
   vpy=[0;tem1y(2,3)];
   vp=line(vpx,vpy,'Linewidth',1.25,'Linestyle','-','color','c');
   I1=text(tem1x(2,3)+0.05,tem1y(2,3)+0.05,'(+)','color','c');
   save phas tempx tempy cont aa norma; 
case 2,
   %display of negative sequence components
   cla;
   gx=line([-1,1],[0,0],'color','k','LineStyle',':');
   gy=line([0 0],[-1,1],'color','k','LineStyle',':');
   cont=cont+1;
      %Vector components of the negative sequence
   tem2x=zeros(2,3);
   tem2y=zeros(2,3);
   tem2x(2,1)=1/3*tempx(2,1);
   tem2y(2,1)=1/3*tempy(2,1);
   tem2x(1,2)=tem2x(2,1);
   tem2y(1,2)=tem2y(2,1);
   valn=1/3*aa^2*(tempx(2,2)+i*tempy(2,2));
   tem2x(2,2)=tem2x(1,2)+real(valn);
   tem2y(2,2)=tem2y(1,2)+imag(valn);
   tem2x(1,3)=tem2x(2,2);
   tem2y(1,3)=tem2y(2,2);
   valn=1/3*aa*(tempx(2,3)+i*tempy(2,3));
   tem2x(2,3)=tem2x(1,3)+real(valn);
   tem2y(2,3)=tem2y(1,3)+imag(valn);
   mag2=sqrt(tem2x(2,3)^2+tem2y(2,3)^2);
   ang2=atan2(tem2y(2,3),tem2x(2,3))*180/pi;
   if abs(mag2)<0.000001
      mag2=0.00;
      ang2=0.00;
   end;
   strm2={num2str(mag2,'%5.2f')};
   stra2={num2str(ang2,'%5.1f')};
   
   fig = gcf;
   fRow = fig;
   if ~isnumeric(fig)
       fRow = fig.Number;
   end
   
%    H_mag(gcf,6)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
%       'posi',[.78 .10 .12 0.04],'background',[1 1 1]);
%    H_ang(gcf,6)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
%       'posi',[.78 .05 .12 0.04],'background',[1 1 1]);
%    set(H_mag(gcf,6),'string', [strm2]);
%    set(H_ang(gcf,6),'string', [stra2]);
   
   H_mag(fRow,6)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.78 .10 .12 0.04],'background',[1 1 1]);
   H_ang(fRow,6)=uicontrol(gcf,'fontsize',10,'style','text','units','normalized',...
      'posi',[.78 .05 .12 0.04],'background',[1 1 1]);
   set(H_mag(fRow,6),'string', [strm2]);
   set(H_ang(fRow,6),'string', [stra2]);
   
   tempxn=tempx/norma;
   tempyn=tempy/norma;
   tem2x=tem2x/norma;
   tem2y=tem2y/norma;
   li=line(tempxn,tempyn,'Linewidth',1.25);
   text(tempxn(2,1)-0.2,tempyn(2,1)+0.1,'Phase a','color','b');
   text(tempxn(2,2),tempyn(2,2)-0.1,'Phase b','color','g');
   text(tempxn(2,3),tempyn(2,3)+0.1,'Phase c','color','r');
   ln=line(tem2x,tem2y,'Linewidth',1.25, 'Linestyle',':'); %Negative sequence
   vnx=[0;tem2x(2,3)];
   vny=[0;tem2y(2,3)];
   vn=line(vnx,vny,'Linewidth',1.25,'Linestyle','-','color','c'); 
   I2=text(tem2x(2,3)+0.05,tem2y(2,3)-0.05,'(-)','color','c');
   save phas tempx tempy cont aa norma;
otherwise,
   cont=0;
   save phas tempx tempy cont aa norma;
end;


   
   