function k = classify(u)
tol1 = 10^(-4);
tol2 = 10^(-2);
% CALCULATE ALL THE THINGS WE NEED
% standard deviations
delta_u = std(u);
% extract the standard that aren't in steady state
delta_u_nonstea = delta_u(abs(delta_u(:))>=tol1);
% empty matrix for differences in standard deviations of non-steady state
% nodes
diff = zeros(length(delta_u_nonstea),length(delta_u_nonstea));
% fill the matrix with absolute differences
for i = 1:length(delta_u_nonstea)
    for j = 1:length(delta_u_nonstea)
        diff(i,j) = (abs(delta_u_nonstea(i))-abs(delta_u_nonstea(j)))/abs(delta_u_nonstea(i));
        diff(i,j) = abs(diff(i,j));
    end
end
% calculate the period each node is oscillating with
periods = zeros(length(delta_u_nonstea),1);
% extract the nodes that aren't in steady state
u1 = u(:,abs(delta_u(:))>=tol1);
% find periods of all these nodes
for n=1:length(delta_u_nonstea)
    periods(n) = findperiod(u1(:,n));
end
% create matrix of relative differences between the node frequencies
diff_per = zeros(length(periods),length(periods));
for i = 1:length(delta_u_nonstea)
    for j = 1:length(delta_u_nonstea)
        diff_per(i,j) = (abs(periods(i))-abs(periods(j)))/abs(periods(i));
        diff_per(i,j) = abs(diff_per(i,j));
    end
end
% END OF CALCULATIONS, START OF CLASSIFICATIONS
% if not all nodes are in death state then we check their correlation
if isempty(u1)==0
    corr_matrix = abs(corr(u1));
end

% if all standard deviations are less than zero => death states
if all(abs(delta_u(:)) < tol1)
    %disp('This is a death state')
    k = 2;
    
% if some are in death states
elseif any(abs(delta_u(:)) < tol1)
    % and all correlated and similar amplitudes (std)
    if all(corr_matrix(:,:) > 0.95)
        if all(diff(:,:) < tol2)
            %disp('This is an CSOD state')
            k = 4;
        else
            %disp('This is an amplitude chimera and death state')
            k = 3;
        end
    else
        % if all have same periods but not correlated or similar amplitudes
        if all(diff_per(:,:) < tol2)
            %disp('This is a amplitude chimera state ')
            k = 5;
        else
            %disp('This is an others ')
            k = 1;
        end
    end
else 
    % no nodes in zero state
    % if all nonzero nodes strongly correlated and same amp=> csod
    % we aren't checking periods here for some reason not sure
    if all(corr_matrix(:,:) > 0.95)
        if all(diff(:,:) < tol2)
            %disp('This is a synchronized oscillation state')
            k = 6;
            % if not same amplitudes but pretty correlated say AC&death?
        else
            %disp('This is an amplitude chimera state')
            k = 5;
        end
    else 
       % check freq/period separately and if they're close we still say AC
        if all(diff_per(:) < tol2)
            %disp('This is an amplitude chimera state')
            k = 5;
        else
            % others
            %disp('This is a other ')
            k = 1;
        end
    end
end
end


