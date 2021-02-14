% Exploring Rosenzweig-Macarthur predator-prey wrt initial conditions
% how to change y-axis on imagesc

n = 2;
graph_types = ["chain","nonloc_chain","lattice","rand"];
graph_type = graph_types(1);

t0 = 0;
tfinal = 10000;

% set initial conditions with small pertubation
y01 = randi([0 5],1,n);
y02 = u0 + 1e-10*rand;
y0_vec = [y01(1) y02(2) y01(2) y02(2)]; 

%% simple RM model
k = 2; sigma = 1e-1;
[t,y] = ode45(@(t,y) rm_modelsimple(t,y, k,sigma, graph_type), [t0,tfinal], y0_vec);

% Take tail of results
ifin = length(t);
frac = 0.7;
istart = ceil(frac*ifin);
lentail = 0.1*ifin;

i = istart;
tail = ceil(i - lentail);
plot(y(tail:i,1),y(tail:i,3))

% comet() ?
for i = istart:ifin
    %plot(y(i,1),y(i,3),'or','MarkerSize',5,'MarkerFaceColor','r');
    plot(y(i-tail:i,1),y(i-tail:i,3))
    %plot(y(i,2),y(i,4),'or','MarkerSize',5,'MarkerFaceColor','r');
    pause(0.001)
end
