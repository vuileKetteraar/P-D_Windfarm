title='PS\n';
switch(METHOD),
case 1, %CURRENT
   icon=sprintf('I');
   icon=strcat(title,icon);
case 2, %VOLTAGE
   icon=sprintf('V');
   icon=strcat(title,icon);   
case 3, %IMPEDANCE
   icon=sprintf('Z');  
   icon=strcat(title,icon);
case 4, %CURRENT AND VOLTAGE
   icon=sprintf('I\n&\nV');
   icon=strcat(title,icon);
case 5, %CURRENT OR VOLTAGE
   icon=sprintf('I\nOR\nV'); 
   icon=strcat(title,icon);
case 6, %CURRENT AND IMPEDANCE
   icon=sprintf('I\n&\nZ');
   icon=strcat(title,icon);
case 7, %CURRENT OR IMPEDANCE
   icon=sprintf('I\nOR\nZ');
   icon=strcat(title,icon);
case 8, %VOLTAGE AND IMPEDANCE
   icon=sprintf('V\n&\nZ'); 
   icon=strcat(title,icon);
case 9, %VOLTAGE OR IMPEDANCE
   icon=sprintf('V\nOR\nZ');
   icon=strcat(title,icon);
case 10, %CURRENT AND VOLTAGE AND IMPEDANCE
   icon=sprintf('I\n&\nV\n&\nZ');
   icon=strcat(title,icon);
case 11, %CURRENT OR VOLTAGE OR IMPEDANCE
   icon=sprintf('I\nOR\nV\nOR\nZ');
   icon=strcat(title,icon);
otherwise
    error(['Unhandled METHOD = ',num2str(METHOD)]);
end;

