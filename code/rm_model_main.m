% Exploring RM model
n = 100;    % number of nodes
graph_types = ["chain","lattice","rand90"];
graph_type = graph_types(1);

t0 = 0;
tfinal = 10000;
%rng(1)
y0_vec = randi([0 5],1,2*n); 

%% visualise graph
if graph_type == "chain"
    A = make_chain(n);
elseif graph_type == "rand90"
    A = rand(n,n)<0.9; 
    A  = triu(A) - diag(diag(triu(A))) + triu(A)'; % flip upper triangle over to make symmetric
end

% plot graph
figure(1)
G = graph(A,'omitselfloops');
plot(G);
title("graph size n = " + string(n));
hold off;

%% using 2015 paper model

[t,y] = ode45('rm_model2015',[t0,tfinal],y0_vec);

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
figure(2)
imagesc(y(5000:tfinal,1:n));
colorbar
ylabel('time')
xlabel('node number')
title('spatiotemporal dynamics of 2015 RM model network')
timestamp = string(datestr(datetime('now')));
saveas(gcf,'st plot 2015 RM' + graph_type + timestamp,'jpeg')

%% Using simple RM model with same initial conditions
k = 2; sigma = 1e-1;
[t,y] = ode45(@(t,y) rm_modelsimple(t,y, k,sigma, graph_type), [t0,tfinal], y0_vec);
tsteps = length(t);

% spatiotemporal plot after half the timesteps
figure(3)
imagesc(y(0.5*tsteps:tsteps,1:n));
colorbar
ylabel('time')
xlabel('node number')
title('spatiotemporal dynamics of simple RM model network, \{k,\sigma\} = \{' + string(k) + ',' + string(sigma) + '\}')
timestamp = string(datestr(datetime('now')));
saveas(gcf,'plot simple RM' + graph_type + timestamp,'jpeg')