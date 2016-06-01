%% Lab Streaming Layer Initialization
% Initialization of the lab streaming layer should occur before the
% Psychtoolbox opens a screen. That way, LabRecorder can be initialized.

%%% Set up LSL for event markers

lib_lsl_path = 'C:\PhyPA\Tools\LSL\LSL\liblsl-Matlab';

% Add path for lsl for event markers
addpath(genpath(lib_lsl_path));

% Load lsl
lib = lsl_loadlib();

% Create Marker Stream
disp 'Creating Marker Stream & Opening Oulet';

% Sets paramaters for the data stream which is being created.
stream_info = lsl_streaminfo(lib, 'EventMarkers', 'Markers', 1, 0, 'cf_string');

% Actually intializes the data stream. marker_outlet (or inlet) is the object 
% of almost all of LSL functions. Name is not important.
marker_outlet = lsl_outlet(stream_info);

%% Export marker
% This line of code pushes (prints/sends) a marker to the previously
% initialized stream.

marker_outlet.push_sample({marker})

% 'marker' is a STRING, which provides the label for the marker. The marker
% is time-locked to the evaluation of that line of code.

%% Close stream
% This should be placed at the end of the module, so that the stream is
% closed once the experiment completed. Alternatively, 

marker_outlet.delete()

% The stream also closes when MATLAB is closed, or if marker_outlet is
% assigned any value (ie, marker_outlet = 0), but this may not release
% system resources.