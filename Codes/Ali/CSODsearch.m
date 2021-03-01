% looking for CSODs as described by Dutta & Benerjee, 2015
clear;clc;
n = 20;  % number of nodes
graph_type = "nonloc_chain";
pvec = 1:n/2; % local -> nonlocal -> global (n/2) coupling
sigvec = 2:0.5:10;
P = length(pvec);
S = length(sigvec);

k=0.5;

class_strings = ["synchronised oscillation" "death state" "CSOD" "amplitude chimera and death" "amplitude chimera" "quasiperiodic orbits or possible chaotic system (unknown)"];
preyclass_matrix = zeros(P,S);
predclass_matrix = zeros(P,S);

rng(1)
y0_vec = randi([0 0.4],1,2*n); 

t0 = 0;
tfinal = 10000;
counter = 0;
for ip = 1:P
    for is = 1:S
        disp(string(counter/(P+S)*100 + "% completed")); counter = counter+1;
        
        p = pvec(ip);
        sigma = sigvec(is);

        [t,y] = ode45(@(t,y) rm_modelsimple(t,y, k,sigma, graph_type,p), [t0,tfinal], y0_vec);

        % take tail of results
        fin = length(t);
        frac = 0.7;
        start = ceil(frac*fin);
        range = [t(start) t(fin)];

        prey = y(start:fin,1:n);
        pred = y(start:fin,n+1:end);
        time = t(start:fin);
    
        preyclass_matrix(ip,is) = find(class_strings == classify_x(prey));
        predclass_matrix(ip,is)  = find(class_strings == classify_x(pred));
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
xlabel('p-value')
ylabel('sig-value')

subplot(1,2,2)
pcolor(predclass_matrix)
title("Predator chimera classifications")
caxis([1 7])
% cb = colorbar;
% cb.TickLabels = class_strings;
xlabel('p-value')
ylabel('s-value')

%saveas(gcf,'classifier results/parameter space','jpeg')

% results: don't go through enough sigvals to see any CSDOD but pred goes
% from sync osc to CSOD when P goes from 4 -> 5 ( was for sigma in dutta?)
