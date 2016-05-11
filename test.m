% Clear the workspace and the screen
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

% Find desired center and radius of circle
radius = min(windowRect(3:4))/3;
c1 = [windowRect(3)/4 windowRect(4)/2];
c2 = [windowRect(3)*3/4 windowRect(4)/2];

% How many seconds (and frames) to spin
numSecs = 4;

% Set text size
Screen('TextSize', window, 80);

%create randomly permuted vector deciding which letter is the target
target = [ones(1,40)*1 ones(1,40)*2 ones(1,40)*3 ...
    ones(1,40)*4 ones(1,40)*5 ones(1,40)*6];
target = target(randperm(length(target)));

Priority(topPriorityLevel);
vbl = Screen('Flip', window);

for trial = 1:1
    runtrial(numSecs, ifi, 8, 17, c1, c2, radius, window, 'ABCDEF', ...
        target(trial));
end
Priority(0);

% Clear the screen and variables
sca;