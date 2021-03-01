clear all;


% fully connected

num = 4;
A = ones(num)-diag(diag(ones(num)));
G = graph(A);
plot(G)

Asparse = sparse(A);
L = laplac(Asparse);
%%
clear all;
num = 4;
if num == 5
    A = make_chain(num);
else
    A = lattice(num/2);
end
Asparse = sparse(A);
L = laplac(Asparse);

%% random
clear all;
num = 30;
A = adjacent(num);
G = graph(A);
plot(G)
Asparse = sparse(A);
L = laplac(Asparse);

%%
tic
rvec = 1;
c = 0.2;
m = 1;

t0 = 0;
tfinal = 120000;
tfinal1 = 120000;
thresh = 0.2;

y0 = rand(num*2,1)*0.4;

kvec = [1.8:0.4:6];
sigmavec = [1e-5,1e-4,1e-3,1e-2,0.1,1];

iter = 5;

%opts = odeset('RelTol',1e-6,'AbsTol',1e-9);
S = zeros(length(kvec),length(sigmavec),length(rvec),num);
opts = odeset('RelTol',1e-5,'AbsTol',1e-5);
opts1 = odeset('RelTol',1e-9,'AbsTol',1e-9);
%opts1 = odeset('RelTol',1e-5,'AbsTol',1e-5);
J = length(sigmavec);
R = length(rvec);
parfor i = 1:length(kvec)
    k = kvec(i);
    disp(i);
    for j = 1:J
        for loop = 1:R
            r = rvec(loop);
        disp(j);
        sigma = sigmavec(j);
        func = @(t,y)RM_rhs_1(y,r,m,c,k,sigma,L,num);
        %Tfin = round(tfinal*thresh);
        [t,sol] = ode45(func,[t0 tfinal],y0,opts);
        
        [t,sol] = ode45(func,[tfinal:0.1:tfinal+tfinal1],sol(end,:),opts1);
        score_count = zeros(num,1);
        
        Len = length(sol);
        if thresh == 0
            vec = sol(:,1:num);
        else
        thresh_ind = round((1-thresh)*Len);
        % column of data (1 = prey in node 1)
        vec = sol(end-thresh_ind:end,1:num);
        end
        s_rate = 1000;
        zvec = vec(s_rate:s_rate:end,1:num);
        
        for ind = 1:iter
        new_score = zeros(num,1);
        for column = 1:num
        new_score(column) = z1test(zvec(:,column));
        end
        
        score_count = score_count + new_score;
        disp(ind);
        
        end
        
        score_count = score_count/iter;
        
       
        S(i,j,loop,:) = score_count;
        end
    end
    
end

toc
%%

for j = 1:num
   s = flip(S(:,:,j));
   
   figure(j)
   imagesc(s)
   caxis([0 1])
   yticks(1:2:length(kvec))
   xticklabels({'10^{-6}','10^{-5}','10^{-4}','0.001','0.01','0.1','1','10'})
   yticklabels({'7.6','6.8','6','5.2','4.4','3.6','2.8','2'});
   xlabel('\sigma')
   ylabel('k')
   title(['0-1 Test - Node ',num2str(j)]);
   colorbar;
   set(gca,'fontsize',24)
end

%%


for j = 1:size(S,3)
   
   figure(j)
   s = flip(S(:,:,j,1));
   imagesc(s)
   caxis([0 1])
   
    
end