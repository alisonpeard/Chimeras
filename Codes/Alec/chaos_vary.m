clear all;


% fully connected

num = 3;
A = ones(num)-diag(diag(ones(num)));
G = graph(A);
%plot(G)

Asparse = sparse(A);
L = laplac(Asparse);
%%
num = 5;
if num == 5
    A = make_chain(num);
else
    A = lattice(num/2);
end
L = laplac(A);

%% random
clear all;
num = 15;
A = adjacent(num);
G = graph(A);
plot(G)
Asparse = sparse(A);
L = laplac(Asparse);

%%
tic
r = 1;
c = 0.2;
m = 1;

t0 = 0;
tfinal = 20000;
tfinal1 = 100000;
thresh = 0;

y0 = rand(num*2,1)*0.4;

kvec = [1.8,3,4,5,6];
sigmavec = [1e-5,1e-4,1e-3,1e-2,0.1,1,10];

iter = 5;

%opts = odeset('RelTol',1e-6,'AbsTol',1e-9);
S = zeros(length(kvec),length(sigmavec),num);
opts = odeset('RelTol',1e-6,'AbsTol',1e-9);
opts1 = odeset('RelTol',1e-6,'AbsTol',1e-9);
%opts1 = odeset('RelTol',1e-5,'AbsTol',1e-5);
J = length(sigmavec);
parfor i = 1:length(kvec)
    k = kvec(i);
    disp(i);
    for j = 1:J
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
        s_rate = 500;
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
        
       
        S(i,j,:) = score_count;
    end
    
end

toc
%%

for j = 1:num
   s = flip(S(:,:,j));
   
   figure(j)
   imagesc(s)
   
    
end
