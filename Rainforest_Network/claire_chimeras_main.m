% Modifications on Xinzhu and Ali's code (add graph structure types, directly accept graph A as ODEfunc
% argument in rm_model, plot both predator and prey dynamics on same scale)

%set desired number of nodes (11 for rainforest)
n = 11;
% visualize graph structure
figure(1)

%% Only one of the below should be uncommented!

% 1. graph with x*100% links
%x = 0.5;
%A = rand(n,n)<x; 
%A  = triu(A) - diag(diag(triu(A))) + triu(A)'; % flip upper triangle over to make symmetric

% 2. Lattice graph -- only proceeds if n is a perfect square
%if mod(sqrt(n),1) ~= 0
%    error('n must be a perfect square to form a lattice')
%end
%A = make_lattice(sqrt(n));

%3. Chain/cycle graph
%A = make_chain(n);

%4. Path graph (node n not connected to node 1, unlike chain)
%A = make_path(n);

%5. Rainforest model based on Biological Dynamics of Forest Fragments
%Project, Manaus, Brazil
A = make_rainforest;

%%

G = graph(A,'omitselfloops');
plot(G);
title("graph size n = " + string(n));
hold off;

% start code
t0 = 0;
tfinal = 10000;

% initial conditions 
y0_vec = rand(1,2*n)*0.4;

%FOR RAINFOREST w/ carrying cap
k = 1.5;
sigma = 1.7;


[t,y] = ode45(@(t,y) rm_model_c(t,y,k, sigma, A),[t0,tfinal],y0_vec);


figure(2) %plots population value over time (y axis), for each node (x axis)
imagesc(y(5000:tfinal,1:n));
title('Prey population');
colorbar
cl = caxis;

figure(3)
imagesc(y(5000:tfinal,n+1:end));
title('Predator population');
colorbar
caxis(cl)%puts the predator and prey populations at the same scale for easier visual comparison

%classify_x(y(5000:tfinal,1:n)) %classifies the prey/plant population


