function k = classfy(A,y,q)
u = y(q,1:length(A)); % only the prey, want to check predator need to 
% change u = y(q,1:length(A)) to u = y(q,length(A)+1:end) ;
tol1 = 10^(-4);
tol2 = 10^(-2);
delta_u = std(u);
delta_u_nonstea = delta_u(abs(delta_u(:))>=tol1);
diff = zeros(length(delta_u_nonstea),length(delta_u_nonstea));
for i = 1:length(delta_u_nonstea)
    for j = 1:length(delta_u_nonstea)
        diff(i,j) = (abs(delta_u_nonstea(i))-abs(delta_u_nonstea(j)))/abs(delta_u_nonstea(i));
        diff(i,j) = abs(diff(i,j));
    end
end
periods = zeros(length(delta_u_nonstea),1);
u1 = u(:,abs(delta_u(:))>=tol1);
for n=1:length(delta_u_nonstea)
    periods(n) = findperiod(u1(:,n));
end
diff_per = zeros(length(periods),length(periods));
for i = 1:length(delta_u_nonstea)
    for j = 1:length(delta_u_nonstea)
        diff_per(i,j) = (abs(periods(i))-abs(periods(j)))/abs(periods(i));
        diff_per(i,j) = abs(diff_per(i,j));
    end
end
if isempty(u1)==0
    corr_matrix = abs(corr(u1));
end
if all(abs(delta_u(:)) < tol1)
    %disp('This is a death state')
    k = 2;
elseif any(abs(delta_u(:)) < tol1)
    if all(corr_matrix(:,:) > 0.95)
        if all(diff(:,:) < tol2)
            %disp('This is an CSOD state')
            k = 4;
        else
            %disp('This is an amplitude chimera and death state')
            k = 3;
        end
    else
        if all(diff_per(:,:) < tol2)
            %disp('This is a amplitude chimera state ')
            k = 5;
        else
            %disp('This is an nonperiodic orbits ')
            k = 1;
        end
    end
else 
    if all(corr_matrix(:,:) > 0.95)
        if all(diff(:,:) < tol2)
            %disp('This is a synchronized oscillation state')
            k = 6;
        else
            %disp('This is an amplitude chimera state')
            k = 5;
        end
   else 
        if all(diff_per(:) < tol2)
            %disp('This is an amplitude chimera state')
            k = 5;
        else
            %disp('This is an nonperiodic orbits ')
            k = 1;
        end
    end
end
end


