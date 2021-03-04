function class = classify_x(Y)
% arg: matrix Y(t,x), t=time, x=node

    class = [];
    TOL1 = 1e-4; % for death states
    TOL2 = 1e-2; % for differences between nodes
    [M,N] = size(Y);
    corr_matrix = abs(corr(Y)); % absolute correlation between nodes
    
    % calculate standard deviations
    delta = std(Y);
    
    % removing death states
    delta_nonzero = delta(find(delta>=TOL1)); 
    N2 = length(delta_nonzero);
    
    % calculate periodicity of non-death state columns
    periods = zeros(N,1);
    for n=1:N
        periods(n) = findperiod(Y(:,n));
    end
    
    % calculate absolute differences between std of non steady state columns
    diff = zeros(N2,N2);
    for i = 1:N2
        for j = 1:N2
            diff(i,j) = abs( abs(delta_nonzero(i))-abs(delta_nonzero(j)) );
        end
    end
    
    % if nodes are all spatiall correlated there are no chimeras
    if all(corr_matrix(:,1) > 0.9)
        class = "synchronised oscillation";
    % If there are any death states: CD / CSOD / AC and death
    elseif any(abs(delta) <= TOL1)
        if all(abs(delta) <= TOL1) % death states
            if range(Y(end,:) )<= TOL2
                class = "oscillation death";
            else
                class = "chimera death";
            end
        elseif range(delta_nonzero) <= TOL2
            class = "CSOD"; 
        elseif range(periods)<=TOL2
            class = "amplitude chimera and death";
        end
        
    % if there are no death states
    elseif range(delta) <= TOL2 % sync state
        class = "synchronized oscillation";
    elseif range(periods)<=TOL2
        class = "amplitude chimera";
    else 
        class = "other";
    end

end
