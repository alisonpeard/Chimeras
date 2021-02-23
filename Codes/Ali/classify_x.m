function class = classify_x(Y)
% arg: matrix Y(t,x), t=time, x=node
% made a function of Xinzhu's code

    class = [];
    TOL1 = 1e-4;
    TOL2 = 1e-8;
    
    % calculate standard deviations
    delta = std(Y);
    delta_nonzero = Y(find(delta>=TOL1));
    N2 = length(delta_nonzero);
    
    % calculate absolute differences between columns
    diff = zeros(N2,N2);
    for i = 1:N2
        for j = 1:N2
            diff(i,j) = abs( abs(delta_nonzero(i))-abs(delta_nonzero(j)) );
        end
    end
    
    if all(abs(Y(end,:)) < TOL1)
        class = "oscillation death"; %% CHECK
    elseif any(abs(delta) < TOL2)
        if all(abs(delta) < TOL2)
            class = "chimera death"; % CHECK
        elseif any(diff >= TOL1)
            class = "amplitude chimera and stable zero steady state"; %%CHECK
        else
            class = "CSOD"; % CHECK
        end
    elseif any(diff >= TOL1)
        class = "amplitude chimera state";
    elseif any(diff <= TOL1)
        class = "synchronized oscillation";
    end

end
