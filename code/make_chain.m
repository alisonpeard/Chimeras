function A = make_chain(n, P)
% P = 1 for local coupling, P=n/2 for global coupling
% P=(0,n/2) for nonlocal coupling
% nonlocal coupling to create graph in Dutta and Banerjee (2015) paper

    if ~exist('P','var')
        P=1;
    end
    
    if P>n/2
        error("coupling range must be less than N/2 = " + string(n/2));
    end

    A = zeros(n,n);
    for i = 1:P
        A = A + diag(ones(n-i,1),i);
        A = A + diag(ones(n-i,1),-i);
        A = A + diag(ones(i,1),n-i);
        A = A + diag(ones(i,1),i-n);
    end
    
end

