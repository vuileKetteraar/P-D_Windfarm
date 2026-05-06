A = [phase1(1),phase2(1),phase3(1)];
P = [phase1(2),phase2(2),phase3(2)]*pi/180;

switch phase_type
   
%phase quantities-symmetrical
case 1
	amplitude = ones(1,3)*phase1(1);    
   phase     = [phase1(2),phase1(2)-120,phase1(2)+120]*pi/180;
%phase quantities-unsymmetrical   
case 2
	amplitude = A;
   phase     = P;
%symmetrical component
case 3
   a = exp(i*2*pi/3);   
   W = (A.*exp(i.*P)).';
   phase_ABC = [1 1 1;1 a a^2;1 a^2 a]*W;
   amplitude = abs(phase_ABC);
   phase     = angle(phase_ABC);
   
end  


xo  = 0;
yo  = 0;

Amax = max(abs(amplitude));
x1 = amplitude(1)*cos(phase(1));
y1 = amplitude(1)*sin(phase(1));
x2 = amplitude(2)*cos(phase(2));
y2 = amplitude(2)*sin(phase(2));
x3 = amplitude(3)*cos(phase(3));
y3 = amplitude(3)*sin(phase(3));


