if typez==1,
   %circle for zone 1
   K=0;
   d=sqrt(z1(1)^2+z1(2)^2);
   xcount=z1(1)-d;
   K=K+1;
   x1(K,1)=xcount;
   x1(K,2)=z1(2);
   xcount=xcount+0.1;
   while xcount<(z1(1)+d),
      K=K+1;
      x1(K,1)=xcount;
      x1(K,2)=sqrt(d^2-(xcount-z1(1))^2)+z1(2);
      xcount=xcount+0.1;
   end;
   K=K+1;
   xcount=z1(1)+d;
   x1(K,1)=xcount;
   x1(K,2)=z1(2);
   xcount=xcount-0.1;
   while xcount>(z1(1)-d),
      K=K+1;
      x1(K,1)=xcount;
      x1(K,2)=-sqrt(d^2-(xcount-z1(1))^2)+z1(2);
      xcount=xcount-0.1;
   end;
   K=K+1;
   x1(K,1)=x1(1,1);
   x1(K,2)=x1(1,2);
   %circle for zone 2
   K=0;
   d=sqrt(z2(1)^2+z2(2)^2);
   xcount=z2(1)-d;
   K=K+1;
   x2(K,1)=xcount;
   x2(K,2)=z2(2);
   xcount=xcount+0.1;
   while xcount<(z2(1)+d),
      K=K+1;
      x2(K,1)=xcount;
      x2(K,2)=sqrt(d^2-(xcount-z2(1))^2)+z2(2);
      xcount=xcount+0.1;
   end;
   K=K+1;
   xcount=z2(1)+d;
   x2(K,1)=xcount;
   x2(K,2)=z2(2);
   xcount=xcount-0.1;
   while xcount>(z2(1)-d),
      K=K+1;
      x2(K,1)=xcount;
      x2(K,2)=-sqrt(d^2-(xcount-z2(1))^2)+z2(2);
      xcount=xcount-0.1;
   end;
   K=K+1;
   x2(K,1)=x2(1,1);
   x2(K,2)=x2(1,2);
   %circle for zone 3
   K=0;
   d=sqrt(z3(1)^2+z3(2)^2);
   xcount=z3(1)-d;
   K=K+1;
   x3(K,1)=xcount;
   x3(K,2)=z3(2);
   xcount=xcount+0.1;
   while xcount<(z3(1)+d),
      K=K+1;
      x3(K,1)=xcount;
      x3(K,2)=sqrt(d^2-(xcount-z3(1))^2)+z3(2);
      xcount=xcount+0.1;
   end;
   K=K+1;
   xcount=z3(1)+d;
   x3(K,1)=xcount;
   x3(K,2)=z3(2);
   xcount=xcount-0.1;
   while xcount>(z3(1)-d),
      K=K+1;
      x3(K,1)=xcount;
      x3(K,2)=-sqrt(d^2-(xcount-z3(1))^2)+z3(2);
      xcount=xcount-0.1;
   end;
   K=K+1;
   x3(K,1)=x3(1,1);
   x3(K,2)=x3(1,2);
   %circle for zone 4
   K=0;
   d=sqrt(z4(1)^2+z4(2)^2);
   xcount=z4(1)-d;
   K=K+1;
   x4(K,1)=xcount;
   x4(K,2)=z4(2);
   xcount=xcount+0.1;
   while xcount<(z4(1)+d),
      K=K+1;
      x4(K,1)=xcount;
      x4(K,2)=sqrt(d^2-(xcount-z4(1))^2)+z4(2);
      xcount=xcount+0.1;
   end;
   K=K+1;
   xcount=z4(1)+d;
   x4(K,1)=xcount;
   x4(K,2)=z4(2);
   xcount=xcount-0.1;
   while xcount>(z4(1)-d),
      K=K+1;
      x4(K,1)=xcount;
      x4(K,2)=-sqrt(d^2-(xcount-z4(1))^2)+z4(2);
      xcount=xcount-0.1;
   end;
   K=K+1;
   x4(K,1)=x4(1,1);
   x4(K,2)=x4(1,2);
   %circle for reverse zone
   K=0;
   d=sqrt(zr(1)^2+zr(2)^2);
   xcount=zr(1)-d;
   K=K+1;
   xr(K,1)=xcount;
   xr(K,2)=zr(2);
   xcount=xcount+0.1;
   while xcount<(zr(1)+d),
      K=K+1;
      xr(K,1)=xcount;
      xr(K,2)=sqrt(d^2-(xcount-zr(1))^2)+zr(2);
      xcount=xcount+0.1;
   end;
   K=K+1;
   xcount=zr(1)+d;
   xr(K,1)=xcount;
   xr(K,2)=zr(2);
   xcount=xcount-0.1;
   while xcount>(zr(1)-d),
      K=K+1;
      xr(K,1)=xcount;
      xr(K,2)=-sqrt(d^2-(xcount-zr(1))^2)+zr(2);
      xcount=xcount-0.1;
   end;
   K=K+1;
   xr(K,1)=xr(1,1);
   xr(K,2)=xr(1,2);
   n=0;
   minx=0;
   flagc=0;
   m=0;
   b=0;
else
   x1=z1; a=size(x1,1); x1(a+1,:)=x1(1,:);
   x2=z2; a=size(x2,1); x2(a+1,:)=x2(1,:);
   x3=z3; a=size(x3,1); x3(a+1,:)=x3(1,:);
   x4=z4; a=size(x4,1); x4(a+1,:)=x4(1,:);
   xr=zr; a=size(x4,1); xr(a+1,:)=xr(1,:);
   n(1:5)=[size(z1,1);size(z2,1);size(z3,1);size(z4,1);size(zr,1)];
   flagc=zeros(5,max(n));
   for l=1:5,
      switch l,
      case 1,
         %Zone 1
         z=z1;
      case 2,
         %Zone 2
         z=z2;
      case 3,
         %Zone 3
         z=z3;
      case 4,
         %Zone 4
         z=z4;
      case 5,
         %Reverse zone
         z=zr;
      otherwise,         
         z=0;
      end;             
      min=z(1,1);
      minx(l)=1;
      %Obtains the equation parameters for all the lines that compose the limits of each zone.
      for k=1:n(l)
         if k==n(l)
            next=1;
         else
            next=k+1;
         end;
         if z(k,1)<min
            min=z(k,1);
            minx(l)=k;
         end;
         if z(k,2)==z(next,2)
            %line with m=0
            m(l,k)=0;
            b(l,k)=z(k,2);
            flagm(l,k)=1;
         elseif z(k,1)==z(next,1)
            %line with m=infinite
            m(l,k)=inf;
            b(l,k)=z(next,2);
            flagm(l,k)=2;
         else
            %line with m~=0 and m<infinite
            m(l,k)=(z(next,2)-z(k,2))/(z(next,1)-z(k,1));
            b(l,k)=z(next,2)-m(l,k)*z(next,1);
            flagm(l,k)=0;
         end;
      end;
      pre=0;
      flagn=1;
      cont=minx(l);
      if cont==n(l)
         pre2=1;
      else
         pre2=cont+1;
      end;
      %Determines which side of each line is inside outside each zone 
      while flagn,         
         if cont==1
            next=n(l);
         else
            next=cont-1;
         end;
         if flagc(l,next)~=0
            flagn=0;
         end;
         if pre==0
            if flagm(l,cont)~=2,
               if flagm(l,next)==2
                  if z(next,2)>z(cont,2)
                     flagc(l,cont)=2;
                  else
                     flagc(l,cont)=1;
                  end;
               else
                  if m(l,next)<m(l,cont)
                     flagc(l,cont)=1;
                  else
                     flagc(l,cont)=2;
                  end;
               end;
            else
               flagc(l,cont)=2;
            end;
         else
            if flagm(l,cont)~=2            
               if z(cont,1)<z(pre,1)
                  if z(pre2,1)>z(pre,1)
                     flagc(l,cont)=flagc(l,pre);
                  elseif z(pre2,1) == z(pre,1)
                     if z(pre2,2)<z(pre,2)
                        flagc(l,cont)=flagc(l,pre);
                     else
                        if flagc(l,pre)==1
                           flagc(l,cont)=2;
                        else
                           flagc(l,cont)=1;
                        end;
                     end;
                  else
                     if flagc(l,pre)==1
                        flagc(l,cont)=2;
                     else
                        flagc(l,cont)=1;
                    end;
                  end;
               elseif z(cont,1)==z(pre,1)
                  if z(cont,2)<z(pre,2)
                     if z(pre2,1)>z(pre,1)
                        if flagc(l,pre)==1
                           flagc(l,cont)=2;
                        else
                           flagc(l,cont)=1;
                        end;
                     else
                        flagc(l,cont)=flagc(l,pre);
                     end;
                  else
                     if z(pre2,1)<z(pre,1)
                        if flagc(l,pre)==1
                           flagc(l,cont)=2;
                        else
                           flagc(l,cont)=1;
                        end;
                     else
                        flagc(l,cont)=flagc(l,pre);
                     end;
                  end;                                                            
               else                  
                  if z(pre2,1)>z(pre,1)
                     if flagc(l,pre)==1
                        flagc(l,cont)=2;
                     else
                        flagc(l,cont)=1;
                     end;
                  elseif z(pre2,1)==z(pre,1)
                     if z(pre2,2)>z(pre,2)
                        flagc(l,cont)=flagc(l,pre);
                     else
                        if flagc(l,pre)==1
                           flagc(l,cont)==2;
                        else
                           flagc(l,cont)=1;
                        end;
                     end;
                  else
                     flagc(l,cont)=flagc(l,pre);
                  end;
               end;
            else                          
               if z(pre,2)>z(cont,2)
                  if z(pre,1)<z(pre2,1)
                     if flagc(l,pre)==1
                        flagc(l,cont)=2;
                     else
                        flagc(l,cont)=1
                     end;
                  else
                     flagc(l,cont)=flagc(l,pre);
                  end;
               else
                  if z(pre,1)<z(pre2,1)
                     flagc(l,cont)=flagc(l,pre);
                  else
                     if flagc(l,pre)==1
                        flagc(l,cont)=2;
                     else
                        flagc(l,cont)=1;
                     end;
                  end;
               end;
            end;
            pre2=pre;
         end;
         pre=cont;
         cont=next;
      end;
   end;
end;
         
         
            
            
                        
                           
                        
                      
                        
                        
                     
                     

   
      
         