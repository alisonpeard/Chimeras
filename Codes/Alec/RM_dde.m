function y = RM_dde(xx,pars)

num = pars(6);

u = xx(1:num,1);
v = xx(num+1:end,1);

r = pars(1); m = pars(2); c = pars(3); k = pars(4); sigma = pars(5); L = pars(7:end-1); 
L = reshape(L,num,num);

udot = (r*u).*(1-(u/k))-(m*(u.*v)./(1+u));
vdot = -(c*v)+(m*(u.*v)./(1+u))+(sigma*L*v);

y = [udot;vdot];

end