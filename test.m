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

% Find desired center and radius of circle
radius = min(windowRect(3:4))/6;
[center(1), center(2)] = RectCenter(windowRect);

% Measure the vertical refresh rate of the monitor
ifi = Screen('GetFlipInterval', window);

% Retreive the maximum priority number
topPriorityLevel = MaxPriority(window);

% Length of time and number of frames we will use for each drawing test
numSecs = 5;
numFrames = round(numSecs / ifi);

% Numer of frames to wait when specifying good timing. Note: the use of
% wait frames is to show a generalisable coding. For example, by using
% waitframes = 2 one would flip on every other frame. See the PTB
% documentation for details. In what follows we flip every frame.
waitframes = 1;


% Draw text in the upper portion of the screen with the default font in red
Screen('TextSize', window, 50);

Priority(topPriorityLevel);
vbl = Screen('Flip', window);
for frame = 1:numFrames
    
    spin(frame, ifi, 15, center, radius, 4, window);


%     DrawFormattedText(window, 'A', rect(1), rect(2) - side/8, [1 0 0]);
%     DrawFormattedText(window, 'B', 'right', rect(2) - side/8, [1 0 0],...
%         [],[],[],[],[], rect);
%     DrawFormattedText(window, 'C', 'right', rect(4) - side/8, [1 0 0],...
%         [],[],[],[],[], rect);
%     DrawFormattedText(window, 'D', rect(1), rect(4) - side/8, [1 0 0]);

    % Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

end
% for frame = 1:numFrames
%     
%     % Color screen to desired intensity
%     intensity = .5 + .5*sin(2*pi*freq*ifi*(frame-1));
% 
%     Screen('FillRect', window, intensity, rect);
% 
%     % Flip to the screen
%     vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
% 
% end
Priority(0);
pause(5);
% Clear the screen and variables
sca;