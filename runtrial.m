function [ output_args ] = runtrial( numSecs, ifi, f1, f2, c1, c2, ...
    radius, window, letters, target)

numFrames = round(numSecs / ifi);

spinframe(1, ifi, f1, c1, radius, 360, window);
spinframe(2, ifi, f2, c2, radius, 360, window);
lettercircle(c1, radius*5/8, window, letters(1:3), 1);
lettercircle(c2, radius*5/8, window, letters(4:6), 1);
targetletter = '      ';
targetletter(target) = letters(target);
lettercircle(c1, radius*5/8, window, targetletter(1:3), [1 0 0]);
lettercircle(c2, radius*5/8, window, targetletter(4:6), [1 0 0]);

vbl = Screen('Flip', window);

pause(1);

for frame = 1:numFrames
    
    spinframe(frame, ifi, f1, c1, radius, 360, window);
    
    lettercircle(c1, radius*5/8, window, letters(1:3), 1);
    
    spinframe(frame, ifi, f2, c2, radius, 360, window);

    lettercircle(c2, radius*5/8, window, letters(4:6), 1);

    % Flip to the screen
    vbl = Screen('Flip', window, vbl + (1 - 0.5) * ifi);

end

Screen('Flip', window);


end

