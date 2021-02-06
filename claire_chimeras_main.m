% Modifications on Xinzhu and Ali's code (add graph structure types, directly accept graph A as ODEfunc
% argument in rm_model, plot both predator and prey dynamics on same scale)

%set desired number of nodes
n = 30;
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
A = make_chain(n);

%4. Path graph (node n not connected to node 1, unlike chain)
%A = make_path(n);


%%

G = graph(A,'omitselfloops');
plot(G);
title("graph size n = " + string(n));
hold off;

% start code
t0 = 0;
tfinal = 10000;

% initial conditions
y0_vec = randi([0 5],1,2*n);

[t,y] = ode45(@(t,y) rm_model_c(t,y,A),[t0,tfinal],y0_vec);

%for fig 2 and 3: figure out how to make y time labels 5000 - 10000

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

for i = 1:n
    A = z1test(y(5000:100:tfinal,i)); %this isn't really working yet
end
 %figure(4) %This is a bit of a mess for all the nodes, better to just
 %choose a subset later
%for i = 1:n
  %   subplot(1,n,i)
   %  plot(t(5000:6000),y(5000:6000,i),t(5000:6000),y(5000:6000,i+1))
    % ylabel("Population size")
    % xlabel("Time")
    % title("Node " + string(i))
%end
 %legend('Prey','Predator')
% hold off;

 %figure(4)
% for i=1:100:tfinal
 %    imagesc(y(i,1:n));
 %    colorbar;
  %   caxis([0 5]);
  %   title("time = " + string(i))
  %   pause(.001)
 %end

