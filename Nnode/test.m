clear all;

N = 30;
if N == 3
    A = make_chain(N);
else
    A = glattice(N^2);
end
%L = laplac(A);
L = sparse(A);
%%

clear all;

N = 50;
Dx = 1;
Dy = 1;

x = 1:Dx:N;
x = 1:Dy:N;


nx = N; % number of grid points in the x-direction;
ny = N; % number of grid points in the y-direction;
ex = ones(nx,1);
Dxx = (1/Dx^2) * spdiags([ex -2*ex ex], [-1 0 1], nx, nx); %1D discrete Laplacian in the x-direction ;
Dxx(1,1:2) = (1/Dx^2)*[-2,2]; Dxx(end,end-1:end) = (1/Dx^2)*[2,-2]; % Modify the Laplacian for Neumann BCs
ey = ones(ny,1);
Dyy = (1/Dy^2) * spdiags([ey, -2*ey ey], [-1 0 1], ny, ny); %1D discrete Laplacian in the y-direction ;
Dyy(1,1:2) = (1/Dy^2)*[-2,2]; Dyy(end,end-1:end) = (1/Dy^2)*[2,-2];
A = kron(Dyy, speye(nx)) + kron(speye(ny), Dxx) ; % trust ;)

L = sparse(A);
%%
c = 0.6;
a = 2.4;

t0 = 0;
tfinal = 2000;
tfinal1 = 2000;
thresh = 0.2;

y0 = rand(N^2*2,1)*0.4;

k = 15;

iter = 2;
%opts = odeset('RelTol',1e-5,'AbsTol',1e-5);
%opts1 = odeset('RelTol',1e-9,'AbsTol',1e-9);

delta_t = 0.001;
        func = @(y)RM_rhs_1(y,r,m,c,k,sigma,L,num);
        %Tfin = round(tfinal*thresh);
        %[t,sol] = ode45(func,[t0 tfinal],y0,opts);
        
        %[t,sol] = ode45(func,[tfinal:0.1:tfinal+tfinal1],sol(end,:),opts1);
        
     Tmax = 50;
     num_iter = round(Tmax/delta_t);
     
     for i = 1:num_iter
         disp(i/num_iter);
        dy = func(y0);
        y0 = y0 + delta_t*dy;
         
        Ymat(i,:) = y0';
     end
        
        score_count = zeros(num,1);
        
        Len = length(sol);
        if thresh == 0
            vec = sol(:,1:num);
        else
        thresh_ind = round((1-thresh)*Len);
        % column of data (1 = prey in node 1)
        vec = sol(end-thresh_ind:end,1:num);
        end
        s_rate = 1000;
        zvec = vec(s_rate:s_rate:end,1:num);
        
        for ind = 1:iter
        new_score = zeros(num,1);
        for column = 1:num
        new_score(column) = z1test(zvec(:,column));
        end
        
        score_count = score_count + new_score;
        disp(ind);
        
        end
        
        score_count = score_count/iter;
        
       


%%

y1 = y0+rand(2*num,1)/10000;
y2 = y0+rand(2*num,1)/10000;
y3 = y0+rand(2*num,1)/10000;
y4 = y0+rand(2*num,1)/10000;
y5 = y0-rand(2*num,1)/10000;
y6 = y0-rand(2*num,1)/10000;

func = @(t,y)RM_rhs_1(y,r,m,c,k,sigma,L,num);
[t,sol1] = ode45(func,[t0 tfinal],y1);
[t,sol2] = ode45(func,[t0 tfinal],y2);
[t,sol3] = ode45(func,[t0 tfinal],y3);
[t,sol4] = ode45(func,[t0 tfinal],y4);
[t,sol5] = ode45(func,[t0 tfinal],y5);
[t,sol6] = ode45(func,[t0 tfinal],y6);


%%
h = figure(6);
filename = 'chaos2.gif';
axis tight manual
for j = 1:size(sol,1)
    
plot3(sol(j:j+1,1),sol(j:j+1,2),sol(j:j+1,3),'r')
hold on
plot3(sol1(j:j+1,1),sol1(j:j+1,2),sol1(j:j+1,3),'b')
hold on
plot3(sol2(j:j+1,1),sol2(j:j+1,2),sol2(j:j+1,3),'g')
hold on
plot3(sol3(j:j+1,1),sol3(j:j+1,2),sol3(j:j+1,3),'k')
hold on
plot3(sol4(j:j+1,1),sol4(j:j+1,2),sol4(j:j+1,3),'y')
hold on
plot3(sol5(j:j+1,1),sol5(j:j+1,2),sol5(j:j+1,3),'c')
hold on
plot3(sol6(j:j+1,1),sol6(j:j+1,2),sol6(j:j+1,3),'m')
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
    % Capture frames as images
    frame = getframe(h);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    
        
    % Write GIF to file
    if j == 1
        imwrite(imind,cm,filename,'gif','Loopcount',inf);
    else
       imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
    if j == 1
        pause(2)
    end
end


