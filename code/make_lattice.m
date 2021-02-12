% lattice function
% function A = make_lattice(n)
%end
% https://brilliant.org/discussions/thread/adjacency-matrix-for-a-square-lattice/

n = 10;
adj_vec = zeros(1,n^2);

for k = 1:n^2
    if mod(k/n,1) ~= 0 % check n doesn't divide k
        adj_vec(k+1) = 1;
    end
    
    if mod((k-1)/n,1) ~= 0 % check n doesn't divide k
        adj_vec(k-1) = 1;
    end
    
    if (k + n) <= n^2 % check n doesn't divide k
        adj_vec(k+n) = 1;
    end
    
    if (k - n) > 0 % check n doesn't divide k
        adj_vec(k-n) = 1;
    end
end

adj_vec
