function dy = rm_model(t,y,A)
r = 0.5;
m = 1;
c = 0.2;
k = 2;
sigma = 1.7;
%sigma = 5*abs(cos(2*pi*(t)/90)); %time dependent sigma

%find Laplacian matrix
deg = sum(A);
D = diag(deg);
L = A - D;

u = y(1:length(A));
v = y(length(A)+1:end);

f = (r*u).*(1-u/k)-(m*u).*v./(1+u);
g = -c*v+(m*u).*v./(1+u)+sigma*L*v;

dy = [f;g];
end

