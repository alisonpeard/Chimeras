function [ B ] = glattice( n )
%produces a (2D) lattice-type graph adjacency matrix (shape depends on n)
% this ONLY works for n = perfect square (square grid)

if floor(sqrt(n))~=sqrt(n)
    display('n must be number of nodes^2');
    B=0;
    return
end

k=sqrt(n);
% basic B
B=diag(ones(1,k^2-1),+1);%+diag(ones(1,k^2-k),+k);
B=B+B';
B=B;
for i=k+1:k:k^2-k+1
        B(i-1,i)=0;       % bottom "boundary" of the grid
        B(i,i-1)=0;     % top "boundary" of the grid
        
end

% sort out "boundaries"

    
% for i=2:k-1
%         % left "boundary"
%         % right "boundary"
%     
% end


end