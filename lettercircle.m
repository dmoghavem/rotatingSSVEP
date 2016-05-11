function [] = lettercircle( center, radius, window, labels, color)

for label = 1:length(labels)
    
pos = [center(1) + sin((label - 1)/length(labels)*2*pi())*radius,...
    center(2) - cos((label - 1)/length(labels)*2*pi())*radius];

DrawFormattedText(window, labels(label), 'center', 'center',...
        color, [],[],[],[],[], [pos pos]);
end

end

