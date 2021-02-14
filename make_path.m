function A = make_path(n)
% a single-chain adjacency matrix; each node is connected only to itself,
% node before+node after
A=diag(ones(n-1,1),1)+diag(ones(n-1,1),-1);
end