% ----------------------------------------------------
% This is the main script building the menu window
% for the set of programs related to 
%
%                     
%    MATLAB for Power Engineers Short Course
%                   
% (c) 2016 Mladen Kezunovic, Jinfeng Ren & Saeed Lotfifard
%
% ----------------------------------------------------

clear all;
warning off;
curDir = pwd;
addpath(curDir);
% figurePos=[10 60 925 450];
scrsz = get(groot,'ScreenSize');
figurePos = [scrsz(3)/4 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2];
figure('Name','MERIT 2016. Design, Modeling and Evaluation of Protective Relays for Power Systems', ...
		'Position',figurePos, ...
		'MenuBar','none', ...
      'NumberTitle','off');

pic = imread('MERIT2016_COVER.jpg');
set(gca,'Position',[0 0 1 1]);
axis([-1 1 -1 1]);
axis off;
image(pic);
clear pic;
      	  
h=uimenu('Label','FAULT ANALYSIS');
    h1=uimenu(h,'Label','Unbalanced System Operation - Unbalanced Source (SCo1.mdl)',...
      'Callback','SCo1');
    h1=uimenu(h,'Label','Unbalanced System Operation - Fault (SCo2.mdl)',...
     'Callback','SCo2');
    h1=uimenu(h,'Label','Short-Circuit Analysis (SCo3.mdl)',...
      'Callback','SCo3');
    h1=uimenu(h,'Label','Sequence networks');
        h2=uimenu(h1,'Label','Transmission Lines');
           uimenu(h2,'Label','Line - Twist (lineTwist.mdl)','Callback','lineTwist');
           uimenu(h2,'Label','Line - Transposition (lineTran.mdl)','Callback','lineTran');
           uimenu(h2,'Label','Line - Tap 1 (linetap1.mdl)','Callback','linetap1');
           uimenu(h2,'Label','Line - Tap 2 (linetap2.mdl)','Callback','linetap2');
           uimenu(h2,'Label','Line - Tap 3 (linetap3.mdl)','Callback','linetap3');
           uimenu(h2,'Label','Line - Tap 4 (linetap4.mdl)','Callback','linetap4');
           uimenu(h2,'Label','Line - Parallel 1 (paralines_1.mdl)','Callback','paralines_1');
           uimenu(h2,'Label','Line - Parallel 2 (paralines_2.mdl)','Callback','paralines_2');
           uimenu(h2,'Label','Line - Parallel 3 (paralines_3.mdl)','Callback','paralines_3');
        h2=uimenu(h1,'Label','Loads');
           uimenu(h2,'Label','Load 1 (load1.mdl)','Callback','load1');
           uimenu(h2,'Label','Load 2 (load2.mdl)','Callback','load2');
           uimenu(h2,'Label','Load 3 (load3.mdl)','Callback','load3');
           uimenu(h2,'Label','Load 4 (load4.mdl)','Callback','load4');
           uimenu(h2,'Label','Load 5 (load5.mdl)','Callback','load5');
           uimenu(h2,'Label','Load 6 (load6.mdl)','Callback','load6');
           uimenu(h2,'Label','Load 7 (load7.mdl)','Callback','load7');
           uimenu(h2,'Label','Load 8 (load8.mdl)','Callback','load8');
        h2=uimenu(h1,'Label','Generators');
           uimenu(h2,'Label','Zero (zero.mdl)','Callback','zero');
           uimenu(h2,'Label','Positive (positive.mdl)','Callback','positive');
           uimenu(h2,'Label','Negative (negative.mdl)','Callback','negative');
        h2=uimenu(h1,'Label','Transformers');
           uimenu(h2,'Label','Transformer 1 (trans1.mdl)','Callback','trans1');
           uimenu(h2,'Label','Transformer 2 (trans2.mdl)','Callback','trans2');
           uimenu(h2,'Label','Transformer 3 (trans3.mdl)','Callback','trans3');
        h2=uimenu(h1,'Label','Motors');
           uimenu(h2,'Label','Motor 1 (indmot1.mdl)','Callback','indmot1');
           uimenu(h2,'Label','Motor 2 (indmot2.mdl)','Callback','indmot2');
           uimenu(h2,'Label','Motor 3 (indmot3.mdl)','Callback','indmot3');
           uimenu(h2,'Label','Motor 4 (indmot4.mdl)','Callback','indmot4');

    h1=uimenu(h,'Label','Short-Circuit Program Using Matrix Methods (SCo3.mdl)', ...
        'Callback','SCo3');
         
    h1=uimenu(h,'Label','Impedance Approach To Short Circuit Studies (impedance.mdl)',...
        'Callback','impedance');
    
    h1=uimenu(h,'Label','Admittance Approach To Short Circuit Studies (admittance.mdl)',...
        'Callback','admittance');
          
h=uimenu('Label','RELAYING PRINCIPLES');
 	h1=uimenu(h,'Label','Overcurrent Principle (OCRe.mdl)',...
        'Callback','OCRe');
    
	h1=uimenu(h,'Label','Impedance Principle (ImRe.mdl)',...
        'Callback','ImRe');
    
	h1=uimenu(h,'Label','Differential Principle (DiRe.mdl)',...
        'Callback','DiRe');
		       
h=uimenu('Label','DESIGN PRINCIPLES');
    h1=uimenu(h,'Label','Analog Filtering And Sampling');
        h2=uimenu(h1,'Label','1a. Sampling & Aliasing Frequencies (step1a.mdl)', ...
            'Callback','step1a');
        h2=uimenu(h1,'Label','1b. Analog Filtering (step1b.mdl)', ...
            'Callback','step1b');
        h2=uimenu(h1,'Label','1c. A/D Converter - Horizontal Resolution (step1c.mdl)', ...
            'Callback','step1c');
        h2=uimenu(h1,'Label','1d. A/D Converter - Vertical resolution (step1d.mdl)', ...
            'Callback','step1d');
        h2=uimenu(h1,'Label','1e. Testing Front-End Using Analytical Signals (step1e.mdl)', ...
            'Callback','step1e');
        h2=uimenu(h1,'Label','1f. Testing Front-End Using EMTP Generated Signals (step1f.mdl)', ...
            'Callback','step1f'); 

    h1=uimenu(h,'Label','Phasor Measurement');
 		h2=uimenu(h1,'Label','2a. An Two-Sample Algorithm (step2a.mdl)', ...
            'Callback','step2a');
        h2=uimenu(h1,'Label','2b. Fourier Algorithm (step2b.mdl)', ...
            'Callback','step2b');
        h2=uimenu(h1,'Label','2c. Fourier Algorithm - Frequency Response (step2c.mdl)', ...
            'Callback','step2c');
    	h2=uimenu(h1,'Label','2d. Two-Sample Algorithm - Frequency Response (step2d.mdl)', ...
            'Callback','step2d');
    	h2=uimenu(h1,'Label','2e. Fourier Algorithm & Higher Frequencies (step2e.mdl)', ...
            'Callback','step2e');
    	h2=uimenu(h1,'Label','2f. Fourier Algorithm & DC Offset (step2f.mdl)', ...
            'Callback','step2f');
    	h2=uimenu(h1,'Label','2g. Testing Fourier Algorithm Using EMTP Generated Signals (step2g.mdl)', ...
            'Callback','step2g');
       
    h1=uimenu(h,'Label','Overcurrent Relay');
    	h2=uimenu(h1,'Label','3a. Basic Scheme & Instantaneous Overcurrent Element (step3a.mdl)', ...
            'Callback','step3a');
    	h2=uimenu(h1,'Label','3b. Definite-Time Overcurrent Element (step3b.mdl)', ...
            'Callback','step3b');
    	h2=uimenu(h1,'Label','3c. Time-Dependent Overcurrent Element (step3c.mdl)', ...
            'Callback','step3c');
    	h2=uimenu(h1,'Label','3d. Time-Dependent Element Under Changing Current Amplitude (step3d.mdl)', ...
            'Callback','step3d');
    	h2=uimenu(h1,'Label','3e. Closed-Loop Testing Using Simple Power System Model (step3e.mdl)', ...
            'Callback','step3e');
    	h2=uimenu(h1,'Label','3f. Open-Loop Testing Using EMTP Generated Signals (step3f.mdl)', ...
            'Callback','step3f');
 
 h=uimenu('Label','RELAY ELEMENTS');
    h1=uimenu(h,'Label','Relay Elements');
        h2=uimenu(h1,'Label','Library (Relay_Elements.mdl)','Callback','Relay_Elements');
        h2=uimenu(h1,'Label','BC Example (BCex.mdl)','Callback','BCex');
        h2=uimenu(h1,'Label','BM Example (bmex.mdl)','Callback','bmex');
        h2=uimenu(h1,'Label','DAB Example (dabex.mdl)','Callback','dabex');
  
        h2=uimenu(h1,'Label','DE_1 Example (DE_1ex.mdl)','Callback','DE_1ex');
        h2=uimenu(h1,'Label','DEIM Example (deimex.mdl)','Callback','deimex');
        h2=uimenu(h1,'Label','DF Example (dfex.mdl)','Callback','dfex');
        h2=uimenu(h1,'Label','DFT Example (dfttex.mdl)','Callback','dfttex');
        h2=uimenu(h1,'Label','OC Example (ocex.mdl)','Callback','ocex');
        h2=uimenu(h1,'Label','SC Example (scex.mdl)','Callback','scex');
        h2=uimenu(h1,'Label','TR Example (trex.mdl)','Callback','trex');
        h2=uimenu(h1,'Label','UC Example 1 (ucex1.mdl)','Callback','ucex1');
        h2=uimenu(h1,'Label','UC Example 2 (ucex2.mdl)','Callback','ucex2');
        h2=uimenu(h1,'Label','PS Example (psex.mdl)','Callback','psex');
        h2=uimenu(h1,'Label','VG2 Example (vg2ex.mdl)','Callback','vg2ex');
        h2=uimenu(h1,'Label','ZC Example (zcex.mdl)','Callback','zcex');
        h2=uimenu(h1,'Label','PD Example (pdex.mdl)','Callback','pdex');
        
     h1=uimenu(h,'Label','Auxiliary Elements (aux_rel.mdl)','Callback','aux_rel');
    
 h=uimenu('Label','PROTECTION SYSTEMS ');
 	h1=uimenu(h,'Label','Line Protection');
        h2=uimenu(h1,'Label','Overcurrent');
           uimenu(h2,'Label','Relay System (systemtotal.mdl)','Callback','systemtotal');
           uimenu(h2,'Label','Test System (OORT.mdl)','Callback','OORT');
        h2=uimenu(h1,'Label','Differential');
           uimenu(h2,'Label','Relay System (difflinrelay.mdl)','Callback','difflinrelay');
           uimenu(h2,'Label','Test System (testsystem2.mdl)','Callback','testsystem2');
        h2=uimenu(h1,'Label','Distance');
           uimenu(h2,'Label','Relay System (linefault.mdl)','Callback','linefault');
           uimenu(h2,'Label','Test System (OIRT.mdl)','Callback','OIRT');
        h2=uimenu(h1,'Label','Zone Protection');
           uimenu(h2,'Label','Relay System (lineprotsys.mdl)','Callback','lineprotsys');
           uimenu(h2,'Label','Test System - Internal Fault (internalfault.mdl)','Callback','internalfault');
           uimenu(h2,'Label','Test System - External Fault (backwardfault.mdl)','Callback','backwardfault');
        h2=uimenu(h1,'Label','Pilot Protection');
           uimenu(h2,'Label','Relay System (distrelay.mdl)','Callback','distrelay');
           uimenu(h2,'Label','Phasor Test (phasortest.mdl)','Callback','phasortest');
           uimenu(h2,'Label','Phasor Test with Files (phasortest2.mdl)','Callback','phasortest2');
           uimenu(h2,'Label','Transiet Test (fullsystem.mdl)','Callback','fullsystem');
           uimenu(h2,'Label','Offline Test (systemOffLine.mdl)','Callback','systemOffLine');
                    
   h1=uimenu(h,'Label','Transformer Protection');
        h2=uimenu(h1,'Label','Relay System (diffrelay.mdl)','Callback','diffrelay');     
        h2=uimenu(h1,'Label','Test System (transystem2.mdl)','Callback','transystem2');  
        h2=uimenu(h1,'Label','Differential Test (difreltest.mdl)','Callback','difreltest');
        h2=uimenu(h1,'Label','Restricted Earth Test (earthtest.mdl)','Callback','earthtest');
        h2=uimenu(h1,'Label','Overcurrent Test (overcurrentest.mdl)','Callback','overcurrentest');
        h2=uimenu(h1,'Label','Impedance Test (impedtest.mdl)','Callback','impedtest');
   h1=uimenu(h,'Label','Busbar Protection'); 
        h2=uimenu(h1,'Label','Relay System (busrelay.mdl)','Callback','busrelay');
        h2=uimenu(h1,'Label','Test System (bustestsysa.mdl)','Callback','bustestsysa');

 h=uimenu('Label','COMM. SCHEMES ');
   h1=uimenu(h,'Label','PUTT Logic (putt.mdl)', ...
        'Callback','putt');
   h1=uimenu(h,'Label','PUTT+OZ Logic (puttoz.mdl)', ...
        'Callback','puttoz');
   h1=uimenu(h,'Label','BLOV+TB Logic (blovtb.mdl)', ...
        'Callback','blovtb');
   h1=uimenu(h,'Label','BLOV+UZ+TB Logic (blovuztb.mdl)', ...
        'Callback','blovuztb');
   h1=uimenu(h,'Label','BLUN Logic (blun.mdl)', ...
        'Callback','blun');
   h1=uimenu(h,'Label','POTT+WEI+TB Logic (pottweitb.mdl)', ...
        'Callback','pottweitb');
  
h=uimenu('Label','TOOLS');
   h1=uimenu(h,'Label','Simulink', ...
        'Callback','simulink');
   h1=uimenu(h,'Label','Transmission Network Modules (systemm.mdl)','Callback','systemm');
   h1=uimenu(h,'Label','Transformer Modules (xfmrm.mdl)','Callback','xfmrm');
   h1=uimenu(h,'Label','Displays (displays.mdl)','Callback','displays');
   h1=uimenu(h,'Label','Controls (controls.mdl)', ...
        'Callback','controls');
   h1=uimenu(h,'Label','Signal Generators');
        h2=uimenu(h1,'Label','Library (generators.mdl)','Callback','generators');
        h2=uimenu(h1,'Label','AG Example (AGex.mdl)','Callback','AGex');
        h2=uimenu(h1,'Label','SG Example (SGex.mdl)','Callback','SGex');
        h2=uimenu(h1,'Label','PG Example (PGex.mdl)','Callback','PGex');
        h2=uimenu(h1,'Label','TPG Example (TPGex.mdl)','Callback','TPGex');
        h2=uimenu(h1,'Label','FSG Example (FSGex.mdl)','Callback','FSGex');     

   h1=uimenu(h,'Label','File Converters');
      	h2=uimenu(h1,'Label','Convert ATP to MATLAB (emtp2mat.m)', ...
         'Callback','emtp2mat');
   h1=uimenu(h,'Label','Power System Model',...
   		'Callback','powerlib');
        	
h=uimenu('Label','QUIT');
   h1=uimenu(h,'Label','MERIT2016', ...
	    'Callback','quit_merit');
   h1=uimenu(h,'Label','MATLAB', ...
	    'Callback','quit_matlab');
    

