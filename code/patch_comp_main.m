% patch size (k) vs patch number analysis
% i.e. do fewer larger patches support ecosystem survival better than more
% patched with small capacity?

graph_type = "nonloc_chain";
P = 2; % same amount of nonlocal coupling for each system

%% System 1: lots of small, fragmented patches
n = 100;
k = 0.15;
sigma = 1.7;
t0 = 0;
tfinal = 10000;

y0_vec = randi([0 5],1,2*n); 

[t,y] = ode45(@(t,y) rm_modelsimple(t,y, k,sigma, graph_type,P), [t0,tfinal], y0_vec);% take tail of results
fin = length(t);
frac = 0.7;
start = ceil(frac*fin);
range = [t(start) t(fin)];
prey = y(start:fin,1:n);
pred = y(start:fin,n+1:end);
time = t(start:fin);

% spatiotemporal plots for prey and predators for tail of results

figure(1)
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
title('temporal prey dynamics of simple RM model network, \{k,\sigma\} = \{' + string(k) + ',' + string(sigma) + '\}')


pause;
%% System 2: fewer patches with large capacity
n = 4;
k = 3;
sigma = 1.7;
t0 = 0;
tfinal = 10000;
y0_vec = randi([0 5],1,2*n); 

[t,y] = ode45(@(t,y) rm_modelsimple(t,y, k,sigma, graph_type,P), [t0,tfinal], y0_vec);
lts
fin = length(t);
frac = 0.7;
start = ceil(frac*fin);
range = [t(start) t(fin)];
prey = y(start:fin,1:n);
pred = y(start:fin,n+1:end);
time = t(start:fin);

% spatiotemporal plots for prey and predators for tail of results

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
title('temporal prey dynamics of simple RM model network, \{k,\sigma\} = \{' + string(k) + ',' + string(sigma) + '\}')