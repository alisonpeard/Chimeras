function matrix = rainforest_migration(A,t)
A(1,5) = 0.01; A(5,1) = 0.01;
A(5,8) = 0.1; A(8,5) = 0.1;
A(5,9) = 0.1; A(9,5) = 0.1;
matrix = A;
end