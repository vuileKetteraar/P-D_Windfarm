if Bactive==1,
   temp1=gcb;
   tempo=length(gcb);
   bdwidth=5;
   topbdwidth=30;
   set(0,'Units','pixels');
   scnsize=get(0,'ScreenSize');
   curfig = gcf;
   ic = curfig.Number;
   switch temp1(tempo)
   case 'D',
      fig=ic+1;
      pos=[bdwidth,scnsize(4)-(4/3*1/2*scnsize(4)+4*bdwidth),scnsize(3)/2-2*bdwidth,...
       scnsize(4)/2*4/3-(topbdwidth+bdwidth)];     
   case '1'
      fig=ic+2;
      scnsize=get(0,'ScreenSize');
      pos=[(bdwidth+fig*10),scnsize(4)-(4/3*1/2*scnsize(4)+4*bdwidth)-fig*10,scnsize(3)/2-...
         2*bdwidth,scnsize(4)/2*4/3-(topbdwidth+bdwidth)];      
   case '2',
      fig=ic+3;
      pos=[(bdwidth+fig*20),scnsize(4)-(4/3*1/2*scnsize(4)+4*bdwidth)-fig*20,scnsize(3)/2-...
         2*bdwidth,scnsize(4)/2*4/3-(topbdwidth+bdwidth)];      
   case '3',
      fig=ic+4;
      pos=[(bdwidth+fig*30),scnsize(4)-(4/3*1/2*scnsize(4)+4*bdwidth)-fig*30,scnsize(3)/2-...
         2*bdwidth,scnsize(4)/2*4/3-(topbdwidth+bdwidth)];      
   case '4',
      fig=ic+5;
      pos=[(bdwidth+fig*40),scnsize(4)-(4/3*1/2*scnsize(4)+4*bdwidth)-fig*40,scnsize(3)/2-...
         2*bdwidth,scnsize(4)/2*4/3-(topbdwidth+bdwidth)];      
   case '5',
      fig=ic+6;
      pos=[(bdwidth+fig*50),scnsize(4)-(4/3*1/2*scnsize(4)+4*bdwidth)-fig*50,scnsize(3)/2-...
         2*bdwidth,scnsize(4)/2*4/3-(topbdwidth+bdwidth)];      
   otherwise
      h=0;
      h2=0;
      H_mag=0;
      H_ang=0;
      fig=1;
   end;
   %figure(fig);
   %close(fig);
   figure(fig);
   bdwidth=5;
   topbdwidth=30;
   set(0,'Units','pixels');
   set(fig,'userdata',temp1);
   set(fig,'position',pos);      
   set(gcf,'name',strcat('Phasor Display No.',num2str(fig)),'numbertitle','off');         
   h(fig)=axes('Position',[0 0 1 1],'Vis','off');
   h2(fig)=axes('Position',[0.1 0.25 0.8 0.7],'xticklabel',[],'yticklabel',[]);
   set(gcf,'currentaxes',h2(fig));
   H_mag(fig,1)=uicontrol(gcf,'fontsize',1,'style','text','units','normalized',...
      'posi',[.10 .10 .12 0.04],'background',[1 1 1]);
   H_mag(fig,2)=uicontrol(gcf,'fontsize',1,'style','text','units','normalized',...
      'posi',[.236 .10 .12 0.04],'background',[1 1 1]);
   H_mag(fig,3)=uicontrol(gcf,'fontsize',1,'style','text','units','normalized',...
      'posi',[.372 .10 .12 0.04],'background',[1 1 1]);
   H_mag(fig,4)=uicontrol(gcf,'fontsize',1,'style','text','units','normalized',...
      'posi',[.508 .10 .12 0.04],'background',[1 1 1]);
   H_mag(fig,5)=uicontrol(gcf,'fontsize',1,'style','text','units','normalized',...
      'posi',[.644 .10 .12 0.04],'background',[1 1 1]);
   H_mag(fig,6)=uicontrol(gcf,'fontsize',1,'style','text','units','normalized',...
      'posi',[.78 .10 .12 0.04],'background',[1 1 1]);      
   H_ang(fig,1)=uicontrol(gcf,'fontsize',1,'style','text','units','normalized',...
      'posi',[.10 .05 .12 0.04],'background',[1 1 1]);
   H_ang(fig,2)=uicontrol(gcf,'fontsize',1,'style','text','units','normalized',...
      'posi',[.236 .05 .12 0.04],'background',[1 1 1]);
   H_ang(fig,3)=uicontrol(gcf,'fontsize',1,'style','text','units','normalized',...
      'posi',[.372 .05 .12 0.04],'background',[1 1 1]);
   H_ang(fig,4)=uicontrol(gcf,'fontsize',1,'style','text','units','normalized',...
      'posi',[.508 .05 .12 0.04],'background',[1 1 1]);
   H_ang(fig,5)=uicontrol(gcf,'fontsize',1,'style','text','units','normalized',...
      'posi',[.644 .05 .12 0.04],'background',[1 1 1]);
   H_ang(fig,6)=uicontrol(gcf,'fontsize',1,'style','text','units','normalized',...
      'posi',[.78 .05 .12 0.04],'background',[1 1 1]);
   set(fig,'closereq','closereq');
else
      h=0;
      h2=0;
      H_mag=0;
      H_ang=0;
      fig=1;
end;


   
