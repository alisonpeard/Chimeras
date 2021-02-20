function [t_discrete,projection] = phase_shift(t,X,ps)
 
 t_discrete = linspace(t(1), t(end), 1024)';

 X = interp1(t,X,t_discrete);
 signal = X;
 
 nFCs = 50;
 n = -nFCs/2+1:nFCs/2-1;
 Tp = t_discrete(end)-t_discrete(1);
 
 phases = -1i*2*pi*t_discrete*n/Tp;
 I = exp(phases);
 SIGNAL = repmat(signal, [1,nFCs-1]);
 
 INTEGRAND = (SIGNAL.*I);
 
 FC = (1/1023)*trapz(INTEGRAND, 1);


 % Project back into real space

t_add = ps*Tp/(2*pi);
t_alt = t_discrete+t_add;
num = length(t_alt);
phases_alt = 1i*2*pi*t_alt*n/Tp;

I_alt = exp(phases_alt);
 
FCs = repmat(FC, [num,1]);
 
projection = sum(FCs.*I_alt,2);
 
 