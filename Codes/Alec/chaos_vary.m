clear all;


%% fully connected

num = 5;
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
%%
r = 1;
c = 0.2;
m = 1;

t0 = 0;
tfinal = 90000;
thresh = 10000;

y0 = rand(num*2,1)*0.4;

kvec = [1.6:0.2:5];
sigmavec = [1e-5,1e-4,1e-3,1e-2,1e-1,1,10];

iter = 20;

S1 = zeros(length(kvec),length(sigmavec));
S2 = S1;
S3 = S1;
S4 = S1;
S5 = S1;
S6 = S1;
S7 = S1;
S8 = S1;
S9 = S1;
S10 = S1;

for i = 1:length(kvec)
    k = kvec(i);
    disp(i);
    for j = 1:length(sigmavec)
        disp(j);
        sigma = sigmavec(j);
        func = @(t,y)RM_rhs_1(y,r,m,c,k,sigma,L,num);
        clear sol;

        [t,sol] = ode45(func,[t0 tfinal],y0);
        
        score_count1 = 0;
        score_count2 = 0;
        score_count3 = 0;
        score_count4 = 0;
        score_count5 = 0;
        score_count6 = 0;
        score_count7 = 0;
        score_count8 = 0;
        score_count9 = 0;
        score_count10 = 0;
        
        vec = sol(end-thresh:end,1:num);
        zvec = vec(10:10:end,:);
        
        for ind = 1:iter
        
        score1 = z1test(zvec(:,1));
        score2 = z1test(zvec(:,2));
        score3 = z1test(zvec(:,3));
        score4 = z1test(zvec(:,4));
        score5 = z1test(zvec(:,5));
        %score6 = z1test(zvec(:,6));
        %score7 = z1test(zvec(:,7));
        %score8 = z1test(zvec(:,8));
        %score9 = z1test(zvec(:,9));
        %score10 = z1test(zvec(:,10));

        
        score_count1 = score_count1+score1;
        score_count2 = score_count2+score2;
        score_count3 = score_count3+score3;
        score_count4 = score_count4+score4;
        score_count5 = score_count5+score5;
        %score_count6 = score_count6+score6;
        %score_count7 = score_count7+score7;
        %score_count8 = score_count8+score8;            
        %score_count9 = score_count9+score9;
        %score_count10 = score_count10+score10; 
        
        disp(ind);
        
        end
        
        score1 = score_count1/iter;
        score2 = score_count2/iter;
        score3 = score_count3/iter;
        score4 = score_count4/iter;
        score5 = score_count5/iter;
        %score6 = score_count6/iter;
        %score7 = score_count7/iter;
        %score8 = score_count8/iter;
        %score9 = score_count9/iter;
        %score10 = score_count10/iter;       
        
       if score1>0.5 && score1<0.7
        score_count1 = 0;
        score_count2 = 0;
        score_count3 = 0;
        score_count4 = 0;
        score_count5 = 0;
        %score_count6 = 0;
        %score_count7 = 0;
        %score_count8 = 0;
        %score_count9 = 0;
        %score_count10 = 0;
           opts = odeset('RelTol',1e-6,'AbsTol',1e-9);
           [t,sol] = ode45(func,[t0 tfinal],y0,opts);
        vec = sol(end-thresh:end,1:num);
        zvec = vec(40:40:end,:);
        for ind = 1:iter
            
        
        score1 = z1test(zvec(:,1));
        score2 = z1test(zvec(:,2));
        score3 = z1test(zvec(:,3));
        score4 = z1test(zvec(:,4));
        score5 = z1test(zvec(:,5));
        %score6 = z1test(zvec(:,6));
        %score7 = z1test(zvec(:,7));
        %score8 = z1test(zvec(:,8));
        %score9 = z1test(zvec(:,9));
        %score10 = z1test(zvec(:,10));

        
        score_count1 = score_count1+score1;
        score_count2 = score_count2+score2;
        score_count3 = score_count3+score3;
        score_count4 = score_count4+score4;
        score_count5 = score_count5+score5;
        %score_count6 = score_count6+score6;
        %score_count7 = score_count7+score7;
        %score_count8 = score_count8+score8;            
        %score_count9 = score_count9+score9;
        %score_count10 = score_count10+score10; 
            
         
        disp(ind);
        
        end
           
        score1 = score_count1/iter;
        score2 = score_count2/iter;
        score3 = score_count3/iter;
        score4 = score_count4/iter;
        score5 = score_count5/iter;
        %score6 = score_count6/iter;
        %score7 = score_count7/iter;
        %score8 = score_count8/iter;
        %score9 = score_count9/iter;
        %score10 = score_count10/iter;   
        
        end
        S1(i,j) = score1;
        S2(i,j) = score2;
        S3(i,j) = score3;
        S4(i,j) = score4;
        S5(i,j) = score5;
        %S6(i,j) = score6;
        %S7(i,j) = score7;
        %S8(i,j) = score8;
        %S9(i,j) = score9;
        %S10(i,j) = score10;
    end
    
end
