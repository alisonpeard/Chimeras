function matrix = rainforest_migration(A,t)
A(1,5) = .01; A(5,1) = .01;
A(5,8) = .1; A(8,5) = .1;
A(5,9) = .1; A(9,5) = .1;
matrix = A;
end