switch trtype,
case 1,
   %wye - delta
   icon=sprintf('wye\n-\ndelta');
case 2,
   %delta - wye   
   icon=sprintf('delta\n-\nwye');
case 3,
   %wye - wye
   icon=sprintf('wye\n-\nwye');
case 4,
   %delta - delta
   icon=sprintf('delta\n-\ndelta');
otherwise,
   icon='';
end;

   

