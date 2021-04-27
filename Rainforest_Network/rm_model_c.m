% adapting Xinzhu's and Ali's code here
% parameters from Dutta & Banerjee, 2015

function dy = rm_model_c(t,y,k,sigma,A)
    
    n = 0.5*length(y);
    dy = zeros(2*n,1); % (x y)T for n nodes
   
    r = 1;
    %k = 1;
    m = 1;
    c = 0.2;
   % sigma = 1.7; %can also incorporate time dependence here with t
    B = 1; %0.16<--prev value;
    beta = 1; %0.5<--prev value;
    v0 = y(n+1:end);
    
    %FOR RAINFOREST - lowers migration between clusters
    A = rainforest_migration(A,t);
    
    A = sparse(A); %make sure this setup matches main function graph structure
    
    % distances
    cols = ones(n,1)*v0';
    rows = v0*ones(1,n);
    V = cols - rows; % predator difference between nodes
    V = sparse(V);

    f = @(u,v) (r.*u).*(1-(u./k'))-(m.*u).*v./(B+u);
    g = @(u,v) -c.*v + beta.*(m.*u).*v./(B+u)+ sigma.*A.*V*ones(n,1); 

    u = y(1:n);
    v = y(n+1:2*n);
    dy = [f(u,v);g(u,v)];
    
end