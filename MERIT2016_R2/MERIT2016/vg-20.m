switch trtype,
case 1,
   %wye - delta
   icon=sprintf('VG-2\n\nwye\n-\ndelta');
case 2,
   %delta - wye   
   icon=sprintf('VG-2\n\ndelta\n-\nwye');
case 3,
   %wye - wye
   icon=sprintf('VG-2\n\nwye\n-\nwye');
case 4,
   %delta - delta
   icon=sprintf('VG-2\n\ndelta\n-\ndelta');
otherwise,
   icon='';
end;
icon
   

