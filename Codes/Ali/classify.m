function class = classify(Y)
% crude classifier
% arg: matrix Y(t,x), t=time, x=node

    states = ["death","sync","amplitude chimera or chimera","csod","mixed amplitude chimera and death","chaos"];
    
    class = [];
    TOL = 1e-6;
    [M,N] = size(Y);
    stdvs = std(Y);
    
    if all(stdvs < TOL) % death state
        % check correlations between nodes
        class = states(1); % change to oscdeath and chimdeath later
        
    elseif range(stdvs) < TOL % sync state
        class = states(2);
        
    elseif any(stdvs < TOL) 
        Y = Y(:,find(stdvs > TOL)); % remove nodes in death state
        stdvs = std(Y);
        
        if range(stdvs) < TOL
            class = states(4); %CSOD
        else
            class = states(5); % amplitude chimera or chimera and death
        end
        
    elseif all(stdvs >= TOL)
        class = states(3);
        % check for chaos (Alec)
    end
end