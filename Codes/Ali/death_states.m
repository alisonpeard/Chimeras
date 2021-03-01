% simulate CD and OD
clear; clc;
n = 100;

%% simulate chimera types to test 

% 1. simulate fully incoherent death state
Yr = ones(n,1)*rand(1,n);

% 2. simulate fully coherent death state, using a sine wave to make
% correlated entries again
Yc = ones(n,1)*(1 + 0.1.*sin(4*pi.*(1:n)/n));
subplot(1,2,1)
imagesc(Yc)
title("Oscillation Death State")

% 3. randomly assign either coherent or incoherent death state to system
% nodes
Y = Yc;
inds = randi([1,n],4);
inds = sort(inds);

Y(:,1:inds(1)) = Yr(:,1:inds(1));
Y(:,inds(2):inds(3)) = Yr(:,inds(2):inds(3));
Y(:,inds(4):end) = Yr(:,inds(4):end);

subplot(1,2,2)
imagesc(Y)
for i = 1:4
    xline(inds(i),'r','LineWidth',2);
end

title("Chimera Death State");

