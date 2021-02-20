clear all;

num = 3;
if num == 3
    A = make_chain(num);
else
    A = lattice(num/2);
end
L = laplac(A);

r = 1;
c = 0.2;
m = 1;

t0 = 0;
tfinal = 80000;
thresh = 10000;

y0 = rand(num*2,1)*0.4;

kvec = 1.6;
sigmavec = 0.1;

iter = 10;

S1 = zeros(length(kvec),length(sigmavec));
S2 = S1;
S3 = S1;
S4 = S1;

for i = 1:length(kvec)
    k = kvec(i);
    disp(i);
    for j = 1:length(sigmavec)
        disp(j);
        sigma = sigmavec(j);
        func = @(t,y)RM_rhs_1(y,r,m,c,k,sigma,L,num);
        score_count1 = 0;
        score_count2 = 0;
        score_count3 = 0;
        score_count4 = 0;
        clear sol;
        for ind = 1:iter
        [t,sol] = ode45(func,[t0 tfinal],y0);
        
        vec = sol(end-thresh:end,1:num);
        zvec = vec(10:10:end,:);
        score1 = z1test(zvec(:,1));
        score2 = z1test(zvec(:,2));
        score3 = z1test(zvec(:,3));
        score4 = z1test(zvec(:,4));
        score_count1 = score_count1+score1;
        score_count2 = score_count2+score2;
        score_count3 = score_count3+score3;
        score_count4 = score_count4+score4;
        disp(ind);
        
        end
        
        score1 = score_count1/iter;
        score2 = score_count2/iter;
        score3 = score_count3/iter;
        score4 = score_count4/iter;
        
        S1(i,j) = score1;
        S2(i,j) = score2;
        S3(i,j) = score3;
        S4(i,j) = score4;
    end
    
end
