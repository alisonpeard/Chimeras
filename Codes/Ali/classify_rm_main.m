% classify rm models
%% choose graph type
clear;clc;

n = 20;  % number of nodes
graph_types = ["chain","nonloc_chain","lattice","rand"];
graph_type = graph_types(2);

P = 2;
t0 = 0;
tfinal = 10000;

%rng(1)
y0_vec = randi([0 5],1,2*n); 


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


%% Classifier
figure(1)
subplot(1,2,1)
imagesc(prey)
title("prey: " + classify_x(prey))
subplot(1,2,2)
imagesc(pred)
title("pred: " + classify_x(pred))