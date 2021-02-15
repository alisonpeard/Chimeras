function [ A ] = gcycle( n )
% single-cycle adjacency matrix: each node is connected to itself, node
% before, node after + nodes 1 and n are connected
A=diag(ones(n-1,1),1)+diag(ones(n-1,1),-1);
A(1,n)=1;       A(n,1)=1;
end



