t0 = 0;
tfinal = 7000;
% initial condition(follows 2015 paper)
y1 = 1.02*ones(36,1);
y2 = 0.502+rand(10,1);
y3 = 0.3+rand(20,1);
y4 = 0.05*ones(34,1);
y5 = 0.252*ones(36,1);
y6 = 0.13+rand(10,1);
y7 = 0.13+rand(20,1);
y8 = 0.249*ones(34,1);
y0 = [y1;y2;y3;y4;y5;y6;y7;y8];
%%
% different adjacency matrix
%A = rand(100)<0.5;
%A = gpath(100);
%A = gcycle(100);
%A = gPcycle(100,5)/(2*5); %3 %23 %45
A = glattice(100);
A(1:end,4)=1; % set one point to connect all other points
A(4,1:end)=1;
A(4,4)=0;
A(1:end,7)=1; % set two points to connect all other points
A(7,1:end)=1;
A(7,7)=0;
%A = gPlattice(100,1); % add more connection to lattice matrix
%A = ones(100)-eye(100); complete connected matrix

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
xlabel('i(at t=5000)')

figure(5)
subplot(1,2,1)
imagesc([1 100],[6500 7000],y(q,length(A)+1:end));
ylabel('Time')
xlabel('i')
h1 = colorbar;
ylabel(h1, 'vi(density of predator)')
subplot(1,2,2)
plot(y(end,length(A)+1:end),'.--')
xlabel('i(at t=5000)')





