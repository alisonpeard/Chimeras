t0 = 0;
tfinal = 100;
y0 = [10;10;10;1;1;1];
[t,y] = ode45('rm_model',[t0,tfinal],y0);
figure(1)
plot(t,y(:,1),t,y(:,4))
figure(2)
plot(t,y(:,2),t,y(:,5))
figure(3)
plot(t,y(:,3),t,y(:,6))


