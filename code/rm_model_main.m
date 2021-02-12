% Exploring Rosenzweig-Macarthur predator-prey mo
% how to change y-axis on imagesc
% check which is prey which is pred

n = 4;    % number of nodes
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


%% Using simple RM model with same initial conditions
k = 2; sigma = 1e-1;
if graph_type == "nonloc_chain" || graph_type == "rand"
    [t,y] = ode45(@(t,y) rm_modelsimple(t,y, k,sigma, graph_type,P), [t0,tfinal], y0_vec);
else
    [t,y] = ode45(@(t,y) rm_modelsimple(t,y, k,sigma, graph_type), [t0,tfinal], y0_vec);
end

fin = length(t);
frac = 0.7;
start = ceil(frac*fin);
range = [t(start) t(fin)];

% spatiotemporal plot after fraction of the timesteps
figure(2)
subplot(2,1,1)
imagesc(y(start:fin,1:n));

set(gca,'YDir','normal');
colorbar
ylabel('time')
xlabel('node number')
title('spatiotemporal dynamics of simple RM model network, \{k,\sigma\} = \{' + string(k) + ',' + string(sigma) + '\}')

subplot(2,1,2)
plot(t(start:fin), y(start:fin,[1, n+1]));
xlim(range)
title('Dynamics for node 1')
xlabel('Time')
ylabel('Population')
legend('Plants', 'Herbivores')

% figure(2)
% for i = 1:length(adj) %plots all n trajectories
% hold on
% plot(S(:,2*i-1),S(:,2*i))
% end
% xlabel('Plants')
% ylabel('Herbivores')
% end

timestamp = string(datestr(datetime('now')));
saveas(gcf,'plots/plot simple RM' + graph_type + timestamp,'jpeg')


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