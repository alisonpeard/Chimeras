function A = adjacent(num)

A = rand(num);
A = round((A+A')/2);
A = A - diag(diag(A));
end