function A = lattice(n)

% creates as nxn square lattice matrix

A = zeros(n^2);
for i = 1:n^2
    
    if i < n^2 && mod(i,n) ~= 0
        A(i,i+1) = 1;
    end
    
    if i > 1 && mod(i,n) ~= 1
        A(i,i-1)= 1;
    end
    
    if i <= n^2-n
        A(i,i+n) = 1;
    end
    if i > n
        A(i,i-n) = 1;
    end
    
    
end



end
