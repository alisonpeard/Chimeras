% adapting Xinzhu's code here
% parameters from Dutta & Banerjee, 2015

function dy = rm_model(t,y)

    dy = zeros(6,1); % (x,y) for 3 nodes
    
    r0 = 0.5;
    k0 = 0.5;
    m0 = 1;
    c0 =0.2;
    n = 3;
    
    r = r0*ones(n,1);
    m = m0*ones(n,1);
    c = c0*ones(n,1);
    k = k0*ones(n,1);
    
    A = [0 1 1; 1 0 1; 1 1 0];
    %L = [-1,1,0;1,-2,1;0,1,-1 % lengths?

    f = @(u,v) (r.*u).*(1-u./k)-(m.*u).*v./(1+u);
    g = @(u,v) -c.*v+(m.*u).*v./(1+u)+A*ones(n,1); % set v=1 because equidistant?

    u = y(1:n);
    v = y(n+1:2*n);
    dy = [f(u,v);g(u,v)];
end

