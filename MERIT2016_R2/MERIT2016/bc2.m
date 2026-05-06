[a b] = size(BC);

%Consecutively re-arrange the bias characteristics from the smallest to the largest values 
%of the horizontal axis. 
R = BC(:,1);

for i = 1:a
   for j = (i+1):a
      if R(i) > R(j)
         bin_R 	= R(i);
      	R(i)		= R(j);
      	R(j)		= bin_R;
			
      	bin_BC 	= BC(i,:);
      	BC(i,:)	= BC(j,:);
      	BC(j,:)	= bin_BC;
      end
   end   
end

R = BC(:,1);
O = BC(:,2);
xo = min(R);
yo = min(O)-0.5*min(O);
x1 = max(R)+0.02*max(O);
y1 = max(O)+0.15*max(O);
%Xmin = xo - 0.4*xo;
%Ymin = yo - 0.4*yo;
