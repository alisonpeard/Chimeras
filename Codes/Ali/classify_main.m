% Simulate different chimera types and test classifier
clear; clc;
n = 100;

%% simulate chimera types to test 

% 1. simulate death state
Y = ones(n,1)*rand(1,n);

%  % 2. simulate random (chaos-like)
% Y = rand(n,n); 

% %  3 simulate sync / CSOD / amp_chim
% % Need to uncomment next line for all other simulations
% Y = sin((1:n))'*ones(1,n);

%  % 3(b) simulate CSOD
% rnd = rand(1,n);
% rnd =  find(rnd > 0.6);
% for i =1:length(rnd)
%     Y(:,rnd(i)) = zeros(n,1);
% end

% % 3(c) simulate amp_chim
% ran1 = randi([1 n/2],1);
% ran2 = randi([n/2 n],1);
% size = ran2 - ran1 + 1;
% eps = rand(2,size);
% for i = 1:length(eps)
%     Y(:, ran1 + i - 1) = eps(1,i) + eps(2,i).*Y(:, ran1 + i - 1);
% end

%  % 3(d) simulate amp chimera and death
% rnd = rand(1,n);
% rnd =  find(rnd > 0.6);
% for i =1:length(rnd)
%     Y(:,rnd(i)) = zeros(n,1);
% end

%%

% subplot(1,2,1)
% class = classify(Y);
% imagesc(Y)
% title(class)
% xlabel('node index')

classx = classify_x(Y);
imagesc(Y)
title(classx)
xlabel('node index')

saveas(gcf,'classifier results/cooked example: ' + classx,'jpeg')