%% Explanation of this matlab script
% This matlab script allows to output your currents and voltages to .csv
% file. The .csv file will then have a header:
%                           e.g. time, V1, V2, V3, I1, I2, I3, 
% and values for each timestamp: 
%                           e.g. 0.0005	10.79	-64.67	53.87	0.24	-0.09	-0.14
%
% To use this script you need to do the following:
% 1) Add the following building block to your simulink model: 
%   'to workspace' and name your 'to workspace' building block 'ScopeDataA'
%   or 'ScopeDataB'. Two building blocks are needed for the line differential protection.  
% 2) Connect currents and voltages to it using a mux (multiplexer). The
% currents and voltages are extracted from this signal using the script
% below as 'Va = RelayAdata.signals(1).values(SaRange,1).*(Vscale)'.
% Therefore make sure your voltages are the first three indices of the mux
% output, this corresponds to connecting the voltages to the top input of
% the mux. Vice versa with the currents. 
% 3) Set the 'Save format' parameter of the 'to workspace'-properties to 'structure with time'.  
% 4) Alter the configuration settings (below) to fit your model

%% configuration - change your settings and files here

Vscale=1;       % Vscale = 2e-4 for 100V peak secondary, 5e5 peak primary.
Iscale=1;        % Iscale = 2e-4 for 8A peak secondary, 4e4 peak primary.

Simulate=0;         % set this to 1 to simulate your model before formatting the data

% Two scopes are needed for the line differential 
RelayAdata=ScopeDataA;  % if using scopes or 'to workspace' to save data, paste the data names here
% RelayBdata=ScopeDataB;  % if using scopes or 'to workspace' to save data, paste the data names here

ProtectionScheme=-1;     % select protection scheme here - 1: overcurrent, 2: distance, 3: differential


TimeRange = [0.5, 1.5]; % Only a part of your simulation will be saved in the .csv file. 
                      % The transition to steady state at the beginning of the simulation is not needed. 
                      % The maximal limit of your TimeRange may not
                      % exceeded the simulation time.
                      
%% The following code formats the data based on the above parameters

if Simulate==1
    % sim('TypeIV_reduced_v1_1_2020a')  % running named model from script*
    sim(bdroot)                         % running most recent model from script*
end

% Extract data from simulation
    
SaStart=find(RelayAdata.time==TimeRange(1));
SaEnd=find(RelayAdata.time==TimeRange(2));
SaRange=[SaStart:SaEnd];
row = transpose(1:length(SaRange));

time = RelayAdata.time(SaRange);

V1 = RelayAdata.signals.values(SaRange,1).*(Vscale);
V2 = RelayAdata.signals.values(SaRange,2).*(Vscale);
V3 = RelayAdata.signals.values(SaRange,3).*(Vscale);
I1 = RelayAdata.signals.values(SaRange,4).*(Iscale);
I2 = RelayAdata.signals.values(SaRange,5).*(Iscale);
I3 = RelayAdata.signals.values(SaRange,6).*(Iscale);

% V4 = RelayBdata.signals.values(SaRange,1).*(Vscale);
% V5 = RelayBdata.signals.values(SaRange,2).*(Vscale);
% V6 = RelayBdata.signals.values(SaRange,3).*(Vscale);
% I4 = RelayBdata.signals.values(SaRange,4).*(Iscale);
% I5 = RelayBdata.signals.values(SaRange,5).*(Iscale);
% I6 = RelayBdata.signals.values(SaRange,6).*(Iscale);

FileName = input('Please enter a file name:', 's');

FN_dat = [FileName,'.csv'];

switch ProtectionScheme
    case 1      % overcurrent
        A = [time,I1,I2,I3];
        T = array2table(A);
        T.Properties.VariableNames(1:4) = {'time','I1','I2','I3'};
    case 2      % distance
         A = [time,V1,V2,V3,I1,I2,I3];
        T = array2table(A);
        T.Properties.VariableNames(1:7) = {'time','V1','V2','V3','I1','I2','I3'};
    case 3      % differential
        A = [time,I1,I2,I3,I4,I5,I6];
        T = array2table(A);
        T.Properties.VariableNames(1:7) = {'time','I1','I2','I3','I4','I5','I6'};
end

writetable(T, FN_dat);