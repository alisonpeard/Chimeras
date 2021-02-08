function graphplot(adj,type,varargin)
%if(~contains(path,'wgPlot'))
%    addpath('wgPlot');
%end


%n = size(adj,1)-1;

%Coordinates = [0,cos(2*i*pi/n); 0,sin(2*i*pi/n)]';
if(strcmp(type,'cycle'))
    n = size(adj,1);
    i=1:n;
    Coordinates = [cos(2*i*pi/n); sin(2*i*pi/n)]';
elseif(strcmp(type,'path'))
    n = size(adj,1);
    i=1:n;
    Coordinates = [i; zeros(size(i))]';
elseif(strcmp(type,'grid'))
    n = size(adj,1);
    m = sqrt(n);
    [X,Y] = meshgrid(1:m,1:m);
    Coordinates = [X(:), Y(:)];
elseif(strcmp(type,'separate'))
    n = size(adj,1)-1;
    i=1:n;
    Coordinates = [0,cos(2*i*pi/n); 0,sin(2*i*pi/n)]';
else
    
end
%wgPlot(adj,Coordinates,varargin{:});
gplot(adj,Coordinates,'-o');
