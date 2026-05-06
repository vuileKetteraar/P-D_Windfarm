%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% lineTw.m
%% MatLAB program - Symmetrical networks for three phase transmission line
%% One Rotated, one twisted line
%% 10/1998 - Texas A&M University, Dept. of Electrical Engineenring 
%% Piotr Pierz, ID ELEN 000-03-1265
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
a=exp(i*2*pi/3);
A=[1 1 1; 1 a^2 a; 1 a a^2];
AA=A^(-1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Read data from input text file 'data.txt' (structure of file below):
%%
%% Raa Xaa       - self imedances in Ohm per mile
%% Rbb Xbb
%% Rcc Xcc
%% Rab Xab       - mutual imedances in Ohm per mile
%% Rbc Xbc
%% Rac Xac
%% s1 s2 s3      - length of line sections in miles
%% EA angleEA    - magnitude [V] and angle [deg] of symmetrical voltage source A
%% EBa angleEBa  - magnitude [V] and angle [deg] of unsymmetrical voltage source B - phase a
%% EBb angleEBb  - magnitude [V] and angle [deg] of unsymmetrical voltage source B - phase b
%% EBc angleEBc  - magnitude [V] and angle [deg] of unsymmetrical voltage source B - phase c

FileName = 'data.txt';
fIn = fopen(FileName,'r');
 x=fscanf(fIn,'%f',2); Zabc(1,1)=x(1) + x(2)*i;
 x=fscanf(fIn,'%f',2); Zabc(2,2)=x(1) + x(2)*i;
 x=fscanf(fIn,'%f',2); Zabc(3,3)=x(1) + x(2)*i;
 x=fscanf(fIn,'%f',2); Zabc(1,2)=x(1) + x(2)*i; Zabc(2,1)=Zabc(1,2);
 x=fscanf(fIn,'%f',2); Zabc(2,3)=x(1) + x(2)*i; Zabc(3,2)=Zabc(2,3);
 x=fscanf(fIn,'%f',2); Zabc(1,3)=x(1) + x(2)*i; Zabc(3,1)=Zabc(1,3);
 x=fscanf(fIn,'%f',3); s1=x(1); s2=x(2); s3=x(3);
 
 x=fscanf(fIn,'%f',2); Va=x(1); angA=x(2);
 x=fscanf(fIn,'%f',2); Vba=x(1); angBa=x(2);
 x=fscanf(fIn,'%f',2); Vbb=x(1); angBb=x(2);
 x=fscanf(fIn,'%f',2); Vbc=x(1); angBc=x(2);
fclose(fIn);


%% Voltage Sources:
Ea=[Va*exp(j*(angA*pi/180)); Va*exp(j*(-2*pi/3+angA*pi/180)); Va*exp(j*(2*pi/3+angA*pi/180))];
Eb=[Vba*exp(j*angBa*pi/180); Vbb*exp(j*angBb*pi/180); Vbc*exp(j*angBc*pi/180)];


%% phase source A voltages and angles:
EA_A=abs(Ea(1)); EA_PA=angle(Ea(1))*180/pi; 
EA_B=abs(Ea(2)); EA_PB=angle(Ea(2))*180/pi; 
EA_C=abs(Ea(3)); EA_PC=angle(Ea(3))*180/pi;

%% phase source B voltages and angles:
EB_A=abs(Eb(1)); EB_PA=angle(Eb(1))*180/pi; 
EB_B=abs(Eb(2)); EB_PB=angle(Eb(2))*180/pi; 
EB_C=abs(Eb(3)); EB_PC=angle(Eb(3))*180/pi;


%% Voltage Sources A and B in symmetrical components domain:
Ea012=AA*Ea;
Eb012=AA*Eb;


% Source A
E0A=abs(Ea012(1)); E0AP=angle(Ea012(1))*180/pi; 
E1A=abs(Ea012(2)); E1AP=angle(Ea012(2))*180/pi; 
E2A=abs(Ea012(3)); E2AP=angle(Ea012(3))*180/pi;

%Source B
E0B=abs(Eb012(1)); E0BP=angle(Eb012(1))*180/pi; 
E1B=abs(Eb012(2)); E1BP=angle(Eb012(2))*180/pi; 
E2B=abs(Eb012(3)); E2BP=angle(Eb012(3))*180/pi;


%corrections of section lengths(greater than 0.0)
if s1==0; s1=0.0001; end;
if s2==0; s2=0.0001; end;
if s3==0; s3=0.0001; end;
if s1==s2 & s2==s3  s1=s1+0.0001; end;


%Section #1 - line ABC.
r1 = s1*real(Zabc); 
x1 = s1*imag(Zabc)/(2*pi*60); 
R1_11=r1(1,1); R1_22=r1(2,2); R1_33=r1(3,3); 
X1_11=x1(1,1); X1_22=x1(2,2); X1_33=x1(3,3); 
R1_12=r1(1,2); R1_13=r1(1,3); R1_23=r1(2,3);
X1_12=x1(1,2); X1_13=x1(1,3); X1_23=x1(2,3); 

%Section #2 - line ABC.
r2 = s2*real(Zabc); 
x2 = s2*imag(Zabc)/(2*pi*60); 
R2_11=r2(1,1); R2_22=r2(2,2); R2_33=r2(3,3); 
X2_11=x2(1,1); X2_22=x2(2,2); X2_33=x2(3,3); 
R2_12=r2(1,2); R2_13=r2(1,3); R2_23=r2(2,3);
X2_12=x2(1,2); X2_13=x2(1,3); X2_23=x2(2,3); 

%Section #3 - line ABC.
r3 = s3*real(Zabc); 
x3 = s3*imag(Zabc)/(2*pi*60); 
R3_11=r3(1,1); R3_22=r3(2,2); R3_33=r3(3,3); 
X3_11=x3(1,1); X3_22=x3(2,2); X3_33=x3(3,3); 
R3_12=r3(1,2); R3_13=r3(1,3); R3_23=r3(2,3);
X3_12=x3(1,2); X3_13=x3(1,3); X3_23=x3(2,3); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Parameters of symmetrical components model (012)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R=[0 1 0; 0 0 1; 1 0 0]; %Transposition Matrix
T23=[1 0 0; 0 0 1; 0 1 0]; %Twist Matrix

%Section #1 - line ABC.
Z1abc=Zabc*s1;

%Section #2 - line ABC.
Z2abc=Zabc*s2;  Z2abc=R*Z2abc*R^(-1);	
 
%Section #3 - line ABC.
Z3abc=Zabc*s3;  Z3abc=T23*Z3abc*T23';    

%Total impedance of line
Ztot=Z1abc+Z2abc+Z3abc;

Z1_012=AA*Z1abc*A;   
Z2_012=AA*Z2abc*A;   
Z3_012=AA*Z3abc*A;   

Z012=Z1_012 + Z2_012 + Z3_012;
z012=AA*Zabc*A;   

R012=real(Z012);
X012=imag(Z012);
X012=X012/(2*pi*60);

R0=R012(1,1); R1=R012(2,2); R2=R012(2,2);
X0=X012(1,1); X1=X012(2,2); X2=X012(2,2);

R01=R012(1,2); R12=R012(2,3); R02=R012(1,3);
X01=X012(1,2); X12=X012(2,3); X02=X012(1,3);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% generate output text file 'outputz.txt' with:
%% EAabc, EBabc, EA012, EB012, Z1abc, Z2abc, Z3abc, Z012

FileName = 'outputTwist.txt';
fOut = fopen(FileName,'w');
 fprintf(fOut,'OUTPUT <TWIST> FILE\n\n');
 fprintf(fOut,'------------------------------------------------\n');
 fprintf(fOut,'*** VOLTAGE SOURCES ***\n');
 fprintf(fOut,'------------------------------------------------\n');
 
 fprintf(fOut,'Source A:       [V]        [deg]\n');
 fprintf(fOut,'  phase a     %7.1f    %7.2f\n',EA_A,EA_PA);
 fprintf(fOut,'  phase b     %7.1f    %7.2f\n',EA_B,EA_PB);
 fprintf(fOut,'  phase c     %7.1f    %7.2f\n',EA_C,EA_PC);
 
 fprintf(fOut,'\n------------------------------------------------\n');
 fprintf(fOut,'Source B:       [V]        [deg]\n');
 fprintf(fOut,'  phase a     %7.1f    %7.2f\n',EB_A,EB_PA);
 fprintf(fOut,'  phase b     %7.1f    %7.2f\n',EB_B,EB_PB);
 fprintf(fOut,'  phase c     %7.1f    %7.2f\n',EB_C,EB_PC);
 
 fprintf(fOut,'\n------------------------------------------------\n');
 fprintf(fOut,'Source A 012:   [V]        [deg]\n');
 fprintf(fOut,'   seq. 0     %7.1f    %7.2f\n',E0A,E0AP);
 fprintf(fOut,'   seq. 1     %7.1f    %7.2f\n',E1A,E1AP);
 fprintf(fOut,'   seq. 2     %7.1f    %7.2f\n',E2A,E2AP);
 
 fprintf(fOut,'\n------------------------------------------------\n');
 fprintf(fOut,'Source B 012:   [V]        [deg]\n');
 fprintf(fOut,'   seq. 0     %7.1f    %7.2f\n',E0B,E0BP);
 fprintf(fOut,'   seq. 1     %7.1f    %7.2f\n',E1B,E1BP);
 fprintf(fOut,'   seq. 2     %7.1f    %7.2f\n\n\n',E2B,E2BP);
 
 fprintf(fOut,'---------------------------------------------------------------\n');
 fprintf(fOut,'*** IMPEDANCES ***\n');
 fprintf(fOut,'---------------------------------------------------------------\n');
 fprintf(fOut,'Section 1 (ABC) [Ohm H]:\n');
 fprintf(fOut,'        %7.4f+%7.4fj   %7.4f+%7.4fj   %7.4f+%7.4fj\n',R1_11, X1_11, R1_12, X1_12, R1_13, X1_13);
 fprintf(fOut,'Z1abc = %7.4f+%7.4fj   %7.4f+%7.4fj   %7.4f+%7.4fj\n',R1_12, X1_12, R1_22, X1_22, R1_23, X1_23);
 fprintf(fOut,'        %7.4f+%7.4fj   %7.4f+%7.4fj   %7.4f+%7.4fj\n',R1_13, X1_13, R1_23, X1_23, R1_33, X1_33);
 
 fprintf(fOut,'\n---------------------------------------------------------------\n');
 fprintf(fOut,'Section 2 (ABC) [Ohm H]:\n');
 fprintf(fOut,'        %7.4f+%7.4fj   %7.4f+%7.4fj   %7.4f+%7.4fj\n',R2_11, X2_11, R2_12, X2_12, R2_13, X2_13);
 fprintf(fOut,'Z2abc = %7.4f+%7.4fj   %7.4f+%7.4fj   %7.4f+%7.4fj\n',R2_12, X2_12, R2_22, X2_22, R2_23, X2_23);
 fprintf(fOut,'        %7.4f+%7.4fj   %7.4f+%7.4fj   %7.4f+%7.4fj\n',R2_13, X2_13, R2_23, X2_23, R2_33, X2_33);
 
 fprintf(fOut,'\n---------------------------------------------------------------\n');
 fprintf(fOut,'Section 3 (ABC) [Ohm H]:\n');
 fprintf(fOut,'        %7.4f+%7.4fj   %7.4f+%7.4fj   %7.4f+%7.4fj\n',R3_11, X3_11, R3_12, X3_12, R3_13, X3_13);
 fprintf(fOut,'Z3abc = %7.4f+%7.4fj   %7.4f+%7.4fj   %7.4f+%7.4fj\n',R3_12, X3_12, R3_22, X3_22, R3_23, X3_23);
 fprintf(fOut,'        %7.4f+%7.4fj   %7.4f+%7.4fj   %7.4f+%7.4fj\n',R3_13, X3_13, R3_23, X3_23, R3_33, X3_33);

 fprintf(fOut,'\n\n---------------------------------------------------------------\n');
 fprintf(fOut,'Total impedance of line (ABC) [Ohm Ohm]:\n');
 fprintf(fOut,'        %7.4f+%7.4fj   %7.4f+%7.4fj   %7.4f+%7.4fj\n',real(Ztot(1,1)),imag(Ztot(1,1)), real(Ztot(1,2)), imag(Ztot(1,2)), real(Ztot(1,3)), imag(Ztot(1,3)));
 fprintf(fOut,'Ztot =  %7.4f+%7.4fj   %7.4f+%7.4fj   %7.4f+%7.4fj\n',real(Ztot(2,1)),imag(Ztot(2,1)), real(Ztot(2,2)), imag(Ztot(2,2)), real(Ztot(2,3)), imag(Ztot(2,3)));
 fprintf(fOut,'        %7.4f+%7.4fj   %7.4f+%7.4fj   %7.4f+%7.4fj\n',real(Ztot(3,1)),imag(Ztot(3,1)), real(Ztot(3,2)), imag(Ztot(3,2)), real(Ztot(3,3)), imag(Ztot(3,3)));

 fprintf(fOut,'\n\n---------------------------------------------------------------\n');
 fprintf(fOut,'Sequence impedances of line (012) [Ohm Ohm]:\n');
 fprintf(fOut,'        %7.4f+%7.4fj   %7.4f+%7.4fj   %7.4f+%7.4fj\n',R0, X0, R01, X01, R02, X02);
 fprintf(fOut,'Z012  = %7.4f+%7.4fj   %7.4f+%7.4fj   %7.4f+%7.4fj\n',R01, X01, R1, X1, R12, X12);
 fprintf(fOut,'        %7.4f+%7.4fj   %7.4f+%7.4fj   %7.4f+%7.4fj\n',R02, X02, R12, X12, R2, X2);

 fprintf(fOut,'\n\n\nend of file\n');
fclose(fOut);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lineTwist;  %go to PowerLib model and start simulation


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% end
