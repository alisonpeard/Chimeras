function [ A ] = gPlattice( n,p )
%produces a (2D) lattice-type graph adjacency matrix (shape depends on n)
% this ONLY works for n = perfect square (square grid)

if floor(sqrt(n))~=sqrt(n)
    display('n must be number of nodes^2');
    A=0;
    return
end

k=sqrt(n);
% basic B
A=diag(ones(1,k^2-1),+1)+diag(ones(1,k^2-k),+k);
A=A+A';
A=A;
for i=k+1:k:k^2-k+1
        A(i-1,i)=0;       % bottom "boundary" of the grid
        A(i,i-1)=0;     % top "boundary" of the grid
        
end
if p >= sqrt(length(A))
    display('p must smaller than sqrt(length(n))');
    A=0;
    return
end
if p==1
    A = A+diag(ones(length(A)-k+1,1),k-1);
    A = A+diag(ones(length(A)-k+1,1),-k+1);
    A = A+diag(ones(length(A)-k-1,1),k+1);
    A = A+diag(ones(length(A)-k-1,1),-k-1);
    for i=1:k:k^2-k+1
        A(i,i+k-1)=0;       % bottom "boundary" of the grid
        A(i+k-1,i)=0;     % top "boundary" of the grid
        
    end
else 
    for i = 1:p
        A = A+diag(ones(length(A)-i*sqrt(length(A))+1,1),i*sqrt(length(A))-1);
        A = A+diag(ones(length(A)-i*sqrt(length(A))+1,1),-i*sqrt(length(A))+1);
        A = A+diag(ones(length(A)-i*sqrt(length(A))-1,1),i*sqrt(length(A))+1);
        A = A+diag(ones(length(A)-i*sqrt(length(A))-1,1),-i*sqrt(length(A))-1);
        A = A+diag(ones(length(A)-i*sqrt(length(A)),1),i*sqrt(length(A)));
        A = A+diag(ones(length(A)-i*sqrt(length(A)),1),-i*sqrt(length(A)));
    end
    for n = 1:length(A)
        for m = 1:length(A)
            if A(n,m)>1
                A(n,m) = 1;
            end
        end
    end
    for i=1:k:k^2-k+1
        A(i,i+k-1)=0;       % bottom "boundary" of the grid
        A(i+k-1,i)=0;     % top "boundary" of the grid
        
    end
end

end