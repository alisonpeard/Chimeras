% Exploring Rosenzweig-Macarthur predator-prey model
% works for random graphs, chains with local-> nonlocal -> global coupling,
% and lattices (andrew's code)

n = 100;  % number of nodes
graph_types = ["chain","nonloc_chain","lattice","rand"];
graph_type = graph_types(2);

t0 = 0;
tfinal = 10000;
%rng(1)
y0_vec = randi([0 5],1,2*n); 

%% visualise graph
if graph_type == "chain"
    A = make_chain(n);
elseif graph_type == "lattice"
    A = glattice(n);
elseif graph_type == "rand"
    P = input("Enter P-value: ");
    A = rand(n,n)<P; 
    A  = triu(A) - diag(diag(triu(A))) + triu(A)'; % flip upper triangle over to make symmetric
elseif graph_type == "nonloc_chain"
    P = input("Enter P-value: ");
    A = make_chain(n,P);
end

% plot graph
figure(1)
G = graph(A,'omitselfloops');
plot(G);
title("graph size n = " + string(n));
hold off;


%% simple RM model
k = 0.5; % prey carrying capacity
sigma = 1.7; % coupling strength

if graph_type == "nonloc_chain" || graph_type == "rand"
    [t,y] = ode45(@(t,y) rm_modelsimple(t,y, k,sigma, graph_type,P), [t0,tfinal], y0_vec);
else
    [t,y] = ode45(@(t,y) rm_modelsimple(t,y, k,sigma, graph_type), [t0,tfinal], y0_vec);
end

% take tail of results
fin = length(t);
frac = 0.7;
start = ceil(frac*fin);
range = [t(start) t(fin)];

% spatiotemporal plot for prey and predators for tail of results
figure(2)
subplot(3,1,1)
imagesc(y(start:fin,1:n));
set(gca,'YDir','normal');
colorbar
ylabel('time')
xlabel('node index')
title('temporal prey dynamics of simple RM model network, \{k,\sigma\} = \{' + string(k) + ',' + string(sigma) + '\}')

subplot(3,1,2)
imagesc(y(start:fin,n+1:end));
set(gca,'YDir','normal');
colorbar
ylabel('time')
xlabel('node index')
title('temporal prey dynamics of simple RM model network, \{k,\sigma\} = \{' + string(k) + ',' + string(sigma) + '\}')

% time series of dynamics for node 1 plot
subplot(3,1,3)
plot(t(start:fin), y(start:fin,[1, n+1]));
xlim(range)
title('Dynamics for node 1')
xlabel('Time')
ylabel('Population')
legend('Prey', 'Predator')

figure(4)
% plot standard deviations for each node (see 2015 paper)
% standard deviation for each prey node
stdu = zeros(n,1);
for i = 1:n
    stdu(i) = sqrt( mean(y(start:fin,i)) - mean(y(start:fin,i))^2  );
end
subplot(1,2,1)
plot(1:n,stdu,'-.')
xlabel('prey node index')
ylabel('standard deviation')

% standard deviation for each pred node
stdv = zeros(n,1);
for i = 1:n
    stdv(i) = sqrt( mean(y(start:fin,i)) - mean(y(start:fin,i))^2  );
end
subplot(1,2,2)
plot(1:n,stdu,'-.')
xlabel('predator node index')
ylabel('standard deviation')

% save figure
%timestamp = string(datestr(datetime('now')));
%saveas(gcf,'plots/plot simple RM' + graph_type + timestamp,'jpeg')

disp('Press a key to continue')
pause;
%% using 2015 paper model

if graph_type == "nonloc_chain" || graph_type == "rand"
    [t,y] = ode45(@(t,y) rm_model2015(t,y, graph_type,P), [t0,tfinal], y0_vec);
else
    [t,y] = ode45(@(t,y) rm_model2015(t,y, graph_type), [t0,tfinal], y0_vec);
end
fin = length(t);
start = ceil(frac*fin);

% figure(3)
% shows plot changing
% for i=1:100:tfinal
%     imagesc(y(i,1:n));
%     %colorbar;
%     %caxis([0 5]);
%     title("time = " + string(i))
%     pause(.001)
% end

% spatiotemporal plot after 5000 timesteps
figure(3)
subplot(2,1,1)
imagesc(y(start:fin,1:n));
set(gca,'YDir','normal');
colorbar
ylabel('time')
xlabel('node number')
title('spatiotemporal dynamics of 2015 RM model network')

subplot(2,1,2)
plot(t(start:fin), y(start:fin,[1,n+1]));
xlim(range)
title("Dynamics for node 1")
xlabel('Time')
ylabel('Population')
legend('Plants', 'Herbivores')

timestamp = string(datestr(datetime('now')));
saveas(gcf,'plots/plot simple RM' + graph_type + timestamp,'jpeg')

timestamp = string(datestr(datetime('now')));
saveas(gcf,'plots/st plot 2015 RM' + graph_type + timestamp,'jpeg')