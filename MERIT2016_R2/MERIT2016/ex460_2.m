%      PROGRAM NAME: shckt.m
%      shckt makes a complete 3 phase and single line to
%      ground fault study.
%
%      The line impedance in both, positive and zero sequence 
%      for the system network are needed in order to do the
%      fault study.
%
%      The fault study analysis uses the system impedance matrix
%      for both positive and zero sequence.
%
%      The program allows three different posibilities while 
%      calculating  the impedance matrix:
%
%        1)To see the Z calculation step by step.
%        2)To see only the final Z.
%        3) No calculation is shown.
%
%      The Fault study final report gives the bus and line
%      current and voltage values for both 3ph and SLG faults.
%
%       
%
%      This program is based on Chapter 12 of: 
%        "Analysis of Faulted Power Systems",
%	      Paul. Anderson.
%            

    	
	
	clear all	
	imag=1*i;
        afactor = .5 + imag* .866; 
	x=input('enter filename >','s');
	[fid,mes]=fopen(x,'r');
   flag0 = menu('Show the Zmatrix calculation step by step','Yes','No'); 
   flag1 = menu('Show the Input data','Yes','No'); 
   flag2 = 2;
       if flag0 == 2
        flag2 = menu('Show the Final Zmatrix ','Yes','No');
       end
%********************************************
% reading the network data for positive seq.
%********************************************

	a=fscanf(fid,'%f',2);
	nbus=a(1);
	lbus=a(2);
clc
if flag1 == 1
fprintf(2,' The system %s has %i buses \n\n',x,nbus);

fprintf(2,' Positive sequence network data \n');
fprintf(2,' It has the following line impedances (in p.u.) \n');
pause
end
% the line impedances and admitances
        for  k=1:lbus
	   a=fscanf(fid,'%f',4);
              p(k)   = a(1);
              q(k)   = a(2); 
              r1(k)  = a(3); 
              xl1(k) = a(4);
	      z1(k)  = r1(k) + i*xl1(k);
if flag1 == 1
fprintf(2,' from bus %i to bus %i Resistance = %i Reactance = %i \n',p(k),q(k),r1(k),xl1(k));
pause
end
        end
%***************************************
% saving the variables for future use
pseq1 = p;
qseq1 = q;
lbus1 = lbus;
zseq1 = z1;


%****************************************
%  Ordering the datas for the calculation
%****************************************
% First the ones connected to ground (0)
index = 1;
for k = 1 : lbus
  if p(k) == 0
   
   ptemp = p(index);
   qtemp = q(index);
   z1temp =z1(index);
   
   p(index) = p(k);
   q(index) = q(k);
   z1(index) = z1(k);

   p(k) = ptemp;
   q(k) = qtemp;
   z1(k) = z1temp;
   
   index = index + 1;
  end
  if q(k) == 0

   ptemp = p(index);
   qtemp = q(index);
   z1temp =z1(index);
   
   p(index) = q(k);
   q(index) = p(k);
   z1(index) = z1(k);

   p(k) = ptemp;
   q(k) = qtemp;
   z1(k) = z1temp;
   
   index = index + 1;
  
  end
end 

% now the ones that already exists

existe = 0; 
k=index;

while k<=lbus,
 for j = 1 : index - 1
  if ( p(k)==p(j)|p(k)==q(j))
     existe = 1;
     break
  else
     existe = 0;
  end
 end
  
 if existe == 1
  
   ptemp = p(index);
   qtemp = q(index);
   z1temp =z1(index);
   
   p(index) = p(k);
   q(index) = q(k);
   z1(index) = z1(k);

   p(k) = ptemp;
   q(k) = qtemp;
   z1(k) = z1temp;
   
   index = index + 1;
   k = index;
   else
    k = k + 1;
   end
end  

existe = 0; 
k=index;

while k<=lbus,
 for j = 1 : index - 1
  if ( q(k)==p(j)|q(k)==q(j))
     existe = 1;
     break;
  else
     existe = 0;
  end
 end
 if existe == 1
   if k ~= index
    ptemp = p(index);
    qtemp = q(index);
    z1temp =z1(index);
   
    p(index) = q(k);
    q(index) = p(k);
    z1(index) = z1(k);

    p(k) = ptemp;
    q(k) = qtemp;
    z1(k) = z1temp;
   else
    ptemp = p(index);
    p(index) = q(index);
    q(index) = ptemp;
   end
   index = index + 1;
   k = index;
   else
   k = k + 1;
 end

end  




%  **************************************  
%	building the Z1 matrix
%   based on Anderson Chapter 12
%****************************************
if flag0 == 1
clc
fprintf(2,'**BUILDING THE POSITIVE SEQ.IMPEDANCE MATRIX**\n ');
pause
end
	 for k=1:lbus
	  if p(k) ==0

if flag0 == 1
clc
fprintf(2,'Adding a radial impedance from node %i  to the reference node\n',q(k));
fprintf(2,' Set Z1(%i,%i) = z1(0,%i) \n',q(k),q(k),q(k));
pause

	    Zeta1(q(k),q(k)) = z1(k)
	   pause
else
          Zeta1(q(k),q(k)) = z1(k);
end
	  else
	   for j=1:k-1		 
	     if q(k) == q(j)
	        existe=1;
	        break
	     else 
	     existe=0;
	     end
	   end

	 if existe == 1

if flag0 == 1
clc
fprintf(2,'Closing a loop from node %i to node %i \n',p(k),q(k));
end
% ------------existe
Zd=Zeta1(p(k),p(k))+Zeta1(q(k),q(k))-Zeta1(q(k),p(k))-Zeta1(p(k),q(k))+z1(k);
Zaux1=(Zeta1(:,q(k))-Zeta1(:,p(k)))*inv(Zd)*(Zeta1(q(k),:)-Zeta1(p(k),:)); 

if flag0 == 1
fprintf(2,'Node %i is already defined \n',q(k));
fprintf(2, 'Set a new column q and a new row q, q = nbus +1 \n');
fprintf(2, 'Set Z1(:,q) = Z1(:,%i) - Z1(:,%i) \n',q(k),p(k));
fprintf(2, 'Set Z1(q,:) = Z1(%i,:) - Z1(%i,:) \n',q(k),p(k));
fprintf(2, 'Set Z1(q,q) = Z1(%i,%i) + Z1(%i,%i) - Z1(%i,%i) -Z1(%i,%i)+ z1(%i,%i) \n',p(k),p(k),q(k),q(k),p(k),q(k),q(k),p(k),p(k),q(k));
fprintf(2, 'Eliminate row q, column q by Kron reduction \n');
pause
Zeta1=Zeta1-Zaux1
pause
else
Zeta1=Zeta1-Zaux1;
end
	     else
%-------------no existe
if flag0 == 1
clc
fprintf(2,'Adding a radial branch from node %i to the new node %i\n',p(k),q(k));
fprintf(2,'Node %i is new \n',q(k));
fprintf(2, 'Set Z1(:,%i) = Z1(:,%i) \n',q(k),p(k));
fprintf(2, 'Set Z1(%i,:) = Z1(%i,:) \n',q(k),p(k));
fprintf(2, 'Set Z1(%i,%i) = Z1(%i,%i) + z1(%i,%i) \n',q(k),q(k),p(k),p(k),p(k),q(k));
pause
end
	Zeta1(:,q(k))= Zeta1(:,p(k));
        Zeta1(q(k),:)=Zeta1(p(k),:);
if flag0 == 1
	Zeta1(q(k),q(k))=Zeta1(p(k),p(k)) + z1(k)
        pause
else
	Zeta1(q(k),q(k))=Zeta1(p(k),p(k)) + z1(k);
end
	     end
	   end
	  end

if flag0 == 1 | flag2 == 1
clc
fprintf(2,'The final positive seq. matrix is\n');
Zeta1
pause
end

clear multi
clear p
clear q

%*************************************
%  Reading the network data
%  for zero sequence
%*************************************

	a=fscanf(fid,'%f',2);
	nbus=a(1);
	lbus=a(2);
	
       
        cnt = 0;

clc
if flag1 == 1
fprintf(2,' Zero sequence network data \n');
fprintf(2,' It has the following line impedances (in p.u.) \n');
pause	
end
% the line impedances and admitances
        for  k=1:lbus
	   a=fscanf(fid,'%f',5);
           
              p(k) = a(1);
              q(k)   = a(2); 

              ro(k)      = a(3);
              xlo(k)      = a(4);
	      zo(k)  = ro(k) + i*xlo(k);
if flag1 == 1
fprintf(2,'from bus %i to bus %i Resistance = %i Reactance = %i \n',p(k),q(k),ro(k),xlo(k));
pause
end

	      multi(k)   = a(5);

 	   if a(5) ~= 0

	    for j=1:a(5)
              b=fscanf(fid,'%f',4);
	        m(k,j) = b(1);
	        n(k,j)   = b(2);
	        rmo(k,j)    = b(3);
	        xmo(k,j)    = b(4);
		zmo(k,j) = rmo(k,j) + i*xmo(k,j);
if flag1 == 1
fprintf(2,'   branch %i - %i is mutually coupled to branch %i - %i \n',p(k),q(k),m(k,j),n(k,j) );
fprintf(2,'   mutual resistance = %i , mutual reactance = %i \n',rmo(k,j),xmo(k,j));
pause
end
	    end
	   end
	 end
fclose(fid);
%*****************************************
% saving the variables for future use

pseqo = p;
qseqo = q;
zseqo = zo;
multio = multi;
mo = m;
no = n;
zmseqo = zmo;
lbuso = lbus;


%****************************************
%  Ordering the datas for the calculation
%****************************************
%**************************************
% Re-arranging the zero seq. datas
%**************************************

% First the ones connected to ground (0)

index = 1;
for k = 1 : lbus
  if p(k) == 0
   
   ptemp = p(index);
   qtemp = q(index);
   zotemp =zo(index);
   multitemp = multi(index);
   if multitemp ~= 0
    mtemp = m(index,:);
    ntemp = n(index,:);
    zmotemp = zmo(index,:);
   end

   p(index) = p(k);
   q(index) = q(k);
   zo(index) = zo(k);
   multi(index) = multi(k);
   if multi(index) ~= 0
    m(index,:) = m(k,:);
    n(index,:) = n(k,:);
    zmo(index,:) = zmo(k,:);
   end

   p(k) = ptemp;
   q(k) = qtemp;
   zo(k) = zotemp;
  
   multi(k) = multitemp;
    if multi(k) ~=0
     m(k,:) = mtemp;
     n(k,:) = ntemp;
     zmo(k,:) = zmotemp;
    end
   index = index + 1;
  end

  if q(k) == 0

   ptemp = p(index);
   qtemp = q(index);
   zotemp =zo(index);
   multitemp = multi(index);
   if multitemp ~= 0
    mtemp = m(index,:);
    ntemp = n(index,:);
    zmotemp = zmo(index,:);
   end

   p(index) = q(k);
   q(index) = p(k);
   zo(index) = zo(k);
   multi(index) = multi(k);
   if multi(index) ~= 0
    m(index,:) = m(k,:);
    n(index,:) = n(k,:);
    zmo(index,:) =  - zmo(k,:);
    for j = 1 : multi(index)
      for f = 1:lbus 
       if f ~= index
        if ( m(index,j)==p(f) & n(index,j) == q(f))
          for l = 1 : multi(f)
	    if ( m(f,l) == p(k) & n(f,l) ==q(k))
              zmo(f,l) = - zmo(f,l);
              temp = n(f,l);
              n(f,l) = m(f,l);
	      m(f,l) = temp;
            end
          end
        end
       end
      end
    end
   end
    
   
   p(k) = ptemp;
   q(k) = qtemp;
   zo(k) = zotemp;
   multi(k) = multitemp;
   if multi(k) ~= 0
     m(k,:) = mtemp;
     n(k,:) = ntemp;
     zmo(k,:) = zmotemp;   
   end
   index = index + 1;
  
  end
end 

% now the ones that already exists


existe = 0; 
k=index;

while k<=lbus,
 for j = 1 : index - 1
  if ( p(k)==p(j)|p(k)==q(j))
     existe = 1;
     break;
  else
     existe = 0;
  end
 end
 if existe == 1
   ptemp = p(index);
   qtemp = q(index);
   zotemp =zo(index);
   multitemp = multi(index);
   if multitemp ~= 0
    mtemp = m(index,:);
    ntemp = n(index,:);
    zmotemp = zmo(index,:);
   end

   p(index) = p(k);
   q(index) = q(k);
   zo(index) = zo(k);
   multi(index) = multi(k);

   if multi(index) ~= 0
    m(index,:) = m(k,:);
    n(index,:) = n(k,:);
    zmo(index,:) = zmo(k,:);
   end

   p(k) = ptemp;
   q(k) = qtemp;
   zo(k) = zotemp;
   multi(k) = multitemp;

    if multi(k) ~=0
     m(k,:) = mtemp;
     n(k,:) = ntemp;
     zmo(k,:) = zmotemp;
    end


   index = index + 1;
   k = index;
   else
   k = k + 1;
 end
 
end  

existe = 0; 
k=index;

while k<=lbus,
 for j = 1 : index - 1
  if ( q(k)==p(j)|q(k)==q(j))
     existe = 1;
     break;
  else
     existe = 0;
  end
 end
 if existe == 1
   if k~=index
   ptemp = p(index);
   qtemp = q(index);
   zotemp =zo(index);
   multitemp = multi(index);
   if multitemp ~= 0
    mtemp = m(index,:);
    ntemp = n(index,:);
    zmotemp = zmo(index,:);
   end


   p(index) = q(k);
   q(index) = p(k);
   zo(index) = zo(k);
   multi(index) = multi(k);
   if multi(index) ~= 0
    m(index,:) = m(k,:);
    n(index,:) = n(k,:);
    zmo(index,:) = - zmo(k,:);
    for j = 1 : multi(index)
      for f = 1:lbus 
       if f ~= index
        if ( m(index,j)==p(f) & n(index,j) == q(f))
          for l = 1 : multi(f)
	    if ( m(f,l) == p(k) & n(f,l) ==q(k))
              zmo(f,l) = - zmo(f,l);
              temp = n(f,l);
              n(f,l) = m(f,l);
	      m(f,l) = temp;
            end
          end
        end
       end
      end
    end
   end


   p(k) = ptemp;
   q(k) = qtemp;
   zo(k) = zotemp;
   multi(k) = multitemp;
   if multi(k) ~= 0
     m(k,:) = mtemp;
     n(k,:) = ntemp;
     zmo(k,:) = zmotemp;   
   end
   else
    ptemp = p(index);
    p(index) = q(index);
    q(index) = ptemp;
%-----
    if multi(index)~=0
     zmo(index,:) = - zmo(index,:);
    end
    for j = 1 : multi(index)
      for f = 1:lbus 
       if f ~= index
        if ( m(index,j)==p(f) & n(index,j) == q(f))
          for l = 1 : multi(f)
	    if ( m(f,l) == q(k) & n(f,l) ==p(k))
              zmo(f,l) = - zmo(f,l);
              temp = n(f,l);
              n(f,l) = m(f,l);
	      m(f,l) = temp;
            end
          end
        end
       end
      end
    end

    
   end

   index = index + 1;
   k = index;  
  else
  k = k + 1;
 end
 
end  




%*******************************************	 
% Building the Zetao matrix	
% based on Anderson Chapter 12
%*******************************************
if flag0 == 1
clc
fprintf(2,'**BUILDING THE ZERO SEQ. IMPEDANCE MATRIX**\n ');
pause
end

for k=1:lbus

  if multi(k)==0
%------------------uncouple
    if p(k) ==0
if flag0 == 1
clc
fprintf(2,'Adding a radial impedance from node %i  to the reference node\n',q(k));
fprintf(2,' Set Zo(%i,%i) = zo(0,%i) \n',q(k),q(k),q(k));
pause
end
if flag0 == 1
      Zetao(q(k),q(k)) = zo(k)
	pause
else
      Zetao(q(k),q(k)) = zo(k);
end
    else
      for j=1:k-1		 
	if q(k) == q(j)
	   existe=1;
	   break
	 else 
	   existe=0;
	 end
       end
      if existe == 1
% ------------existe q and uncouple
if flag0 == 1
clc
fprintf(2,'Closing a loop from node %i to node %i \n',p(k),q(k));
fprintf(2,'Node %i is already defined \n',q(k));
fprintf(2,'Branch %i - %i is not mutually coupled to other network elements \n',p(k),q(k));
fprintf(2, 'Set a new column q and a new row q, q = nbus +1 \n');
fprintf(2, 'Set Zo(:,q) = Zo(:,%i) - Zo(:,%i) \n',q(k),p(k));
fprintf(2, 'Set Zo(q,:) = Zo(%i,:) - Zo(%i,:) \n',q(k),p(k));
fprintf(2, 'Set Zo(q,q) = Zo(%i,%i) + Zo(%i,%i) - Zo(%i,%i) -Zo(%i,%i)+ zo(%i,%i) \n',p(k),p(k),q(k),q(k),p(k),q(k),q(k),p(k),p(k),q(k));
fprintf(2, 'Eliminate row q, column q by Kron reduction \n');
pause
end

Zd=Zetao(p(k),p(k))+Zetao(q(k),q(k))-Zetao(q(k),p(k))-Zetao(p(k),q(k))+zo(k);
Zauxo=(Zetao(:,q(k))-Zetao(:,p(k)))*inv(Zd)*(Zetao(q(k),:)-Zetao(p(k),:)); 	         	     
if flag0 == 1
 Zetao=Zetao-Zauxo
pause
else
 Zetao=Zetao-Zauxo;
end
       else
%-------------no existe q and uncouple
if flag0 == 1
clc
fprintf(2,'Adding a radial branch from node %i to the new node %i\n',p(k),q(k));
fprintf(2,'Node %i is new \n',q(k));
fprintf(2,'Branch %i - %i is not mutually coupled to other network elements \n',p(k),q(k));
fprintf(2, 'Set Zo(:,%i) = Zo(:,%i) \n',q(k),p(k));
fprintf(2, 'Set Zo(%i,:) = Zo(%i,:) \n',q(k),p(k));
fprintf(2, 'Set Zo(%i,%i) = Zo(%i,%i) + zo(%i,%i) \n',q(k),q(k),p(k),p(k),p(k),q(k));
pause
end
        Zetao(:,q(k))= Zetao(:,p(k));
         Zetao(q(k),:)=Zetao(p(k),:);
if flag0 == 1
         Zetao(q(k),q(k))=Zetao(p(k),p(k)) + zo(k)
	pause
else 
         Zetao(q(k),q(k))=Zetao(p(k),p(k)) + zo(k);
end      
      end
     end
    else
%-------------mutual couple
  for j=1:multi(k)
 
   for l = 1: k-1
     if m(k,j) == p(l) & n(k,j) == q(l)
	mexiste=1;
	break;
     else 
	mexiste=0;
     end
   end
   if mexiste==1
	break
   end
  end
   if mexiste==0
%------------nobody yet
 for j=1:k-1		 
	if q(k) == q(j)
	   existe=1;
	   break
	 else 
	   existe=0;
	 end
       end
      if existe == 1
% ------------existe q and couple
if flag0 == 1
clc
fprintf(2,'Closing a loop from node %i to node %i \n',p(k),q(k));
fprintf(2,'Node %i is already defined \n',q(k));
fprintf(2,'Although branch %i - %i is mutually coupled to other network elements, \n',p(k),q(k));
fprintf(2,' these elements are not present yet \n');
fprintf(2, 'Set a new column q and a new row q, q = nbus +1 \n');
fprintf(2, 'Set Zo(:,q) = Zo(:,%i) - Zo(:,%i) \n',q(k),p(k));
fprintf(2, 'Set Zo(q,:) = Zo(%i,:) - Zo(%i,:) \n',q(k),p(k));
fprintf(2, 'Set Zo(q,q) = Zo(%i,%i) + Zo(%i,%i) - Zo(%i,%i) -Zo(%i,%i)+ zo(%i,%i) \n',p(k),p(k),q(k),q(k),p(k),q(k),q(k),p(k),p(k),q(k));
fprintf(2, 'Eliminate row q, column q by Kron reduction \n');
pause
end

Zd=Zetao(p(k),p(k))+Zetao(q(k),q(k))-Zetao(q(k),p(k))-Zetao(p(k),q(k))+zo(k);
Zauxo=(Zetao(:,q(k))-Zetao(:,p(k)))*inv(Zd)*(Zetao(q(k),:)-Zetao(p(k),:)); 	         	     
if flag0 == 1
Zetao=Zetao-Zauxo
pause
else
Zetao=Zetao-Zauxo;
end
       else
%-------------no existe q and couple
if flag0 == 1
clc
fprintf(2,'Adding a radial branch from node %i to the new node %i\n',p(k),q(k));
fprintf(2,'Node %i is new \n',q(k));
fprintf(2,'Although branch %i - %i is mutually coupled to other network elements, \n',p(k),q(k));
fprintf(2,' these elements are not present yet \n');
fprintf(2, 'Set Zo(:,%i) = Zo(:,%i) \n',q(k),p(k));
fprintf(2, 'Set Zo(%i,:) = Zo(%i,:) \n',q(k),p(k));
fprintf(2, 'Set Zo(%i,%i) = Zo(%i,%i) + zo(%i,%i) \n',q(k),q(k),p(k),p(k),p(k),q(k));
pause
end

        Zetao(:,q(k))= Zetao(:,p(k));
         Zetao(q(k),:)=Zetao(p(k),:);
if flag0 == 1
         Zetao(q(k),q(k))=Zetao(p(k),p(k)) + zo(k)
	pause
else
         Zetao(q(k),q(k))=Zetao(p(k),p(k)) + zo(k) ;
end
      end

   else
%--------oh ! somebody!!!!-------
%-----well I need to build the Z matrix 
 Z1(1,1)= zo(k);
  i=1;
  ii=1;
%--------with 1,1

  for j=1:multi(k)
 
   for l = 1: k-1
     if m(k,j) == p(l) & n(k,j) == q(l)
     Z1(ii+1,ii+1)=zo(l);
     Z1(i,ii+1) = zmo(k,j);
     Z1(ii+1,i) = Z1(i,ii+1);
     esta(ii)=j;
	ii=ii+1;
     break;
     else 
     end
   end

  end
  
%----------with the others
  jj=1;
  i = 1;
  while (i<= (ii-1)),

   j=esta(i);
   jj=i+1;
   if jj>=ii
	break;
	else 
	end
   
   for l=1:k-1
    if m(k,j) ==p(l) & n(k,j) ==q(l)
        for y=1:multi(l)
	   if m(k,esta(jj))==m(l,y) & n(k,esta(jj))==n(l,y)
	     Z1(i+1,jj+1)=zmo(l,y);
	     Z1(jj+1,i+1)=zmo(l,y);
	     jj=jj+1;
	     if jj>ii
	       break
	     else 
	     end
     	     break
            else
            end
	end
    else
    end
   end
   i=i+1;
 
   end

   y1=inv((Z1));

% ------ok I have Ybus for coupling
   for j=1:k-1		 
    if q(k) == q(j)
     existe=1;
     break
    else 
     existe=0;
    end
   end
   if existe ==1
%---------is couple and exist
if flag0 ==1
clc
fprintf(2,'Closing a loop from node %i to node %i \n',p(k),q(k));
fprintf(2,'branch %i - %i is coupled with : \n',p(k),q(k));
  for iax = 1:multi(k)
   fprintf(2,'branch %i - %i \n',m(k),n(k));
  end
pause
fprintf(2,'Conditions \n');
fprintf(2,' branch %i - %i is coupled to branch m - n \n',p(k),q(k));
fprintf(2, 'The mutual impedance is zmo \n');
pause
fprintf(2,'The following rules apply :\n');
fprintf(2,'Set Zo(%i,:) = Zo (%i,:) - (zmo/zo(m,n))(Zo(m,:)-Zo(n,:) \n',q(k),p(k));
fprintf(2,'Set Zo(:,%i) = Zo (:,%i) \n',q(k),q(k));
fprintf(2,'Set Zo(%i,%i) = Zo(%i,%i) + zo(%i,%i) - (zmo/zo(m,n))(zmo + Zo(m,%i) - Zo(n,%i)) \n',q(k),q(k),p(k),q(k),p(k),q(k),q(k),q(k));
pause
end

 for j=1:multi(k)
 
   for l = 1: k-1
     if m(k,j) == p(l) & n(k,j) == q(l)
	Zmat(j,:)=Zetao(p(l),:)-Zetao(q(l),:);
	break;
     else 	
     end
   end 
 end
 
 colvar=length(y1);
Zaux=Zetao(p(k),:)-Zetao(q(k),:)+(y1(1:1,2:colvar)*Zmat)/y1(1,1);

 clear Zmat;
 for j=1:multi(k)
   for l = 1: k-1
     if m(k,j) == p(l) & n(k,j) == q(l)
	Zmat(j)=Zaux(p(l))-Zaux(q(l));
	break;
     else 
     end
   end 
 end
  Zmat=conj(Zmat');
Zd=Zaux(p(k))-Zaux(q(k))+ (1+(y1(1:1,2:colvar)*Zmat))./y1(1,1);
Zaux=conj(Zaux')*inv(Zd)*Zaux;
if flag0 == 1
Zetao=Zetao-Zaux
pause
else
Zetao=Zetao-Zaux;
end

clear Zmat;
clear y1;
clear Z1;
   else
%-------is couple but does not exist
if flag0 == 1
clc
fprintf(2,'Adding a radial branch from node %i to the new node %i\n',p(k),q(k));
fprintf(2,'branch %i - %i is coupled with : \n',p(k),q(k));
  for iax = 1:multi(k)
   fprintf(2,'branch %i - %i \n',m(k),n(k));
  end
fprintf(2,'Conditions \n');
fprintf(2,'Add branch from %i to %i as the uncoupled case \n',p(k),q(k));
fprintf(2,' branch %i - %i is coupled to branch m - n \n',p(k),q(k));
fprintf(2, 'The mutual impedance is zmo \n');
pause
fprintf(2,'The following rules apply :\n');
fprintf(2,'Set Zo(%i,:) = Zo (%i,:) - (zmo/zo(m,n))(Zo(m,:)-Zo(n,:) \n',q(k),p(k));
fprintf(2,'Set Zo(:,%i) = Zo (:,%i) \n',q(k),q(k));
fprintf(2,'Set Zo(%i,%i) = Zo(%i,%i) + zo(%i,%i) - (zmo/zo(m,n))(zmo + Zo(m,%i) - Zo(n,%i)) \n',q(k),q(k),p(k),q(k),p(k),q(k),q(k),q(k));


pause
end

 for j=1:multi(k)
 
   for l = 1: k-1
     if m(k,j) == p(l) & n(k,j) == q(l)
	Zmat(j,:)=Zetao(p(l),:)-Zetao(q(l),:);
	break;
     else 	
     end
   end 
 end
 colvar=length(y1);

 Zetao(q(k),:) = Zetao(p(k),:)+(y1(1:1,2:colvar)*Zmat)./y1(1,1);


 clear Zmat;
 for j=1:multi(k)
   for l = 1: k-1
     if m(k,j) == p(l) & n(k,j) == q(l)
	Zmat(:,j)=Zetao(:,p(l))-Zetao(:,q(l));
	break;
     else 	
     end
   end 
 end
Zetao(q(k),q(k))=Zetao(q(k),p(k))+(1+(y1(1:1,2:colvar)*Zmat(q(k))))/y1(1,1);

if flag0 == 1
Zetao(:,q(k)) =conj(Zetao(q(k),:))'
pause
else
Zetao(:,q(k)) =conj(Zetao(q(k),:))';
end

clear Zmat;
clear y1;
clear Z1;
   end
   end
 end
end
 
if flag0 == 1 | flag2 == 1
clc 
fprintf(2,'The final zero seq. matrix is: \n');
Zetao
pause
end


%	function that calculates the short circuit values
%	name: shck
	
	freq=60;
	PI=4*atan(1);
	rad_deg = 360 / (2 * PI);
	imag=1*i;
	afactor=-.5+.866*imag;

%----- here the calculation of currents and voltages

ref = 230^2/100;
vref=230;
iref=251;


for i=1:nbus

 if (Zeta1(i,i)== 0)
   Zeta1(i,i) = 1e-6;
 end

 p3f(i) = 1./ Zeta1(i,i); 
 abajo = Zetao(i,i) + 2 *Zeta1(i,i);
  if (abajo == 0)
    abajo = 1e-6;
  end

  p1fg(i) = 1/abajo;
  p1fgt(i)= 3 * p1fg(i);
   for j = 1:nbus
    v3f(i,j) = (Zeta1(i,i)- Zeta1(j,i))/Zeta1(i,i);
    v01f(i,j) = -Zetao(j,i) / abajo;
    v21f(i,j) = -Zeta1(j,i) /  abajo;
    v11f(i,j) = 1. - Zeta1(j,i) / abajo;
   end
 for k = 1:lbus1
  if zseq1(k) == 0;
    zseq1(k) = 1e-6;
  else
  end
  if pseq1(k) == 0
   i3fll(i,k) = (1. -v3f(i,qseq1(k)))/(zseq1(k));
   i11f(i,k) = (1. - v11f(i,qseq1(k)))/(zseq1(k));
  else
   i3fll(i,k) = (v3f(i,pseq1(k))-v3f(i,qseq1(k)))/(zseq1(k));
   i11f(i,k) = (v11f(i,pseq1(k))-v11f(i,qseq1(k)))/(zseq1(k));
  end
 end   
 for k = 1:lbuso
  if zseqo(k) == 0
    zseqo(k) = 1e-6;
  else
  end
  if pseqo(k) == 0
   i01f(i,k) = -v01f(i,qseqo(k))/(zseqo(k));
  else
   if multio(k) == 0
    i01f(i,k) = (v01f(i,pseqo(k)) - v01f(i,qseqo(k)))/(zseqo(k));
   else
    %----building again y1

%-----well I need to build the Z matrix 
 Z1(1,1)= zseqo(k);
  ji=1;
  ii=1;
%--------with 1,1

  for j=1:multio(k)
 
   for l = 1: lbuso
     if mo(k,j) == pseqo(l) & no(k,j) == qseqo(l)
     Z1(ii+1,ii+1)=zseqo(l);
     Z1(ji,ii+1) = zmseqo(k,j);
     Z1(ii+1,ji) = Z1(ji,ii+1);
     esta(ii)=j;
	ii=ii+1;
     break;
     else 
     end
   end

  end
  
%----------with the others
  jj=1;
  ji = 1;
  while (ji<= (ii-1)),

   j=esta(ji);
   jj=ji+1;
   if jj>=ii
	break;
	else 
	end
   
   for l=1:lbus
    if mo(k,j) ==pseqo(l) & no(k,j) ==qseqo(l)
        for y=1:multio(l)
	   if mo(k,esta(jj))==mo(l,y) & no(k,esta(jj))==no(l,y)
	     Z1(ji+1,jj+1)=zmseqo(l,y);
	     Z1(jj+1,ji+1)=zmseqo(l,y);
	     jj=jj+1;
	     if jj>ii
	       break
	     else 
	     end
     	     break
            else
            end
	end
    else
    end
end
   ji=ji+1
end 
   
   y1=inv(Z1);

     for pp = 1:multio(k)
      add= y1(1,pp+1)*(v01f(i,mo(k,pp))-v01f(i,no(k,pp)));
     end
     i01f(i,k) = y1(1,1)*(v01f(i,pseqo(k))-v01f(i,qseqo(k)))+add;

   end
  end

end  
end

fid = 2;
answer = 'y';
while answer == 'y'
clc
x = input(' enter the faulted node >');


for i=1:nbus
 if x == i
 clc
 fprintf(fid,'\n****Fault at  BUS No    %i*******\n',i);
 fprintf(fid,'\n      BUS DATA \n');
 fprintf(fid,'\n      Three Phase Fault \n');
 fprintf(fid,'\n      Total injected current: \n');
 fprintf(fid,'\n   Amps.       Deg. \n');
 fprintf(fid,'  %6.3f    < %6.2f\n',abs(p3f(i)),rad_deg*angle(p3f(i)));
 pause
 fprintf(fid,'\n      Single  Line to Ground Fault\n');
 fprintf(fid,'\n Sequence Domain  \n');
 fprintf(fid,'\n   Volts       Deg.     Amps.    Deg.    Seq.    \n');
 fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f   P \n',abs(v11f(i,i)),rad_deg*angle(v11f(i,i)),abs(p1fg(i)),rad_deg*angle(p1fg(i)));
 fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f   N \n',abs(v21f(i,i)),rad_deg*angle(v21f(i,i)),abs(p1fg(i)),rad_deg*angle(p1fg(i)));
 fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f   Z \n',abs(v01f(i,i)),rad_deg*angle(v01f(i,i)),abs(p1fg(i)),rad_deg*angle(p1fg(i)));
  pause
 fprintf(fid,'\n Phase Domain \n');
 fprintf(fid,'     Va         < a        Vb      < b        Vc        < c \n');
 Volta = v01f(i,i) + v11f(i,i) + v21f(i,i);
 Voltc = v01f(i,i) + v11f(i,i)*afactor + v21f(i,i)*afactor^2;
 Voltb = v01f(i,i) + v11f(i,i)*afactor^2 + v21f(i,i)*afactor;
 fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f     %6.3f     <%6.2f\n',abs(Volta),rad_deg*angle(Volta),abs(Voltb),rad_deg*angle(Voltb),abs(Voltc),rad_deg*angle(Voltc));
 cura = p1fg(i) * 3;
 curb = cura * afactor * 2;
 curc = cura * afactor;
 fprintf(fid,'     Ia         < a        Ib      < b        Ic        < c \n');
 fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f     %6.3f     <%6.2f\n',abs(cura),rad_deg*angle(cura),abs(curb),rad_deg*angle(curb),abs(curc),rad_deg*angle(curc));
 pause
 jj = 1;
 fprintf(fid,'\n      LINE DATA \n');
  for j = 1:lbus1
   if pseq1(j) == i
     indexq(jj) = qseq1(j);
     indexp(jj) = pseq1(j); 
     jj = jj + 1;
fprintf(fid,'\n  from %i  to %i \n', qseq1(j),pseq1(j));
fprintf(fid,'\n      Three Phase Fault \n');
fprintf(fid,'\n   Volts       Deg.     Amps.    Deg.\n');
fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f \n',abs(v3f(i,qseq1(j))),rad_deg*angle(v3f(i,qseq1(j))),abs(i3fll(i,j)),rad_deg*angle(-i3fll(i,j)));     
pause
fprintf(fid,'\n      Single  Line to Ground Fault\n');
fprintf(fid,'\n Sequence Domain  \n');
fprintf(fid,'\n   Volts       Deg.     Amps.    Deg.    Seq.    \n');
fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f   P \n',abs(v11f(i,qseq1(j))),rad_deg*angle(v11f(i,qseq1(j))),abs(i11f(i,j)),rad_deg*angle(-i11f(i,j)));
fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f   N \n',abs(v21f(i,qseq1(j))),rad_deg*angle(v21f(i,qseq1(j))),abs(i11f(i,j)),rad_deg*angle(-i11f(i,j)));

isthere = 0;
 for k = 1:lbuso
  if(pseqo(k)==i & qseqo(k)==qseq1(j))
 fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f   Z \n',abs(v01f(i,qseqo(k))),rad_deg*angle(v01f(i,qseqo(k))),abs(i01f(i,k)),rad_deg*angle(-i01f(i,k)));
  pause
 fprintf(fid,'\n Phase Domain \n');
 fprintf(fid,'     Va         < a        Vb      < b        Vc        < c \n');
 Volta = v01f(i,qseqo(k)) + v11f(i,qseq1(j)) + v21f(i,qseq1(j));
 Voltc = v01f(i,qseqo(k)) + v11f(i,qseq1(j))*afactor + v21f(i,qseq1(j))*afactor^2;
 Voltb = v01f(i,qseqo(k)) + v11f(i,qseq1(j))*afactor^2 + v21f(i,qseq1(j))*afactor;
 fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f     %6.3f     <%6.2f\n',abs(Volta),rad_deg*angle(Volta),abs(Voltb),rad_deg*angle(Voltb),abs(Voltc),rad_deg*angle(Voltc));
 cura = -2*i11f(i,j) - i01f(i,k);
 curb = -i01f(i,k) - i11f(i,j)*afactor - i11f(i,j)*afactor^2;
 curc = -i01f(i,k) - i11f(i,j)*afactor - i11f(i,j)*afactor^2;;
 fprintf(fid,'     Ia         < a        Ib      < b        Ic        < c \n');
 fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f     %6.3f     <%6.2f\n',abs(cura),rad_deg*angle(cura),abs(curb),rad_deg*angle(curb),abs(curc),rad_deg*angle(curc));
 pause

  isthere = 1;
  break;
  end
end
if isthere == 0
fprintf(fid,'   0.00     <0.0         0.00    <0.0   Z \n');
pause
 fprintf(fid,'\n Phase Domain \n');
 fprintf(fid,'     Va         < a        Vb      < b        Vc        < c \n');
 Volta = 0.00 + v11f(i,qseq1(j)) + v21f(i,qseq1(j));
 Voltc = 0.00 + v11f(i,qseq1(j))*afactor + v21f(i,qseq1(j))*afactor^2;
 Voltb = 0.00 + v11f(i,qseq1(j))*afactor^2 + v21f(i,qseq1(j))*afactor;
 fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f     %6.3f     <%6.2f\n',abs(Volta),rad_deg*angle(Volta),abs(Voltb),rad_deg*angle(Voltb),abs(Voltc),rad_deg*angle(Voltc));
 cura = -2*i11f(i,j) - 0.00;
 curb = -0.00 - i11f(i,j)*afactor - i11f(i,j)*afactor^2;
 curc = -0.00 - i11f(i,j)*afactor - i11f(i,j)*afactor^2;;
 fprintf(fid,'     Ia         < a        Ib      < b        Ic        < c \n');
 fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f     %6.3f     <%6.2f\n',abs(cura),rad_deg*angle(cura),abs(curb),rad_deg*angle(curb),abs(curc),rad_deg*angle(curc));
 pause
end

  end ;   

end  ; 

for j = 1:lbus1
  if qseq1(j) == i & pseq1(j) ~= 0 
     indexq(jj) = qseq1(j);
     indexp(jj) = pseq1(j); 
     jj = jj +1;
fprintf(fid,'\n  from %i  to %i \n', pseq1(j),qseq1(j));
fprintf(fid,'\n      Three Phase Fault \n');
fprintf(fid,'\n   Volts       Deg.     Amps.    Deg.\n');
fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f \n',abs(v3f(i,pseq1(j))),rad_deg*angle(v3f(i,pseq1(j))),abs(i3fll(i,j)),rad_deg*angle(i3fll(i,j)));     
pause
fprintf(fid,'\n      Single  Line to Ground Fault\n');
fprintf(fid,'\n Sequence Domain  \n');
fprintf(fid,'\n   Volts       Deg.     Amps.    Deg.    Seq.    \n');
fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f   P \n',abs(v11f(i,pseq1(j))),rad_deg*angle(v11f(i,pseq1(j))),abs(i11f(i,j)),rad_deg*angle(i11f(i,j)));
fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f   N \n',abs(v21f(i,pseq1(j))),rad_deg*angle(v21f(i,pseq1(j))),abs(i11f(i,j)),rad_deg*angle(i11f(i,j)));


isthere = 0;
 for k = 1:lbuso
  if(qseqo(k)==i & pseqo(k)==pseq1(j))
 fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f   Z \n',abs(v01f(i,pseqo(k))),rad_deg*angle(v01f(i,pseqo(k))),abs(i01f(i,k)),rad_deg*angle(i01f(i,k)));
 pause
 fprintf(fid,'\n Phase Domain \n');
 fprintf(fid,'     Va         < a        Vb      < b        Vc        < c \n');
 Volta = v01f(i,pseqo(k)) + v11f(i,pseq1(j)) + v21f(i,pseq1(j));
 Voltc = v01f(i,pseqo(k)) + v11f(i,pseq1(j))*afactor + v21f(i,pseq1(j))*afactor^2;
 Voltb = v01f(i,pseqo(k)) + v11f(i,pseq1(j))*afactor^2 + v21f(i,pseq1(j))*afactor;
 fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f     %6.3f     <%6.2f\n',abs(Volta),rad_deg*angle(Volta),abs(Voltb),rad_deg*angle(Voltb),abs(Voltc),rad_deg*angle(Voltc));
 cura = -2*i11f(i,j) - i01f(i,k);
 curb = -i01f(i,k) - i11f(i,j)*afactor - i11f(i,j)*afactor^2;
 curc = -i01f(i,k) - i11f(i,j)*afactor - i11f(i,j)*afactor^2;;
 fprintf(fid,'     Ia         < a        Ib      < b        Ic        < c \n');
 fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f     %6.3f     <%6.2f\n',abs(cura),rad_deg*angle(cura),abs(curb),rad_deg*angle(curb),abs(curc),rad_deg*angle(curc));
 pause

 isthere = 1;
  break;
  end
 end

if isthere == 0
fprintf(fid,'   0.00     <0.0         0.00    <0.0   Z \n');
pause
 fprintf(fid,'\n Phase Domain \n');
 fprintf(fid,'     Va         < a        Vb      < b        Vc        < c \n');
 Volta = 0.00 + v11f(i,pseq1(j)) + v21f(i,pseq1(j));
 Voltc = 0.00 + v11f(i,pseq1(j))*afactor + v21f(i,pseq1(j))*afactor^2;
 Voltb = 0.00 + v11f(i,pseq1(j))*afactor^2 + v21f(i,pseq1(j))*afactor;
 fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f     %6.3f     <%6.2f\n',abs(Volta),rad_deg*angle(Volta),abs(Voltb),rad_deg*angle(Voltb),abs(Voltc),rad_deg*angle(Voltc));
 cura = -2*i11f(i,j) - 0.00;
 curb = -0.00 - i11f(i,j)*afactor - i11f(i,j)*afactor^2;
 curc = -0.00 - i11f(i,j)*afactor - i11f(i,j)*afactor^2;;
 fprintf(fid,'     Ia         < a        Ib      < b        Ic        < c \n');
 fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f     %6.3f     <%6.2f\n',abs(cura),rad_deg*angle(cura),abs(curb),rad_deg*angle(curb),abs(curc),rad_deg*angle(curc));
 pause

end


 end 
end 

for j = 1:lbus1
  if qseq1(j) == i & pseq1(j) == 0 
     indexq(jj) = qseq1(j);
     indexp(jj) = pseq1(j); 
     jj = jj +1;
fprintf(fid,'\n  from %i  to %i \n', pseq1(j),qseq1(j));
fprintf(fid,'\n      Three Phase Fault \n');
fprintf(fid,'\n   Volts       Deg.     Amps.    Deg.\n');
fprintf(fid,'  1.000    <0.00     %6.3f    <%6.2f \n',abs(i3fll(i,j)),rad_deg*angle(i3fll(i,j)));     
pause
fprintf(fid,'\n      Single  Line to Ground Fault\n');
fprintf(fid,'\n Sequence Domain  \n');
fprintf(fid,'\n   Volts       Deg.     Amps.    Deg.    Seq.    \n');
fprintf(fid,'  0.000    <0.00     %6.3f    <%6.2f   P \n',abs(i11f(i,j)),rad_deg*angle(i11f(i,j)));
fprintf(fid,'  0.000    <0.00     %6.3f    <%6.2f   N \n',abs(i11f(i,j)),rad_deg*angle(i11f(i,j)));


isthere = 0;
 for k = 1:lbuso
  if(qseqo(k)==i & pseqo(k)==pseq1(j))
 fprintf(fid,'  0.000    <0.00     %6.3f    <%6.2f   Z \n',abs(i01f(i,k)),rad_deg*angle(i01f(i,k)));
 pause
 fprintf(fid,'\n Phase Domain \n');
 fprintf(fid,'     Va         < a        Vb      < b        Vc        < c \n');
 Volta = 0.00;
 Voltc = 0.00;
 Voltb = 0.00;
 fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f     %6.3f     <%6.2f\n',abs(Volta),rad_deg*angle(Volta),abs(Voltb),rad_deg*angle(Voltb),abs(Voltc),rad_deg*angle(Voltc));
 cura = -2*i11f(i,j) - i01f(i,k);
 curb = -i01f(i,k) - i11f(i,j)*afactor - i11f(i,j)*afactor^2;
 curc = -i01f(i,k) - i11f(i,j)*afactor - i11f(i,j)*afactor^2;;
 fprintf(fid,'     Ia         < a        Ib      < b        Ic        < c \n');
 fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f     %6.3f     <%6.2f\n',abs(cura),rad_deg*angle(cura),abs(curb),rad_deg*angle(curb),abs(curc),rad_deg*angle(curc));
 pause

 isthere = 1;
  break;
  end
 end

if isthere == 0
fprintf(fid,'   0.00     <0.0         0.00    <0.0   Z \n');
pause
 fprintf(fid,'\n Phase Domain \n');
 fprintf(fid,'     Va         < a        Vb      < b        Vc        < c \n');
 Volta = 0.00;
 Voltc = 0.00;
 Voltb = 0.00;
 fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f     %6.3f     <%6.2f\n',abs(Volta),rad_deg*angle(Volta),abs(Voltb),rad_deg*angle(Voltb),abs(Voltc),rad_deg*angle(Voltc));
 cura = -2*i11f(i,j) - 0.00;
 curb = -0.00 - i11f(i,j)*afactor - i11f(i,j)*afactor^2;
 curc = -0.00 - i11f(i,j)*afactor - i11f(i,j)*afactor^2;;
 fprintf(fid,'     Ia         < a        Ib      < b        Ic        < c \n');
 fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f     %6.3f     <%6.2f\n',abs(cura),rad_deg*angle(cura),abs(curb),rad_deg*angle(curb),abs(curc),rad_deg*angle(curc));
 pause

end


 end 
end 

for j = 1:lbuso
   existe = 0;
   
   for k = 1 : length(indexp)
      if qseqo(j) == indexq(k) & pseqo(j) == indexp(k)
           existe = 1;
           break
      else
      end
   end
   if existe == 0 &  qseqo(j) == i & pseqo(j) == 0
fprintf(fid,'\n  from %i  to %i \n',pseqo(j),qseqo(j));
fprintf(fid,'\n      Three Phase Fault \n');
fprintf(fid,'\n   Volts       Deg.     Amps.    Deg.\n');
fprintf(fid,'  1.000    <0.00     0.000    <0.00  \n');     
pause
fprintf(fid,'\n      Single  Line to Ground Fault\n');
fprintf(fid,'\n Sequence Domain  \n');
fprintf(fid,'\n   Volts       Deg.     Amps.    Deg.    Seq.    \n');
fprintf(fid,'  0.000    <0.00     0.000    <0.00    P \n');
fprintf(fid,'  0.000    <0.00     0.000    <0.00    N \n');
fprintf(fid,'  0.000    <0.00     %6.3f    <%6.2f   Z \n',abs(i01f(i,j)),rad_deg*angle(i01f(i,j)));          
pause
 fprintf(fid,'\n Phase Domain \n');
 fprintf(fid,'     Va         < a        Vb      < b        Vc        < c \n');
 Volta = 0.00; 
 Voltc = 0.00;
 Voltb = 0.00;
 fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f     %6.3f     <%6.2f\n',abs(Volta),rad_deg*angle(Volta),abs(Voltb),rad_deg*angle(Voltb),abs(Voltc),rad_deg*angle(Voltc));
 cura = -2*0.00 - i01f(i,k);
 curb = -i01f(i,k) - 0.00;
 curc = -i01f(i,k) - 0.00;
 fprintf(fid,'     Ia         < a        Ib      < b        Ic        < c \n');
 fprintf(fid,'  %6.3f    <%6.2f    %6.3f    <%6.2f     %6.3f     <%6.2f\n',abs(cura),rad_deg*angle(cura),abs(curb),rad_deg*angle(curb),abs(curc),rad_deg*angle(curc));
 pause

   end

end


clear indexq;
clear indexp;  

end
end
clc
answer =input(' Do you want to calculate the fault at another node ?[y/n] >','s');

end

%end program
%end
