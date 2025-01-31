% Script to setup parameters used for the whole project

% prepend functions directory to MATLAB path
fullMAINpath = mfilename('fullpath');
functionspath = [fullMAINpath(1:regexp(fullMAINpath,mfilename)-1),'functions'];
addpath(functionspath);

parameters.workingdir = './ORCA_M5.5_detrend_Zcorr_100km_snr3_600km/';
% parameters.workingdir = './ORCA_M5.5_detrend_Zcorr_100km_snr3/';
% parameters.workingdir = './ORCA_M5.5_Zcorr_100km_snr3/';

%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%%
%%%% Global settings
parameters.proj_name = 'XX';
parameters.component = 'BHZ';   % determined by filenames
parameters.lalim = [-9 -3] ;
parameters.lolim = [-136 -130];
parameters.gridsize=1;   % in degrees
% parameters.periods = [20 25 32 40 50 60 80 100 120 130 150]; %[20 25 32 40 50 60 80 100];  % in seconds
parameters.periods = round(logspace(log10(20),log10(150),15));

%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%%
% % parameters for data downloading (if using IRIS DMC)
% parameters.start_time = '2009-01-07 00:00:00';
% parameters.end_time = '2009-06-08 00:00:00'; % put '' for using 4 days before current date
% parameters.is_use_timestamp = 0;
% parameters.network = '_US-ALL';
% parameters.minMw = 6;
% parameters.maxdepth = 50;
% parameters.datalength = 7200;  % in second
% parameters.resample_delta = 1; % in second
% parameters.dbpath = './sacdata/';
% parameters.eventfile = 'eventlist';

%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%%
% Parameters for own data selection criteria
parameters.dbpath = '/Users/russell/Lamont/PROJ_YoungPacificORCA/DATA/EVENTS/IRIS_XX_5.5_detrend_18sta_Zcorr/'; %'/Users/russell/Lamont/ENAM/DATA/EVENTS/IRIS_YO_6.5/';
parameters.eventfile = 'evlist.txt';
parameters.minMw = 5.5;
parameters.maxdepth = 50;
parameters.snr_tol = 3;

%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%%
% parameters for the auto_win_select.m
parameters.largest_epidist_range = 3000;
parameters.cycle_before = 2;
parameters.cycle_after = 3;
parameters.min_dist_tol = deg2km(20);
parameters.max_dist_tol = deg2km(100); %deg2km(160);
parameters.min_groupv = 2;
parameters.max_groupv = 5;
parameters.cent_freq = 0.025;
parameters.min_sta_num = 5; %10 %JBR

%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%%
% parameters for the cross-correlation measurement
% (gsdfmain.m)
parameters.minstadist = 5;
parameters.maxstadist = 600; %600; %250 %200;   % station cross-correlation distance in km
parameters.is_rm_resp = 0;
parameters.periods = sort(parameters.periods);  % make sure periods are ascending
parameters.refv = 4;   % to select the correct cycle
parameters.refphv = ones(size(parameters.periods))*4;
parameters.min_width = 0.06;  % to build up gaussian filters
parameters.max_width = 0.10;  
parameters.wintaperlength = 30;   % taper to build up the isolation filter
parameters.prefilter = [10,160]; %[15,160]; %[10,200];
parameters.xcor_win_halflength = 200; %300; %200 %150;  % window for the cross-correlation
parameters.xcor_win_iter = zeros(size(parameters.periods)); % re-apply the xcor window due to measured group delay, should be same length as periods, not used anymore
parameters.Nfit = 2; %4; % 2
parameters.Ncircle = 5;
parameters.cohere_tol = 0.65; % minimum coherenecy between two stations
parameters.tp_tol = 10;  % seconds away from averaged phase velocity 

%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%%
% parameters for the tomography
% (eikonal_eq.m helmholtz_eq.m)
parameters.smweight_array = 3*[0.4 0.3 0.2 0.2 0.2 0.5 0.5 0.5 1 1 1 2 3 3 3]; %3*[0.4 0.3 0.2 0.2 0.2 0.5 1 2 2 3 3] %3*[0.4 0.3 0.2 0.2 0.2 0.5 1 2];  % smoothing weight for the deltaSx and delta Sy
parameters.flweight_array = 100*ones(length(parameters.periods)); % JBR
parameters.raydensetol=deg2km(parameters.gridsize)*2;
parameters.Tdumpweight = 0;  % dumping the ray to the girgle circle path
parameters.Rdumpweight = 0;  % dumping the region to have the same phase velocity
parameters.fiterrtol = 3;   % error allowed in the wavelet fitting
parameters.isRsmooth = 1;  % smoothing due to Sx and Sy or Sr and S_theta
parameters.dterrtol = 2;    % largest variance of the inversion error allowed
parameters.inverse_err_tol = 2;  % count be number of standard devition
parameters.min_amp_tol = 0.1;  % station with amplitude smaller than this ratio of average amplitude will not be used.
parameters.amp_var_tol = 2; % how much times change of amplitude of single station to the mean value of nearby stations should be considered as bad measurement
parameters.alpha_range = [1 1];
parameters.alpha_search_grid = 0.1;

%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%%
% parameter for stacking 
% (stack_phv.m stack_helm.m)
parameters.min_csgoodratio= 1*ones(length(parameters.periods));%[3 3 3 3 5 10 15 15 15 15 20]; %[3 3 3 3 5 10 15 15]; % minimum radio between good and bad measurements for a good event
parameters.min_phv_tol = 3;
parameters.max_phv_tol = 5;
parameters.is_raydense_weight = 0; %1; % manual says suggested turned off for large azimuthal anisotropy
parameters.min_event_num = 3; %10;
parameters.err_std_tol = 2;
parameters.issmoothmap = 1;
parameters.smooth_wavelength = 0.25;
parameters.event_bias_tol = 3; %2;


%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%%
% parameters for azimuthal anisotropy inversion
% beta version
parameters.smsize = 10; %1;  % averaging nearby grid number
parameters.off_azi_tol = 30; % differ from great circle path in degrees
parameters.is_one_phi = 0; %1;

if length(parameters.periods)~=length(parameters.smweight_array) || length(parameters.periods)~=length(parameters.min_csgoodratio)
    error('Length of periods doesn''t match smweight_array and/or min_csgoodratio');
end

system(['cp ./setup_parameters.m ',parameters.workingdir]);
