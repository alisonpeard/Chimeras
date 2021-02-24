%Build rainforest network model 
function A = make_rainforest
A = zeros(11,11);
%inter-cluster connections
A(1,1:4) = 1;
A(2,1:4) = 1;
A(3,1:4) = 1;
A(4,1:4) = 1;
A(5,5:7) = 1;
A(6,5:7) = 1;
A(7,5:7) = 1;
A(8, 8:11) =1;
A(9, 8:11) =1;
A(10, 8:11) =1;
A(11, 8:11) =1;
%intra-cluster connections
A(1,5) = 1; A(5,1) = 1;
A(5,8) = 1; A(8,5) = 1;
A(5,9) = 1; A(9,5) = 1;

%remove self-loops
B = eye(11);
A = A - B;
end