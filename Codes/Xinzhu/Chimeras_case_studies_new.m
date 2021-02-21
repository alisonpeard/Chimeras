t0 = 0;
tfinal = 7000;
y1 = 1.02*ones(3,1);
y2 = 0.502+rand(1,1);
y3 = 0.3+rand(2,1);
y4 = 0.05*ones(3,1);
y5 = 0.252*ones(3,1);
y6 = 0.13+rand(1,1);
y7 = 0.13+rand(2,1);
y8 = 0.249*ones(3,1);
y0 = [y1;y2;y3;y4;y5;y6;y7;y8];
%%
A = glattice(9);

[t,y] = ode15s(@(t,y)rm_model(t,y,A),[t0,tfinal],y0);

q = t>6500;
figure(1)
subplot(1,2,1)
plot(t(q),y(q,1:length(A)))
xlabel('Time')
ylabel('Density of Prey')
subplot(1,2,2)
plot(t(q),y(q,length(A)+1:end))
xlabel('Time')
ylabel('Density of Predator')

figure(2)
subplot(1,2,1)
imagesc([1 100],[4500 5000],y(q,1:length(A)));
ylabel('Time')
xlabel('i')
h1 = colorbar;
ylabel(h1, 'ui(density of prey)')
subplot(1,2,2)
imagesc([1 100],[6500 7000],y(q,length(A)+1:end));
ylabel('Time')
xlabel('i')
h2 = colorbar;
ylabel(h2, 'vi(density of predator)')

figure(3)
plot(graph(A))

figure(4)
subplot(1,2,1)
imagesc([1 100],[6500 7000],y(q,1:length(A)));
ylabel('Time')
xlabel('i')
h1 = colorbar;
ylabel(h1, 'ui(density of prey)')
subplot(1,2,2)
plot(y(end,1:length(A)),'.--')
xlabel('i(at t=7000)')

figure(5)
subplot(1,2,1)
imagesc([1 100],[6500 7000],y(q,length(A)+1:end));
ylabel('Time')
xlabel('i')
h1 = colorbar;
ylabel(h1, 'vi(density of predator)')
subplot(1,2,2)
plot(y(end,length(A)+1:end),'.--')
xlabel('i(at t=7000)')

%% differ the steady and non-steady state
u = y(q,1:length(A));
v = y(q,length(A)+1:end);
t1 = length(t(q));
for i = 1:length(A)
    delta_u(i) = sqrt(sum(u(:,i).^2)/t1-(sum(u(:,i))/t1)^2);
    delta_v(i) = sqrt(sum(v(:,i).^2)/t1-(sum(v(:,i))/t1)^2);
end
delta_u_nonzero = delta_u(abs(delta_u)>=10^(-4));
diff = zeros(length(delta_u_nonzero),length(delta_u_nonzero));
for i = 1:length(delta_u_nonzero)
    for j = 1:length(delta_u_nonzero)
        diff(i,j) = abs(delta_u_nonzero(i))-abs(delta_u_nonzero(j));
        diff(i,j) = abs(diff(i,j));
    end
end
if all(abs(u(end,:)) < 10^(-4))
    disp('This is a oscillation death state')
elseif any(abs(delta_u) < 10^(-8))
    if all(abs(delta_u) < 10^(-8))
        disp('This is a chimera death state')
    elseif any(diff >= 10^(-4))
        disp('This is an amplitude chimera and stable zero steady state')
    else
        disp('This is a CSOD state')
    end
elseif any(diff >= 10^(-4))
    disp('This is a amplitude chimera state ')
elseif any(diff <= 10^(-4))
    disp('This is a synchronized oscillation state')
end






