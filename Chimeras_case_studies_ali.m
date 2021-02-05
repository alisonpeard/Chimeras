% scaled up Xinzhu's code 
% fix plots

n = 100;

% visualise graph
figure(1)

% 1. graph with 90% links
%A = rand(n,n)<0.9; 
%A  = triu(A) - diag(diag(triu(A))) + triu(A)'; % flip upper triangle over to make symmetric

% 2. chain graph
A = make_chain(n);
G = graph(A,'omitselfloops');
plot(G);
title("graph size n = " + string(n));
hold off;

% start code
t0 = 0;
tfinal = 10000;

% initial conditions
y0_vec = randi([0 5],1,2*n); 

[t,y] = ode45('rm_model_ali',[t0,tfinal],y0_vec);

% figure(2)
% for i = 1:n
%     subplot(1,n,i)
%     plot(t,y(:,i),t,y(:,i+1))
%     ylabel("pred/prey")
%     xlabel("time")
%     title("Node " + string(i))
% end
% hold off;

% overwriting figure 1 for some reason

% figure(3)
% for i=1:100:tfinal
%     imagesc(y(i,1:n));
%     %colorbar;
%     %caxis([0 5]);
%     title("time = " + string(i))
%     pause(.001)
% end

imagesc(y(5000:tfinal,1:n));
colorbar

