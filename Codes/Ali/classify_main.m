% Simulate different chimera types and test classifier
clear; clc;
n = 100;

%% simulate chimera types to test 

% % 1(a). simulate chimera death
% Y = ones(n,1)*rand(1,n);

% % 1(b). simulate oscillation death
% Y = 1e-4.*ones(n,1)*rand(1,n);


% %  % 2. simulate random (totally incoheren)
% % Y = rand(n,n); 
% 
 % 3. simulate sync / CSOD / amp_chim
 % Need to uncomment next line for all other simulations
Y = sin((1:n))'*ones(1,n);

% %  % 3(b) simulate CSOD
% rnd = rand(1,n);
% rnd =  find(rnd > 0.8);
% for i =1:length(rnd)
%     Y(:,rnd(i)) = zeros(n,1);
% end
% 
%  % 3(c) simulate amp_chim
ran1 = randi([1 n/2],1);
ran2 = randi([n/2 n],1);
size = ran2 - ran1 + 1;
eps = rand(2,size);
for i = 1:size
    shift = ceil(0.1*sin(4*pi*i/size));     % add small sinusoidal shift
    Y(:, ran1 + i - 1) = eps(1,i) + eps(2,i).*Y(:, ran1 + i - 1);
    Y(:, ran1 + i - 1) = circshift(Y(:, ran1 + i - 1), shift);
end
% 
% % 3(c)(ii) simulate amp chimera and death
rnd = rand(1,n);
rnd =  find(rnd > 0.6);
for i =1:length(rnd)
    Y(:,rnd(i)) = zeros(n,1);
end

%%

% subplot(1,2,1)
% class = classify(Y);
% imagesc(Y)
% title(class)
% xlabel('node index')

classx = classify_x(Y);
imagesc(Y)
title(classx,'fontweight','bold','fontsize',16);
xlabel('node index','fontsize',16);
ylabel('Time','fontsize',16);

saveas(gcf,'classifier results/' + classx,'png')