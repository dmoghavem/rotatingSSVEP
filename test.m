% Turn off all non-essential processes before running!!!
% Clear the workspace and the screen
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

% Use diode to measure timing via flash in top right
% show progress under letter
% Instructions / structure
% Special note for feeling ill (pause or quit)
% Ask tom about how to do psychtoolbox
% Correlate with photodiode output instead of thoeretical refresh
% Ask josh about running next sunday (6/4)

%% Setup PsychToolbox and variables
%clear everything
sca;
close all;
clearvars;

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);
% Get the screen numbers. This gives us a number for each of the screens
% attached to our computer.
screens = Screen('Screens');
% To draw we select the maximum of these numbers. So in a situation where we
% have two screens attached to our monitor we will draw to the external
% screen.
screenNumber = max(screens);
% Define black and white (white will be 1 and black 0). This is because
% in general luminace values are defined between 0 and 1 with 255 steps in
% between. All values in Psychtoolbox are defined between 0 and 1
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
% Do a simply calculation to calculate the luminance value for grey. This
% will be half the luminace values for white
grey = white / 2;
% Open an on screen window using PsychImaging and color it grey.
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);
% Set the blend funciton for the screen
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
% Measure the vertical refresh rate of the monitor
ifi = Screen('GetFlipInterval', window);
% Retreive the maximum priority number
topPriorityLevel = MaxPriority(window);
%instructions message before start of experiment
instructions = ['Instructions: Two Circles will appear with three ' ...
    'letters each.  The target letter will highlight red for one second'...
    ', after which the circles will begin to spin very rapidly.  Please'...
    ' focus on the target letter for the duration of the spinning, '...
    'after which there will be a one second of pause, and then the '...
    'process will repeat.  Please notify us if you are experiencing any'...
    'discomfort or fatigue, or if you are at risk for epilepsy.'];


%% Setup Experimental variables
% Find desired center and radius of circle
radius = min(windowRect(3:4))/3;
c1 = [windowRect(3)/4 windowRect(4)/2];
c2 = [windowRect(3)*3/4 windowRect(4)/2];

load circle.mat;
CIRCLEindex = Screen('MakeTexture', window, CIRCLE);

% How many seconds (and frames) to spin
numSecs = 4;

% Set text size
Screen('TextSize', window, 80);

%create randomly permuted vector deciding which letter is the target
target = [ones(1,40)*1 ones(1,40)*2 ones(1,40)*3 ...
    ones(1,40)*4 ones(1,40)*5 ones(1,40)*6];
target = target(randperm(length(target)));

%% Start trials

Priority(topPriorityLevel);

DrawFormattedText(window, instructions , 'center', 'center', white);
vbl = Screen('Flip', window);
kbStrokeWait;
for block = 1:10
    wait_message = [num2str(block - 1) ' blocks done! Only ' ...
        num2str(11-block) ' left to go!  Let us know when you are ready.'];
    DrawFormattedText(window, wait_message , 'center', 'center', white);
    vbl = Screen('Flip', window);
    KbStrokeWait;
    for trial = 24*(block-1)+1 : 24*block
        if KbCheck
            KbStrokeWait;
        end
        marker_outlet.push_sample(num2str(target(trial)))
        runtrial(numSecs, ifi, 8, 12, c1, c2, radius, window, 'ABCDEF', ...
            target(trial), CIRCLEindex);
    end
end
Priority(0);

%% Clean up
% Clear the screen and variables
sca;
%Close LSL stream
marker_outlet.delete()