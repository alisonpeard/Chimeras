function f=rhs_ext(t,X)
%
%  Lorenz equation 
%
%               dx/dt = SIGMA*(y - x)
%               dy/dt = R*x - y -x*z
%               dz/dt= x*y - BETA*z
%
%        In demo run SIGMA = 10, R = 28, BETA = 8/3
%        Initial conditions: x(0) = 0, y(0) = 1, z(0) = 0;
%        Reference values for t=10 000 : 
%              L_1 = 0.9022, L_2 = 0.0003, LE3 = -14.5691
%
%        See:
%    K. Ramasubramanian, M.S. Sriram, "A comparative study of computation 
%    of Lyapunov spectra with different algorithms", Physica D 139 (2000) 72-86.
%
% --------------------------------------------------------------------
% Copyright (C) 2004, Govorukhin V.N.


% Values of parameters

Y = eye(num);

f=zeros(9,1);

%Lorenz equation
u = y(1:num);
v = y(num+1:2*num);

udot = (r*u).*(1-(u/k))-(m*(u.*v)./(1+u));
vdot = -(c*v)+(m*(u.*v)./(1+u))+(sigma*L*v);

f = [udot;vdot];

%Linearized system

 Jac=[-SIGMA, SIGMA,     0;
         R-z,    -1,    -x;
           y,     x, -BETA];
  
%Variational equation   
f(end+1:end+(num^2))=Jac*Y;

%Output data must be a column vector


