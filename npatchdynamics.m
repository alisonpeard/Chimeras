
%n-patch herbivore-plant population dynamics,
%Rosenzweig-Macarthur predator-prey model

function rm2

%declare parameters
global r; %plant reproduction rate
global k; %plant carrying capacity
global m; %hertbivore reproduction coefficient
global c; %herbivore death rate
global adj; %adjacency matrix
global g; %herbivore travel rate
global lap; %laplacian matrix

%parameter assignment, assume parameters equal in both pathches
r = 1;
k = 1;
m = 10;
c = 1;
adj = [0 1 0 0;1 0 0 0; 0 0 0 0; 0 0 0 0]; %can assign as you see fit; could add random symmetric matrix generator
g = 1;

%set simulation time
Tend=100;

%set initial condition.  The state vector is S=[P1,P2...Pn, H1, H2,...Hn]
S0vec=[0.5,0.5,0.5,0.5,0.5,0.8,0.6,0.6];
%S0vec = repmat(S0vec, 1, length(adj)); %this just makes the same initial populations at each node, can be changed 

%find Laplacian matrix from Adjacency matrix

deg = sum(adj);
D = diag(deg);
lap = D - adj;


%set simulation parameters
OPTIONS = odeset('RelTol',1e-6,'AbsTol',1e-9, 'refine',5);
ODEFUN=@popdynamics;

%run simulation
[t,S]=ode45(ODEFUN, [0,Tend], S0vec, OPTIONS);

%generate fig

set(gca,'fontsize',14)


figure(1)
plot(t, S)
xlabel('Time')
ylabel('Population')
legend('Plants', 'Herbivores')



figure(2)
for i = 1:length(adj) %plots all n trajectories
hold on
plot(S(:,2*i-1),S(:,2*i))
end
xlabel('Plants')
ylabel('Herbivores')

end


function dSdt = popdynamics(t,S)

global r;
global k;
global m;
global c;
global lap;
global g; 

S = reshape(S, [length(lap),2]);

%locally define state variables:
p=S(:,1);
h=S(:,2);

%population dynamics:

ddp = r*p.*(1-p/k) - (m*p.*h)./(1+p);
ddh = -c*h + (m*p.*h)./(1+p) - g*lap*h;


dSdt=[ddp; ddh];


end
