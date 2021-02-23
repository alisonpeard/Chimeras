function period = findperiod(x)
% function to roughly find period of vector x
    [~,locs]=findpeaks(x);
    period = mean(diff(locs));

end