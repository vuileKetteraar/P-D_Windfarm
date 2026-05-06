% ----------------------------------------------------
% This is the main script building the menu window
% for the set of programs related to 
%
%                     
%    MATLAB for Power Engineers Short Course
%                   
% (c) 1998 Bogdan Kasztenny & Mladen Kezunovic
%          Texas A&M University
%       College Station, 1999
%
% Contact information: bogdan.kasztenny@ieee.org
%                      kezunov@ee.tamu.edu
% ----------------------------------------------------

clear all;

%addpath([matlabroot '/m2k_0499']); 


figurePos=[10 60 725 450];
	figure('Name','MERIT 2000. Protective Relaying, Monitoring and Local Control', ...
		'Position',figurePos, ...
		'MenuBar','none', ...
      'NumberTitle','off');
   
   load map;
   load pic;
   colormap(map);
	set(gca,'Position',[0 0 1 1]);
	axis([-1 1 -1 1]);
	axis off;
	image(pic);
	clear pic map;
      	  
 
 h=uimenu('Label','UNBALANCED CONDITIONS ');
 		h1=uimenu(h,'Label','Unbalanced System Operation - Unbalanced Source',...
          'Callback','ee460_1a');
       h1=uimenu(h,'Label','Unbalanced System Operation - Fault',...
         'Callback','ee460_1b');
		h1=uimenu(h,'Label','Short-Circuit Analysis',...
          'Callback','ee460_2');
		h1=uimenu(h,'Label','Sequence networks');
      		h2=uimenu(h1,'Label','Transmission Lines');
            	uimenu(h2,'Label','Line (Twist)','Callback','linetw');
               uimenu(h2,'Label','Line (Transposition)','Callback','linetr');
               uimenu(h2,'Label','Line (Tap) 1','Callback','linetap1');
               uimenu(h2,'Label','Line (Tap) 2','Callback','linetap2');
               uimenu(h2,'Label','Line (Tap) 3','Callback','linetap3');
               uimenu(h2,'Label','Line (Tap) 4','Callback','linetap4');
               uimenu(h2,'Label','Line (Parallel) 1','Callback','paralines_1');
               uimenu(h2,'Label','Line (Parallel) 2','Callback','paralines_2');
               uimenu(h2,'Label','Line (Parallel) 3','Callback','paralines_3');
            h2=uimenu(h1,'Label','Loads');
            	uimenu(h2,'Label','Load1','Callback','load1');
               uimenu(h2,'Label','Load2','Callback','load2');
               uimenu(h2,'Label','Load3','Callback','load3');
               uimenu(h2,'Label','Load4','Callback','load4');
               uimenu(h2,'Label','Load5','Callback','load5');
               uimenu(h2,'Label','Load6','Callback','load6');
               uimenu(h2,'Label','Load7','Callback','load7');
               uimenu(h2,'Label','Load8','Callback','load8');
               h2=uimenu(h1,'Label','Generators');
               	uimenu(h2,'Label','Zero','Callback','zero');
                  uimenu(h2,'Label','Positive','Callback','positive');
                  uimenu(h2,'Label','Negative','Callback','negative');
            h2=uimenu(h1,'Label','Transformers');
	            uimenu(h2,'Label','Transformer1','Callback','trans1');
               uimenu(h2,'Label','Transformer2','Callback','trans2');
               uimenu(h2,'Label','Transformer3','Callback','trans3');

            h2=uimenu(h1,'Label','Motors');
            	uimenu(h2,'Label','Motor1','Callback','indmot1');
	            uimenu(h2,'Label','Motor2','Callback','indmot2');
   	         uimenu(h2,'Label','Motor3','Callback','indmot3');
      	      uimenu(h2,'Label','Motor4','Callback','indmot4');

            
    		h1=uimenu(h,'Label','Short-Circuit Program using Matrix Methods', ...
             'Callback','ex460_2');
          h1=uimenu(h,'Label','Impedance approach to short circuit studies',...
             'Callback','impedance');
          h1=uimenu(h,'Label','Admittance approach to short circuit studies',...
             'Callback','admittance');
          
h=uimenu('Label','RELAYING PRINCIPLES ');
 		h1=uimenu(h,'Label','Overcurrent Principle',...
         'Callback','ee460_3');
		h1=uimenu(h,'Label','Impedance Principle',...
          'Callback','ee460_4');
		h1=uimenu(h,'Label','Differential Principle',...
         'Callback','ee460_5');
		       
h=uimenu('Label','DESIGN PRINCIPLES ');
    h1=uimenu(h,'Label','Analog Filtering and Sampling');
   	 uimenu(h1,'Label','1a. Operation of sampling and the aliasing frequencies', ...
		'Callback','step1a');
   	 uimenu(h1,'Label','1b. Analog filtering', ...
	    'Callback','step1b');
   	 uimenu(h1,'Label','1c. Horizontal resolution of an A/D converter', ...
		 'Callback','step1c');
   	 uimenu(h1,'Label','1d. Vertical resolution of an A/D converter', ...
		 'Callback','step1d');
   	 uimenu(h1,'Label','1e. Testing the front-end using analytical signals', ...
		 'Callback','step1e');
   	 uimenu(h1,'Label','1f. Testing the front-end using EMTP generated signals', ...
       'Callback','step1f'); 
	    uimenu(h1,'Label','Help file for this topic', ...
   	 'Callback',['!winhelp ' matlabroot '/m2k_0499/Af.hlp'],'Separator','On');


    h1=uimenu(h,'Label','Phasor Measurement');
 		 uimenu(h1,'Label','2a. An ultimate 2-sample algorithm', ...
		'Callback','step2a');
   	uimenu(h1,'Label','2b. Fourier algorithm', ...
	   'Callback','step2b');
	   uimenu(h1,'Label','2c. Frequency response of the Fourier algorithm', ...
	 	'Callback','step2c');
    	uimenu(h1,'Label','2d. Frequency response of the 2-sample algorithm', ...
	 	'Callback','step2d');
    	uimenu(h1,'Label','2e. Fourier algorithm and higher frequencies', ...
	 	'Callback','step2e');
    	uimenu(h1,'Label','2f. Fourier algorithm and the d.c. offset', ...
      'Callback','step2f');
    	uimenu(h1,'Label','2g. Testing the Fourier algorithm using EMTP generated signals', ...
      'Callback','step2g');
    	uimenu(h1,'Label','Help file for this topic', ...
      'Callback',['!winhelp ' matlabroot '/m2k_0499/Pm.hlp'],'Separator','On');
       
   h1=uimenu(h,'Label','Overcurrent Relay');
    	uimenu(h1,'Label','3a. Basic scheme and instantaneous overcurrent tripping', ...
		'Callback','step3a');
    	uimenu(h1,'Label','3b. Definite-time overcurrent element', ...
    	'Callback','step3b');
    	uimenu(h1,'Label','3c. Time-dependent overcurrent element', ...
	 	'Callback','step3c');
    	uimenu(h1,'Label','3d. Time-dependent element under the changing current amplitude', ...
	 	'Callback','step3d');
    	uimenu(h1,'Label','3e. Closed-loop testing with simple power system model', ...
      'Callback','step3e');
    	uimenu(h1,'Label','3f. Open-loop testing using EMTP generated signals', ...
      'Callback','step3f');
    	uimenu(h1,'Label','Help file for this topic', ...
    	'Callback',['!winhelp ' matlabroot '/m2k_0499/Or.hlp'],'Separator','On');

 
 h=uimenu('Label','RELAY ELEMENTS ');
    h1=uimenu(h,'Label','Relay Elements');
       uimenu(h1,'Label','Library','Callback','elements');
       uimenu(h1,'Label','DAB Example ','Callback','dabex');
       uimenu(h1,'Label','UC Example  1','Callback','ucex1');
       uimenu(h1,'Label','UC Example 2','Callback','ucex2');
       uimenu(h1,'Label','OC Example','Callback','ocex');
       uimenu(h1,'Label','DE_1 Example','Callback','DE_1ex');           
    uimenu(h,'Label','Auxiliary Elements', ...
       'Callback','aux_rel');
    
 h=uimenu('Label','PROTECTION SYSTEMS ');
 	h1=uimenu(h,'Label','Line Protection');
    uimenu(h1,'Label','Overcurrent','Callback','systemtotal');
    h2=uimenu(h1,'Label','Differential');
       uimenu(h2,'Label','Test system','Callback','testsystem2');
       uimenu(h2,'Label','Relay','Callback','difflinrelay');
    h2=uimenu(h1,'Label','Distance');
       uimenu(h2,'Label','Test system','Callback','linefault');
       uimenu(h2,'Label','Relay system','Callback','systemoffline');
   h1=uimenu(h,'Label','Transformer Protection');
      uimenu(h1,'Label','Test system','Callback','transystem2');
      uimenu(h1,'Label','Relay','Callback','diffrelay');
   h1=uimenu(h,'Label','Busbar Protection');
      uimenu(h1,'Label','Test system','Callback','bustestsysa');
      uimenu(h1,'Label','Relay','Callback','busrelay');
h=uimenu('Label','COMM. SCHEMES ');
    uimenu(h,'Label','PUTT logic', ...
    'Callback','putt');
    uimenu(h,'Label','PUTT+OZ logic', ...
       'Callback','puttoz');
    uimenu(h,'Label','BLOV+TB logic', ...
       'Callback','blovtb');
    uimenu(h,'Label','BLOV+UZ+TB logic', ...
       'Callback','blovuztb');
    uimenu(h,'Label','BLUN logic', ...
       'Callback','blun');
    uimenu(h,'Label','POTT+WEI+TB logic', ...
       'Callback','pottweitb');
  
 h=uimenu('Label','TOOLS ');
 	uimenu(h,'Label','Simulink', ...
   'Callback','simulink');
   h1=uimenu(h,'Label','Displays','Callback','displays');
	uimenu(h,'Label','Controls', ...
      'Callback','controls');
       h1=uimenu(h,'Label','Signal Generators');
       uimenu(h1,'Label','Library','Callback','generators');
       uimenu(h1,'Label','AG Example ','Callback','agex');
       uimenu(h1,'Label','SG Example  1','Callback','sgex');
       uimenu(h1,'Label','PG Example 2','Callback','pgex');
       uimenu(h1,'Label','TPG Example','Callback','tpgex');
       uimenu(h1,'Label','FSG Example','Callback','fsgex');     

      h1=uimenu(h,'Label','File Converters');
      	uimenu(h1,'Label','Convert ATP to MATLAB', ...
         'Callback','emtp2mat');
        	h1=uimenu(h,'Label','Power System Model',...
   		'Callback','powerlib');
        	

  h=uimenu('Label','HELP  ');
 uimenu(h,'Label','Help file', ...
    'Callback',['!winhelp ' matlabroot '/m2k_0499/m2k.hlp']);
  h=uimenu('Label','QUIT');
       uimenu(h,'Label','Quit the program', ...
	    'Callback','go_out');

