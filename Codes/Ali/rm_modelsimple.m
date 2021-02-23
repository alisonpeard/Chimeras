function dy = rm_modelsimple(t,y,k, sigma, graph_type, P)
% u = prey, v = predator
    
    n = 0.5*length(y);
    dy = zeros(2*n,1); % (x y)T for n nodes
    
    r = 1;
    m = 1;
    c = 0.2;
    B = 1;
    beta = 1;
    v0 = y(n+1:end);
    
    % define network graph
    if graph_type == "chain"
        A = make_chain(n);
    elseif graph_type == "nonloc_chain"
        A = make_chain(n,P);
    elseif graph_type == "lattice"
        A = glattice(n);
    elseif graph_type == "rand"
        prob = P;
        A = rand(n,n)<prob;
        A  = triu(A) - diag(diag(triu(A))) + triu(A)'; % flip upper triangle over to make symmetric
        A = A - diag(diag(A)); % omit self-loops
    end
    A = sparse(A);

    % distances
    cols = ones(n,1)*v0';
    rows = v0*ones(1,n);
    V = cols - rows; % predator difference between nodes
    V = sparse(V);

    f = @(u,v) (r.*u).*(1-u./k)-(m.*u).*v./(B+u);
    g = @(u,v) -c.*v + beta.*(m.*u).*v./(B+u)+ sigma.*A.*V*ones(n,1); 

    u = y(1:n);
    v = y(n+1:2*n);
    dy = [f(u,v);g(u,v)];
    
end

