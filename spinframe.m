function [] = spinframe( frame, ifi, freq, center, radius, window, circle)
%Assume frame count starts at 1, but it doesn't really matter over a span
%of time as long as there is consistensy
%Inter Frame Interval (ifi) as input to keep consistency in case sample ifi
%changes

%define square circumscribing the circle
square = [center(1)-radius center(2)-radius center(1)+radius ...
    center(2)+radius];

Screen('DrawTexture', window, circle, [], square, freq*ifi*(frame-1)*360);

end

