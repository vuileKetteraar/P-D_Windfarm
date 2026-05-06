function [sys,x0,str,ts] = calcu(t,x,u,flag,trtype,vector,Vh,Vx,nCTH,nCTX)
switch flag,
  case 0
    [sys,x0,str,ts]=mdlInitializeSizes;
    
 case 3
    sys=mdlOutputs(u,trtype,vector,Vh,Vx,nCTH,nCTX);

   case { 1, 2, 4, 9 }
    sys=[];

    otherwise
    error(['Unhandled flag = ',num2str(flag)]);

end

function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 6;  % dynamically sized
sizes.NumInputs      = 6;  % dynamically sized
sizes.DirFeedthrough = 1;   % has direct feedthrough
sizes.NumSampleTimes = 1;

sys = simsizes(sizes);

str = [];
x0 = [];
ts = [-1 0];  % inherited sample time

function sys = mdlOutputs(u,trtype,vector,Vh,Vx,nCTH,nCTX)

n=Vh/Vx;
CHX = (1/n)*(nCTX/nCTH);
H = 1/nCTH;
X = 1/nCTX;
k(1) = H*u(1);
k(2) = H*u(2);
k(3) = H*u(3);
k(4) = -X*u(4);
k(5) = -X*u(5);
k(6) = -X*u(6);



switch trtype
   
case 1,      % wye - delta
   
   switch vector
      
   case 2, % vector group 1
      
       matrix =[  0.5774               0       -0.5774          CHX                 0                 0
                     -0.5774       0.5774                 0               0            CHX                 0
                               0     -0.5774         0.5774               0                 0            CHX
                       0.2887               0       -0.2887   -0.5*CHX                0                 0
                     -0.2887       0.2887                 0               0     -0.5 *CHX               0 
                               0     -0.2887         0.2887               0                 0    -0.5*CHX];        

     
      
    case 3, % vector group 3 
             
        matrix =[         0        0.5774       -0.5774           CHX                0                 0
                     -0.5774                0         0.5774               0            CHX                 0
                       0.5774      -0.5774                 0               0                 0            CHX 
                               0        0.2887       -0.2887   -0.5*CHX                0                 0
                     -0.2887                0         0.2887               0     -0.5*CHX                0 
                       0.2887      -0.2887                 0               0                 0   -0.5*CHX];        

                    
                    
   case 4, % vector group 5
 
        matrix =[ -0.5774       0.5774               0            CHX                0                 0
                                 0     -0.5774       0.5774                0            CHX                 0
                         0.5774               0     -0.5774                0                 0            CHX 
                       -0.2887       0.2887               0    -0.5*CHX                0                 0
                                 0     -0.2887       0.2887                0     -0.5*CHX                0 
                         0.2887               0     -0.2887                0                 0   -0.5*CHX];        


                      
  case 6, % vector group 7
                
        matrix =[ -0.5774               0         0.5774           CHX                0                 0
                         0.5774     -0.5774                 0               0            CHX                 0
                                 0       0.5774       -0.5774               0                 0            CHX 
                       -0.2887               0         0.2887   -0.5*CHX                0                 0
                         0.2887     -0.2887                 0               0     -0.5*CHX                0 
                                 0       0.2887       -0.2887               0                 0   -0.5*CHX];        

             
    case 7, % vector group 9
       
         matrix =[           0       -0.5774       0.5774           CHX                0                 0
                          0.5774                 0     -0.5774               0            CHX                 0
                        -0.5774         0.5774               0               0                 0            CHX 
                                  0       -0.2887       0.2887   -0.5*CHX                0                 0
                          0.2887                 0     -0.2887               0     -0.5*CHX                0 
                        -0.2887         0.2887               0               0                 0   -0.5*CHX];        

      
    case 8, % vector group 11
 
        matrix =[    0.5774      -0.5774                0            CHX                0                 0
                                  0        0.5774      -0.5774                0            CHX                 0
                        -0.5774                0        0.5774                0                 0            CHX 
                          0.2887      -0.2887                0    -0.5*CHX                0                 0
                                  0        0.2887      -0.2887                0     -0.5*CHX                0 
                        -0.2887                0        0.2887                0                 0   -0.5*CHX];        


    end;   %switch vector
      
    case 2,     % delta - wye  
           
   switch vector
      
   case 2, % vector group 1
           
        matrix =[      1      0       0      0.5774*CHX     -0.5774*CHX                        0
                           0       1       0                      0       0.5774*CHX      -0.5774*CHX
                           0       0       1    -0.5774*CHX                       0        0.5774*CHX 
                         0.5      0       0     -0.2887*CHX      0.2887*CHX                         0 
                           0    0.5       0                      0      -0.2887*CHX        0.2887*CHX
                           0       0    0.5       0.2887*CHX                       0      -0.2887*CHX];        

     
 
    case 3, % vector group 3 
              
        matrix =[      1      0       0                      0     -0.5774*CHX         0.5774*CHX 
                           0       1       0      0.5774*CHX                       0       -0.5774*CHX
                           0       0       1    -0.5774*CHX       0.5774*CHX                         0
                         0.5      0       0                      0        0.2887*CHX      -0.2887*CHX
                           0    0.5       0     -0.2887*CHX                       0        0.2887*CHX
                           0       0    0.5       0.2887*CHX     -0.2887*CHX                       0];        

      
   case 4, % vector group 5
    
         matrix =[      1      0       0      -0.5774*CHX                       0         0.5774*CHX 
                            0       1       0        0.5774*CHX     -0.5774*CHX                         0
                            0       0       1                        0       0.5774*CHX       -0.5774*CHX
                          0.5      0       0        0.2887*CHX                        0       -0.2887*CHX
                            0    0.5       0       -0.2887*CHX        0.2887*CHX                       0
                            0       0    0.5                         0      -0.2887*CHX       0.2887*CHX];        
 

    case 6, % vector group 7
      
         matrix =[      1      0       0      -0.5774*CHX      0.5774*CHX                         0
                            0       1       0                       0     -0.5774*CHX         0.5774*CHX
                            0       0       1       0.5774*CHX                       0        -0.5774*CHX 
                         0.5       0       0       0.2887*CHX      -0.2887*CHX                         0 
                            0    0.5       0                       0        0.2887*CHX        -0.2887*CHX
                            0       0    0.5     -0.2887*CHX                        0         0.2887*CHX];        
  
      
   case 7, % vector group 9
       
         matrix =[      1      0       0                        0       0.5774*CHX       -0.5774*CHX 
                            0       1       0      -0.5774*CHX                       0         0.5774*CHX
                            0       0       1        0.5774*CHX     -0.5774*CHX                         0
                         0.5       0       0                        0      -0.2887*CHX        0.2887*CHX
                            0    0.5       0        0.2887*CHX                       0       -0.2887*CHX
                            0       0    0.5      -0.2887*CHX       0.2887*CHX                        0];        

     

    case 8, % vector group 11
       
          matrix = [      1      0       0        0.5774*CHX                       0       -0.5774*CHX 
                              0       1       0      -0.5774*CHX       0.5774*CHX                         0
                              0       0       1                        0     -0.5774*CHX         0.5774*CHX
                           0.5       0       0      -0.2887*CHX                       0         0.2887*CHX
                              0    0.5       0        0.2887*CHX      -0.2887*CHX                        0
                              0       0    0.5                         0       0.2887*CHX     -0.2887*CHX];        

     
          
      end; %switch vector
           
case 3,     % wye - wye
           
   switch vector
      
   case 1, % vector group 0
      
           matrix = [    1        -1        0             CHX            -CHX                    0
                              0         1       -1                 0              CHX              -CHX
                            -1         0         1           -CHX                  0                CHX
                           0.5     -0.5        0      -0.5*CHX       0.5*CHX                    0
                              0       0.5   -0.5                  0      -0.5*CHX         0.5*CHX
                          -0.5         0     0.5        0.5*CHX                  0      -0.5*CHX];
      
   case 5, % vector group 6
                
            matrix = [    1       -1        0           -CHX              CHX                    0
                               0         1       -1                 0            -CHX                CHX
                             -1        0         1             CHX                  0              -CHX
                            0.5    -0.5        0       0.5*CHX      -0.5*CHX                    0
                              0       0.5   -0.5                  0        0.5*CHX       -0.5*CHX
                          -0.5         0     0.5      -0.5*CHX                  0         0.5*CHX];

  
      end; % switch vector
            
case 4,     % delta - delta
      
   switch vector 
         
    case 1, % vector group 0
  
             matrix = [    1        0        0             CHX                0                   0
                                0        1        0                 0            CHX                   0
                                0        0        1                 0                 0              CHX
                             0.5        0        0     -0.5*CHX                0                   0
                                0     0.5        0                 0     -0.5*CHX                  0
                                0        0     0.5                 0                 0      -0.5*CHX];

   
   
      
   case 5, % vector group 6
                 
             matrix = [    1        0        0           -CHX                0                   0
                                0        1        0                 0          -CHX                   0
                                0        0        1                 0                 0            -CHX
                             0.5        0        0      0.5*CHX                0                   0
                                0     0.5        0                 0      0.5*CHX                  0
                                0        0     0.5                 0                 0       0.5*CHX];

    
      
      end; % switch vector 
      
   end; % trtype
   
   
   sys = matrix*k';
   
   
   