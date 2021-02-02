% adapting Xinzhu's code here

n = 3;

t0 = 0;
tfinal = 1000;

y0 = [10;1];
y0_vec = [y0(1).*ones(n,1);y0(2).*ones(n,1)];

[t,y] = ode45('rm_model',[t0,tfinal],y0_vec);


subplot(1,3,1)
plot(t,y(:,1),t,y(:,4))
ylabel("pred/prey")
xlabel("time")

subplot(1,3,2)
plot(t,y(:,2),t,y(:,5))
ylabel("pred/prey")
xlabel("time")

subplot(1,3,3)
plot(t,y(:,3),t,y(:,6))
ylabel("pred/prey")
xlabel("time")


