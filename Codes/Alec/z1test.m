function kmedian=z1test(x)
s=size(x); if s(2)==1; x=x'; end;
N=length(x); j=[1:N];
t=[1:round(N/10)];
M=zeros(1,round(N/10));
c=pi/5+rand(1,100)*3*pi/5;  % 100 random c values in [pi/5,4pi/5]
for its=1:100
   p=cumsum(x.*cos(j*c(its)));q=cumsum(x.*sin(j*c(its)));
   for n=1:round(N/10); 
      M(n)=mean( (p(n+1:N)-p(1:N-n)).^2 + (q(n+1:N)-q(1:N-n)).^2 )- ...
           mean(x)^2*(1-cos(n*c(its)))/(1-cos(c(its)));
   end
   kcorr(its)=corr(t',M');
end
%  plot(c,kcorr,'*');xlabel('c');ylabel('k'); % useful diagnostic plots
%  plot(t,M);xlabel('t');ylabel('M')
% Two crude attempts to check for oversampling:
if (max(x)-min(x) )/mean(abs(diff(x))) > 10 | ...
       median(kcorr(c<mean(c))) - median(kcorr(c>mean(c))) > 0.5
   disp('Warning: data is probably oversampled.')
   disp('Use coarser sampling or reduce the maximum value of c.')
end
kmedian=median(kcorr);