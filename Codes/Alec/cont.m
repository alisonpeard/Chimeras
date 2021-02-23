clear all;

num = 4;
if num == 3
    A = make_chain(num);
else
    A = lattice(num/2);
end
L = laplac(A);

r = 1;
c = 0.2;
m = 1;

t0 = 0;
tfinal = 100000;
thresh = 10000;

y0 = rand(num*2,1)*0.4;


kvec = [3.8];
sigmavec = [1e-5];


score = zeros(length(kvec),1);


S = zeros(length(kvec),length(sigmavec));
for i = 1:length(kvec)
    k = kvec(i);
    disp(i);
    for j = 1:length(sigmavec)
        disp(j);
        sigma = sigmavec(j);
        func = @(t,y)RM_rhs_1(y,r,m,c,k,sigma,L,num);
        
        [t,sol] = ode45(func,[t0 tfinal],y0);
        
        vec = sol(end-thresh:end,1);
        zvec = vec(10:10:end);

        score = z1test(zvec);
        
        S(i,j) = score;
    end
    
end

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
%filename = 'chaos2.gif';
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
   % frame = getframe(h);
   % im = frame2im(frame);
   % [imind,cm] = rgb2ind(im,256);
    
        
    % Write GIF to file
   % if j == 1
    %    imwrite(imind,cm,filename,'gif','Loopcount',inf);
    %else
     %  imwrite(imind,cm,filename,'gif','WriteMode','append');
    %end
    %if j == 1
    %    pause(2)
    %end
end


%% Plotting the results as a GIF
h = figure(6);
%filename = 'cross.gif';
axis tight manual
for n = 1:50:Timesteps
    
    % Data
    Z = CSet{n};
    surf(X,Y,Z)
    xlim([0 1])
    ylim([0 1])
    zlim([-1.2 1.2])
    %view(0,270)
    drawnow
    % Capture frames as images
    frame = getframe(h);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    
    % Write GIF to file
    %if n == 1
     %   imwrite(imind,cm,filename,'gif','Loopcount',inf);
    %else
     %   imwrite(imind,cm,filename,'gif','WriteMode','append');
    %end
    %if n == 1
    %    pause(3)
    %end
end



%%
thresh1 = 0.98;
thresh2 = 0.99;
for j = 1:length(kvec)
    if score(j) > thresh1 && score(j) < thresh2
        scatter(kvec(j),score(j),'b')
        hold on
    elseif score(j) > thresh2
        scatter(kvec(j),score(j),'r')
        hold on
    else
        scatter(kvec(j),score(j),'k')
        hold on
    end
    
end

%%

addpath '/Volumes/ALEC MEM 1/LMS/dde_biftool_v3.1.1/ddebiftool'
addpath '/Volumes/ALEC MEM 1/LMS/dde_biftool_v3.1.1/ddebiftool_utilities'
%addpath 'D:\LMS\dde_biftool_v3.1.1\ddebiftool'
%addpath 'D:\LMS\dde_biftool_v3.1.1\ddebiftool_utilities'

%feedback_params.m;

% setting delay func
tau_func = @()[8];
tau = 0;

Tp = t(end);
w = 2*pi/Tp;

%%
%phaseshift = 0;

%X = ref_u;
%Y = ref_v;
%t = ref_t;

%[~,sigx] = phase_shift(t,X,phaseshift);
%[t_discrete,sigy] = phase_shift(t,Y,phaseshift);
 
%sigx = interp1(t_discrete,sigx,t);
%sigy = interp1(t_discrete,sigy,t);
%%

t = ref_lim.x;
% tracking PO with psol_topsol
orbit = @(t)deval(ref_lim,t)';
L = reshape(L,num*num,1)';
pars = [r,m,c,k,sigma,num,L,tau]; % paramater vector
ind_cont1 = 4; % index of coninuation parameter 
col_deg = 6;
nr_int = 60;

% continuation of branch

funcs = set_funcs(...
'sys_rhs',@RM_dde,... % bruss_rhs function in function file
'sys_tau',tau_func);

Tp = t(end);
% creating branch
[branch,suc] = psol_topsol(funcs,pars,orbit,Tp,col_deg,nr_int,ind_cont1,1);
if suc == 0
    
[branch,suc] = psol_topsol(funcs,pars,orbit,Tp,col_deg,nr_int,ind_cont1,0);
 
end
suc

step = 1e-3;
tries = 200;

% params for continuation
branch.parameter.min_bound(1,:)=[ind_cont1 0.01]';
branch.parameter.max_bound(1,:)=[ind_cont1 5]' ;
branch.parameter.max_step(1,:)=[ind_cont1 step]';
% continuation
branch.method.continuation.plot = 1;
figure(1)
[branch,s,f,r]=br_contn(funcs,branch,tries);
branch = br_rvers(branch);
[branch,s,f,r]=br_contn(funcs,branch,tries);


branch = br_stabl(funcs,branch,0,0);

%%
for i = 1:length(branch.point)
    m1 = max(branch.point(i).profile(1,:));
    m2 = min(branch.point(i).profile(1,:));
    if length(m1) > 1
        m1 = m1(1);
    end
     if length(m2) > 1
        m2 = m2(1);
    end
    scatter(branch.point(i).parameter(ind_cont1),m1,'k.')
    hold on
    scatter(branch.point(i).parameter(ind_cont1),m2,'b.')
    
    
    
end
