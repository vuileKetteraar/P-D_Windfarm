if type_pre~=1
   nin=1;   %Number of outputs for pre process & number of inputs for the following buffer
   switch meth_sol
   case 1,
      k=m+2;
   case 2,
      k=d+1;
   end;
else
   nin=N;
   k=N;
end;

switch type_post
  case 1
     in=2; % Number of outputs for post precess buffer & number of inputs for post process
     
  case {2,3}
     in=2*p;
end;
