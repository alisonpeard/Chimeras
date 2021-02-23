% roughwork: classification function
% use to make plots later
n = 100;

% simulate chimera types to test 

% % simulate death state
% Y = ones(n,1)*rand(1,n);

% simulate random
% Y = rand(n,n); 

 % simulate sync / CSOD / amp_chim
Y = sin((1:n))'*ones(1,n);

%  % simulate CSOD
% rnd = rand(1,n);
% rnd =  find(rnd > 0.6);
% for i =1:length(rnd)
%     Y(:,rnd(i)) = zeros(n,1);
% end

% simulate amp_chim
ran1 = randi([1 n/2],1);
ran2 = randi([n/2 n],1);
size = ran2 - ran1 + 1;
eps = rand(2,size);
for i = 1:length(eps)
    Y(:, ran1 + i - 1) = eps(1,i) + eps(2,i).*Y(:, ran1 + i - 1);
end

class = classify(Y);
imagesc(Y)
title(class)
xlabel('node index')

saveas(gcf,'classifier results/cooked example' + class,'jpeg')