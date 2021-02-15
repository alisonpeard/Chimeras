function [ A ] = gPcycle(n,p)
if p > n/2
    disp('p must smaller or equal than n/2');
    A=0;
    return
end
A = zeros(n);
if p == n/2
    A = ones(n)-eye(n);
elseif p == 1 
    A = gcycle(n);
else 
    for i = 1:p
    A = A+diag(ones(n-i,1),i)+diag(ones(n-i,1),-i);
    j = n-i;
    A = A+diag(ones(n-j,1),j)+diag(ones(n-j,1),-j);
    end
end
end