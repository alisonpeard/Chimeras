clear all;

% simple 2 node network 
num = 3;

% Adjacency matrix
    A = make_chain(num);

%    A = lattice(num/2);

% making Laplacian matrix from adjacency
L = laplac(A);

% RM model params
r = 1;
c = 0.2;
m = 1;

% tfinal - for ode45
t0 = 0;
tfinal = 100000;
tfinal1 = tfinal+50000;

% fraction of transcient data to disregard for 0-1 test
thresh = 0;

% random initial conditions
y0 = rand(num*2,1)*0.4;

% vector of k and sigma values to loop through
kvec = [5];
sigmavec = [1e-5];

% setting up array to store 0-1 test values
score = zeros(length(kvec),1);


opts = odeset('RelTol',1e-6,'AbsTol',1e-9);
opts1 = odeset('RelTol',1e-5,'AbsTol',1e-5);
S = zeros(length(kvec),length(sigmavec));
for i = 1:length(kvec)
    k = kvec(i);
    disp(i);
    for j = 1:length(sigmavec)
        disp(j);
        sigma = sigmavec(j);
        % RHS function
        func = @(t,y)RM_rhs_1(y,r,m,c,k,sigma,L,num);
        
        [t,sol] = ode45(func,[t0:0.1:tfinal],y0,opts);
        [t,sol] = ode45(func,[tfinal tfinal1],sol(end,:),opts1);
        
        % disregarding transcient data
        Len = length(sol);
        ind = round((1-thresh)*Len);
        % column of data (1 = prey in node 1)
        column = 1;
        
        vec = sol(:,column);
        % sampling rate for 0-1 test
        s_rate = 500;
        zvec = vec(s_rate:s_rate:end);
        
        % result of 0-1 test
        score = z1test(zvec);
        
        S(i,j) = score;
    end
    
end

%%

y0 = sol(end,:)';

y1 = y0+(rand(2*num,1)/10000);
y2 = y0+(rand(2*num,1)/10000);
y3 = y0+(rand(2*num,1)/10000);
y4 = y0+(rand(2*num,1)/10000);
y5 = y0+(rand(2*num,1)/10000);
y6 = y0+(rand(2*num,1)/10000);

tfinal1 = 20000;
opts1 = odeset('RelTol',1e-5,'AbsTol',1e-5);
func = @(t,y)RM_rhs_1(y,r,m,c,k,sigma,L,num);
[t,sol1] = ode45(func,[t0 tfinal1],y1,opts1);
[t,sol2] = ode45(func,[t0 tfinal1],y2,opts1);
[t,sol3] = ode45(func,[t0 tfinal1],y3,opts1);
[t,sol4] = ode45(func,[t0 tfinal1],y4,opts1);
[t,sol5] = ode45(func,[t0 tfinal1],y5,opts1);
[t,sol6] = ode45(func,[t0 tfinal1],y6,opts1);


 %%
% h = figure(6);
% filename = '3nodechaos2.gif';
% axis tight manual
 for j = 1:size(sol,1)
%     

plot3(sol1(j:j+100,1),sol1(j:j+100,2),sol1(j:j+100,3),'b')
hold on
plot3(sol2(j:j+100,1),sol2(j:j+100,2),sol2(j:j+100,3),'g')
hold on
plot3(sol3(j:j+100,1),sol3(j:j+100,2),sol3(j:j+100,3),'k')
hold on
plot3(sol4(j:j+100,1),sol4(j:j+100,2),sol4(j:j+100,3),'y')
hold on
plot3(sol5(j:j+100,1),sol5(j:j+100,2),sol5(j:j+100,3),'c')
hold on
plot3(sol6(j:j+100,1),sol6(j:j+100,2),sol6(j:j+100,3),'m')
hold on

xlim([0 6])
ylim([0 6])
zlim([0 6])
xlabel('Node 1')
ylabel('Node 2')
zlabel('Node 3')
title('Evolution of prey')
axis tight manual
drawnow
if j == 1
    pause(3)
end
%     % Capture frames as images
%     frame = getframe(h);
%     im = frame2im(frame);
%     [imind,cm] = rgb2ind(im,256);
%     
%         
%     % Write GIF to file
%     if j == 1
%         imwrite(imind,cm,filename,'gif','Loopcount',inf);
%     else
%        imwrite(imind,cm,filename,'gif','WriteMode','append');
%     end
%     if j == 1
%         pause(2)
%     end
 end
% 
% 
