% chimera-type by k and sigma plotter
%% choose graph type
clear;clc;

% nonlocal coupling with P neighbours of 100 nodes
n = 20;
graph_types = ["chain","nonloc_chain","lattice","rand"];
graph_type = graph_types(2);
P = 2;

t0 = 0;
tfinal = 10000;

y0_vec = randi([0 0.4],1,2*n); 

%% loop
kvec = 0.5:0.5:5; 
sigpow = -6:-1;
sigvec = [10.^sigpow 0.5 1 1.5 2];

class_strings = ["synchronised oscillation" "death state" "CSOD" "amplitude chimera and death" "amplitude chimera" "quasiperiodic orbits or possible chaotic system (unknown)"];
preyclass_matrix = zeros(10,10);
predclass_matrix = zeros(10,10);

% loop through k and sigma
counter = 1;
for i = 1:10
    for j = 1:10
        disp(string(counter + "% completed")); counter = counter+1;
        k = kvec(i);
        sigma = sigvec(j);

        [t,y] = ode45(@(t,y) rm_modelsimple(t,y, k,sigma, graph_type,P), [t0,tfinal], y0_vec);


        % take tail of results
        fin = length(t);
        frac = 0.7;
        start = ceil(frac*fin);
        range = [t(start) t(fin)];

        prey = y(start:fin,1:n);
        pred = y(start:fin,n+1:end);
        time = t(start:fin);
    
        preyclass_matrix(i,j) = find(class_strings == classify_x(prey));
        predclass_matrix(i,j)  = find(class_strings == classify_x(pred));
    end
end

%%
figure(1)
% this needs improving
subplot(1,2,1)
pcolor(preyclass_matrix)
caxis([1 7])
% cb = colorbar;
% cb.TickLabels = class_strings;
title("Prey chimera classifications")
xlabel('sigma-value')
ylabel('k-value')

subplot(1,2,2)
pcolor(predclass_matrix)
title("Predator chimera classifications")
caxis([1 7])
% cb = colorbar;
% cb.TickLabels = class_strings;
xlabel('sigma-value')
ylabel('k-value')

saveas(gcf,'classifier results/parameter space','jpeg')