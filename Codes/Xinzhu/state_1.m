function k = state_1(A,y,q,t)
u = y(q,1:length(A));
delta_u = std(u);
delta_u_nonstea = delta_u(abs(delta_u(:))>=10^(-4));
diff = zeros(length(delta_u_nonstea),length(delta_u_nonstea));
for i = 1:length(delta_u_nonstea)
    for j = 1:length(delta_u_nonstea)
        diff(i,j) = (abs(delta_u_nonstea(i))-abs(delta_u_nonstea(j)))/abs(delta_u_nonstea(i));
        diff(i,j) = abs(diff(i,j));
    end
end
if all(abs(delta_u(:)) < 10^(-4))
    if range(u(end,:)) < 10^(-4)
        %disp('This is a steady state')
        k = 1;
    else
        %disp('This is a chimera death state')
        k = 2;
    end
elseif any(abs(delta_u(:)) < 10^(-4))
    if any(diff(:) >= 10^(-2))
            %disp('This is an amplitude chimera and steady state')
            k = 3;
    else
            %disp('This is an CSOD state')
            k = 4;
    end
else
    if any(diff(:) >= 10^(-2))
        %disp('This is a amplitude chimera state ')
        k = 5;
    else 
        %disp('This is a synchronized oscillation state')
        k = 6;
    end
end
end