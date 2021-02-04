% adapting Xinzhu's code here
% parameters from Dutta & Banerjee, 2015

function dy = rm_model(t,y)
    
    n = 0.5*length(y);
    dy = zeros(2*n,1); % (x y)T for n nodes
    
    r0 = 1;
    k0 = 1;
    m0 = 1;
    c0 =0.2;
    v0 = y(n+1:end);
    
    r = r0*ones(n,1);
    m = m0*ones(n,1);
    c = c0*ones(n,1);
    k = k0*ones(n,1);
    
    % A a lattice without self-loops
    % prob = 1 for a lattice
%     prob = 1;
%     A = rand(n,n)<prob; % graph with 90% links
%     A  = triu(A) - diag(diag(triu(A))) + triu(A)'; % flip upper triangle over to make symmetric
%     A = A - diag(diag(A)); % omit self-loops
%     A = [0 1 0 1; 1 0 1 0; 0 1 0 1; 1 0 1 0]; 4 x 4 lattice
    
    A = make_chain(n);
    
    % distances
    cols = ones(n,1)*v0';
    rows = v0*ones(1,n);
    V = cols - rows; % predator difference between nodes

    f = @(u,v) (r.*u).*(1-u./k)-(m.*u).*v./(1+u);
    g = @(u,v) -c.*v+(m.*u).*v./(1+u)+ A.*V*ones(n,1); % set v=1 because equidistant?

    u = y(1:n);
    v = y(n+1:2*n);
    dy = [f(u,v);g(u,v)];
end

