 function dy = RM_rhs(y,r,m,c,k,beta,b,sigma,L,num)

u = y(1:num);
v = y(num+1:end);

udot = (r*u).*(1-(u/k))-(m*(u.*v)./(b+u));
vdot = -(c*v)+(m*beta*(u.*v)./(b+u))+(sigma*L*v);

dy = [udot;vdot];


end