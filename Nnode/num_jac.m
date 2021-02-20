% Vdot and Wdot. Produces 2x3 matrix.
function [J] = num_jac(f,x,h)
t = 0;
for i = 1:length(x) % setting up Jacobian matrix as zeros
    e = zeros(length(x),1);
    e(i)=1;
    % entering values - approximation for first derivative
    J(:,i) = (f(t,x+(h*e))-f(t,x-(h*e)))/(2*h);
end
end
    