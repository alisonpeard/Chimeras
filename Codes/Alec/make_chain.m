
function A = make_chain(n)
    A = diag(ones(n-1,1),1);
    A = A + diag(ones(n-1,1),-1);
    A(n,1) = 1;
    A(1,n) = 1;
    
end