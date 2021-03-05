 function dy = paper_rhs(y,a,c,k,A,num)
num = num^2;
u = y(1:num);
v = y(num+1:end);

udot = ((u).*(1-u))-((a*(u.*v))./(v+u)) + A*u;
vdot = -(c*v)+((u.*v)./(v+u))+(k*A*v);

dy = [udot;vdot];


end