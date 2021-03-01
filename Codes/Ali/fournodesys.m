% 4 node system analysis
% steady states under different topologies local -> global coupling
% using local/nonlocal/global definitions as in Dutta & Banerjee 2015

%% choose graph type
clear;clc;

n = 4;  % number of nodes
graph_types = ["chain","nonloc_chain","lattice","rand"];
graph_type = graph_types(2);

t0 = 0;
tfinal = 10000;

%parameters
sigma = 1.7;
k = 2.5;

rng(1)
y0_vec = randi([0 5],1,2*n);

ploc = 1;
pglob = n/2;
ngraphs = 2;
if n > 5
    pnloc = ceil(n/4);
    Anloc = make_chain(n,pnloc);
    ngraphs = 3;
end


%% visualise graph

figure(1)
Aloc = make_chain(n,ploc);
Aglob = make_chain(n,pglob);

% plot graph
subplot(1,ngraphs,1)
Gloc = graph(Aloc,'omitselfloops');
plot(Gloc);
title(string(n) + " nodes with local coupling");


subplot(1,ngraphs,2)
Gglob = graph(Aglob,'omitselfloops');
plot(Gglob);
title(n + " nodes with global coupling");

if n>5
    subplot(1,ngraphs,ngraphs)
    Gnloc = graph(Anloc,'omitselfloops');
    plot(Gnloc);
    title(n + " nodes with nonlocal coupling");
end
hold off;

%% solve simple RM model using ode 45

[tloc,yloc] = ode45(@(t,y) rm_modelsimple(t,y, k,sigma, graph_type,ploc), [t0,tfinal], y0_vec);
if n > 5
    [tnloc,ynloc] = ode45(@(t,y) rm_modelsimple(t,y, k,sigma, graph_type,pnloc), [t0,tfinal], y0_vec);
end
[tgl,ygl] = ode45(@(t,y) rm_modelsimple(t,y, k,sigma, graph_type,pglob), [t0,tfinal], y0_vec);

% take tail of results
fin = min([length(tloc) length(tgl)]);
frac = 0.7;
start = ceil(frac*fin);
%range = [t(start) t(fin)];

prey_loc = yloc(start:fin,1:n);
pred_loc = yloc(start:fin,n+1:end);
tloc = tloc(start:fin);

prey_gl = ygl(start:fin,1:n);
pred_gl = ygl(start:fin,n+1:end);
tgl = tgl(start:fin);

figure(2)
subplot(2,2,1)
for ni = 1:n
    semilogy(tloc,prey_loc(:,ni));
    title("prey density in locally connected network")
    hold on;
end

subplot(2,2,2)
for ni = 1:n
    semilogy(tloc,pred_loc(:,ni));
    title("predator density in locally connected network")
    hold on;
end

subplot(2,2,3)
imagesc(prey_loc)

subplot(2,2,4)
imagesc(pred_loc)

figure(3)
subplot(2,2,1)
for ni = 1:n
    semilogy(tloc,prey_gl(:,ni));
    title("prey density in globally connected network")
    hold on;
end

subplot(2,2,2)
for ni = 1:n
    semilogy(tloc,pred_gl(:,ni));
    title("predator density in globally connected network")
    hold on;
end

subplot(2,2,3)
imagesc(prey_gl)

subplot(2,2,4)
imagesc(pred_gl)