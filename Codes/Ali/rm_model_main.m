% Exploring Rosenzweig-Macarthur predator-prey model
% works for random graphs, chains with local-> nonlocal -> global coupling,
% and lattices (using Andrew's code)

%% choose graph type
clear;clc;
n = 20;  % number of nodes
graph_types = ["chain","nonloc_chain","lattice","rand"];
graph_type = graph_types(2);

t0 = 0;
tfinal = 10000;

%rng(1)
y0_vec = randi([0 0.4],1,2*n); 

%% visualise graph

figure(1)

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
G = graph(A,'omitselfloops');
plot(G);
title("graph size n = " + string(n));
hold off;


%% solve simple RM model using ode 45

k = 0.5; % prey carrying capacity 0.5
sigma = 1.7; % coupling strength 1.7

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

prey = y(start:fin,1:n);
pred = y(start:fin,n+1:end);
time = t(start:fin);

%% spatiotemporal plots for prey and predators for tail of results

figure(2)
subplot(3,1,1)
imagesc(prey);
set(gca,'YDir','normal');
colorbar
ylabel('time')
xlabel('node index')
title('temporal prey dynamics of simple RM model network, \{k,\sigma\} = \{' + string(k) + ',' + string(sigma) + '\}')

subplot(3,1,2)
imagesc(pred);
set(gca,'YDir','normal');
colorbar
ylabel('time')
xlabel('node index')
title('temporal pred dynamics of simple RM model network, \{k,\sigma\} = \{' + string(k) + ',' + string(sigma) + '\}')

%% time series of dynamics for node 1 plot

subplot(3,1,3)
node = 1;
plot(time, prey(1)); hold on;
plot(time, pred(1));
xlim(range)
title('Dynamics for node 1')
xlabel('Time')
ylabel('Population')
legend('Prey', 'Predator')

% save figure
%timestamp = string(datestr(datetime('now')));
%saveas(gcf,'plots/plot simple RM' + graph_type + timestamp,'jpeg')

%% plot standard deviations for each prey node, if standard deviation is always less than TOL then assume steady state

figure(3)
TOL = 1e-6;

stdu = std(prey);
subplot(1,2,1)
plot(1:n,stdu,'-.')
xlabel('prey node index')
ylabel('standard deviation')

stdv = std(pred);

subplot(1,2,2)
plot(1:n,stdv,'-.')
xlabel('predator node index')
ylabel('standard deviation')

if all(stdu < TOL )
    disp('some prey is in steady state')
else
    disp('some prey not in steady state')
end
if all(stdv < TOL )
    disp('some predator is in steady state')
else
    disp('some predator not in steady state')
end

%% Classifier
figure(4)
subplot(1,2,1)
imagesc(prey)
title("prey: " + classify_x(prey))
subplot(1,2,2)
imagesc(pred)
title("pred: " + classify_x(pred))

