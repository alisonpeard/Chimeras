function dy = rm_model(t,y,A,k,sigma)
%y = reshape(y, [length(A),2]);
%dy = zeros(length(A)*2,1);
r = 0.5;
m = 1;
c = 0.2;

%find Laplacian matrix
deg = sum(A);
D = diag(deg);
L = D - A;

u = y(1:length(A));
v = y(length(A)+1:end);

f = (r*u).*(1-u/k)-(m*u).*v./(1+u);
g = -c*v+(m*u).*v./(1+u)-sigma*L*v;

dy = [f;g];
end

