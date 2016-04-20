function [] = spinframewedge( frame, ifi, freq, center, radius, numArcs,...
    window, labels)
%Assume frame count starts at 1, but it doesn't really matter over a span
%of time as long as there is consistensy
%Inter Frame Interval (ifi) as input to keep consistency in case sample ifi
%changes

%Predefined distance of center of label from circle.
buffer = 50;

%define square circumscribing the circle
square = [center(1)-radius center(2)-radius center(1)+radius ...
    center(2)+radius];

%for arc = 0:(numArcs-1)
    
    %Find desired intensity of each offset (arc) at given frame with given
    %frequency and ifi
    %intensity = .5 + .5*sin(2*pi()*(freq*ifi*(frame-1) + arc/numArcs));
    
    Screen('FillArc', window, 0, square, ...
        0, 360);
    Screen('FillArc', window, 1, square, ...
        freq*ifi*(frame-1)*360 - 90, 15);
    
    
%end

if exist('labels', 'var')
    
for label = 1:length(labels)
    
pos = [center(1) - ...
    cos((label - .5)/length(labels)*2*pi())*(radius + buffer),...
    center(2) - ...
    sin((label - .5)/length(labels)*2*pi())*(radius + buffer)];

DrawFormattedText(window, labels(label), 'center', 'center',...
        [1 0 0], [],[],[],[],[], [pos pos]);
    
end

end

end

