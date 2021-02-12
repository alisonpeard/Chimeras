function A = make_chain(n, P)

    if ~exist('P','var')
        P=1;
    end

    A = diag(ones(n-1,1),1);
    A = A + diag(ones(n-1,1),-1);
    A(n,1) = 1;
    A(1,n) = 1;
    
end


A = zeros(n,n);
A = A + diag(ones(n-i,i),i)
for i = 1:3
    diag(ones(n-i,i),i)
end