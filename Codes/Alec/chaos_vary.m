clear all;


%% fully connected

num = 3;
A = ones(num)-diag(diag(ones(num)));
G = graph(A);
plot(G)

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
num = 15;
A = adjacent(num);
G = graph(A);
plot(G)
Asparse = sparse(A);
L = laplac(Asparse);

%%
r = 1;
c = 0.2;
m = 1;

t0 = 0;
tfinal = 90000;
thresh = 10000;

y0 = rand(num*2,1)*0.4;

kvec = [1.6:0.2:5];
sigmavec = [1e-5,1e-4,1e-3,1e-2,0.1,1,10];

iter = 20;

S = cell(num,1);

for i = 1:length(kvec)
    k = kvec(i);
    disp(i);
    for j = 1:length(sigmavec)
        disp(j);
        sigma = sigmavec(j);
        func = @(t,y)RM_rhs_1(y,r,m,c,k,sigma,L,num);
        clear sol;

        [t,sol] = ode45(func,[t0 tfinal],y0);
        
        score_count = zeros(num,1);
        
        vec = sol(end-thresh:end,1:num);
        zvec = vec(10:10:end,:);
        
        for ind = 1:iter
        new_score = zeros(num,1);
        for column = 1:num
        new_score(column) = z1test(zvec(:,column));
        end
        
        score_count = score_count + new_score;
        disp(ind);
        
        end
        
        score_count = score_count/iter;
        
       if score_count(1)>0.5 && score_count(1)<0.7
        score_count = zeros(num,1);
           opts = odeset('RelTol',1e-6,'AbsTol',1e-9);
           [t,sol] = ode45(func,[t0 tfinal],y0,opts);
        vec = sol(end-thresh:end,1:num);
        zvec = vec(40:40:end,:);
        for ind = 1:iter
            
        
        new_score = zeros(num,1);
        for column = 1:num
        new_score(column) = z1test(zvec(:,column));
        end

        
        score_count = score_count + new_score;
            
         
        disp(ind);
        
        end
           
        score_count = score_count/iter;  
        
       end
        for c1 = 1:num
           a = S{c1};
           a(end+1) = score_count(c1);
           S{c1} = a;
            
        end
    end
    
end

%%

for j = 1:length(S)
   s = reshape(S{j},length(sigmavec),length(kvec));
   s = flip(transpose(s));
   
   figure(j)
   imagesc(s)
    
end
