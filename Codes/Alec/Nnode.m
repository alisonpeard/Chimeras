
%% random
num = 20;
A = adjacent(num);
G = graph(A);
plot(G)
Asparse = sparse(A);
L = laplac(Asparse);
%% fully connected
num = 50;
A = ones(num)-diag(diag(ones(num)));
G = graph(A);
plot(G)

Asparse = sparse(A);
L = laplac(Asparse);

%% chain
clear all;
num = 100;
A = spdiags([ones(num,1),zeros(num,1),ones(num,1)],[-1,0,1],num,num);
A(1,end) = 1;
A(end,1) = 1;
G = graph(A);
plot(G)

Asparse = sparse(A);
L = laplac(Asparse);

%% lattice

num = 4;
n = sqrt(num);
A = lattice(n);
L = laplac(A); 

%%
clear V;
clear H;
r = 0.5;
c = 0.2;
m = 1;

t0 = 0;
tfinal = 10000;
iter = 10;
kvec = 0.5;
sigmavec = [1.7];
bvec = [0.16];
beta = 0.5;

for i = 1:1
y0 = rand(num*2,1)*5;
    i
k = kvec;
sigma = sigmavec;
b = bvec;

func = @(t,y)RM_rhs(y,r,m,c,k,beta,b,sigma,L,num);
[t,y] = ode45(func,[t0,tfinal],y0);

Veg = y(:,1:num);
Herb = y(:,num+1:end);

V{i} = Veg;
H{i} = Herb;
end
%%
clf;
count = 1;
for i = 1:size(V,2)

        
       veg = V{i};
       veg = flipud(veg);
       
       figure(count)
       imagesc(veg)
       colorbar;
       caxis([0 0.3]);
       count = count+1;
    
end

%%
clf;
count = 1;
for i = 1:size(H,2)
        
       herb = H{i};
       herb= flipud(herb);
       
       figure(count)
       imagesc(herb)
       colorbar;
       caxis([0 0.5]); 
       count = count+1;

end
    %%
for i = 1:size(y,1)
    
    vec = V(i,num+1:end);
    %len = sqrt(num);
    %vec = reshape(vec,len,len);
    imagesc(vec)
    drawnow
    gcf
    
end















