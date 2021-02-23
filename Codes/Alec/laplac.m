function L = laplac(A)
deg = sum(A,2);
D = diag(deg); 
L = A-D;
end