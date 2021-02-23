 function dy = RM_rhs_1(y,r,m,c,k,sigma,L,num)

u = y(1:num);
v = y(num+1:end);

udot = (r*u).*(1-(u/k))-(m*(u.*v)./(1+u));
vdot = -(c*v)+(m*(u.*v)./(1+u))+(sigma*L*v);

dy = [udot;vdot];


end