function [] = spin( frame, ifi, freq, center, radius, numArcs, window)
%Assume frame count starts at 1, but it doesn't really matter over a span
%of time as long as there is consistensy
%Inter Frame Interval (ifi) as input to keep consistency in case sample changes

%define square circumscribing the circle
square = [center(1)-radius/2 center(2)-radius/2 center(1)+radius/2 ...
center(2)+radius/2];

for arc = 0:(numArcs-1)
        
        intensity = .5 + .5*sin(2*pi()*(freq*ifi*(frame-1) + arc/numArcs));
        
        Screen('FillArc', window, intensity, square, ...
            arc/numArcs*360 - 90, 1/numArcs*360);
       
end


end

