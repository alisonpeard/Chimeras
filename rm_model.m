% adapting Xinzhu's code here

function dy = rm_model(t,y)
    dy = zeros(6,1);
    r = [1;1;1];
    m = [1;2;2];
    c = [0.2;2;2];
    k = [1;4;4];
    %A = [0,1,0;1,1,1;0,1,1];
    L = [-1,1,0;1,-2,1;0,1,-1];

    f = @(u,v) (r.*u).*(1-u./k)-(m.*u).*v./(1+u);
    g = @(u,v) -c.*v+(m.*u).*v./(1+u)+L*v;

    u = y(1:3);
    v = y(4:6);
    dy = [f(u,v);g(u,v)];
end

