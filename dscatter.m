function hAxes = dscatter(X,Y, varargin)
% DSCATTER creates a scatter plot coloured by density.

lambda = [];
nbins = [];
plottype = 'scatter';
contourFlag = false;
msize  = 4;
marker = 'o';
alp    = 0.3;
logy   = false;
filled = true;

if nargin > 2
    if rem(nargin,2) == 1
        error('Bioinfo:IncorrectNumberOfArguments',...
            'Incorrect number of arguments to %s.',mfilename);
    end
    okargs = {'smoothing','bins','plottype','logy','marker','msize','filled'};
    for j=1:2:nargin-2
        pname = varargin{j};
        pval = varargin{j+1};
        k = strmatch(lower(pname), okargs); %#ok
        if isempty(k)
            error('Bioinfo:UnknownParameterName',...
                'Unknown parameter name: %s.',pname);
        elseif length(k)>1
            error('Bioinfo:AmbiguousParameterName',...
                'Ambiguous parameter name: %s.',pname);
        else
            switch(k)
                case 1  % smoothing factor
                    if isnumeric(pval)
                        lambda = pval;
                    else
                        error('Bioinfo:InvalidScoringMatrix','Invalid smoothing parameter.');
                    end
                case 2
                    if isscalar(pval)
                        nbins = [ pval pval];
                    else
                        nbins = pval;
                    end
                case 3
                    plottype = pval;
                case 4
                    logy = pval;
                    Y = log10(Y);
                case 5
                    contourFlag = pval;
                case 6
                    marker = pval;
                case 7
                    msize = pval;
                case 8
                    filled = pval;
            end
        end
    end
end
minx = min(X,[],1);
maxx = max(X,[],1);
miny = min(Y,[],1);
maxy = max(Y,[],1);
if isempty(nbins)
    nbins = [min(numel(unique(X)),200) ,min(numel(unique(Y)),200) ];
end
if isempty(lambda)
    lambda = 20;
end
edges1 = linspace(minx, maxx, nbins(1)+1);
ctrs1 = edges1(1:end-1) + .5*diff(edges1);
edges1 = [-Inf edges1(2:end-1) Inf];
edges2 = linspace(miny, maxy, nbins(2)+1);
ctrs2 = edges2(1:end-1) + .5*diff(edges2);
edges2 = [-Inf edges2(2:end-1) Inf];
[n,p] = size(X);
bin = zeros(n,2);
% Reverse the columns to put the first column of X along the horizontal
% axis, the second along the vertical.
[dum,bin(:,2)] = histc(X,edges1);
[dum,bin(:,1)] = histc(Y,edges2);

H = accumarray(bin,1,nbins([2 1])) ./ n;
G = smooth1D(H,nbins(2)/lambda);
F = smooth1D(G',nbins(1)/lambda)';
% = filter2D(H,lambda);
if logy
    ctrs2 = 10.^ctrs2;
    Y = 10.^Y;
end
okTypes = {'surf','mesh','contour','image','scatter'};
k = strmatch(lower(plottype), okTypes); %#ok
if isempty(k)
    error('dscatter:UnknownPlotType',...
        'Unknown plot type: %s.',plottype);
elseif length(k)>1
    error('dscatter:AmbiguousPlotType',...
        'Ambiguous plot type: %s.',plottype);
else
    switch(k)
        case 1 %'surf'
            h = surf(ctrs1,ctrs2,F,'edgealpha',0);
        case 2 % 'mesh'
            h = mesh(ctrs1,ctrs2,F);
        case 3 %'contour'
            [dummy, h] =contour(ctrs1,ctrs2,F);
        case 4 %'image'
            nc = 256;
            F = F./max(F(:));
            colormap(repmat(linspace(1,0,nc)',1,3));
            h =image(ctrs1,ctrs2,floor(nc.*F) + 1);
        case 5 %'scatter'
            F = F./max(F(:));
            ind = sub2ind(size(F),bin(:,1),bin(:,2));
            col = F(ind);
            if filled
                h = scatter(X,Y,msize,col,marker,'filled');
                alpha(h,alp)
            else
                h = scatter(X,Y,msize,col,marker);
                alpha(h,alp)
            end
    end
end
if logy
    set(gca,'yscale','log');
end
if nargout > 0
    hAxes = get(h,'parent');
end

function Z = smooth1D(Y,lambda)
[m,n] = size(Y);
E = eye(m);
D1 = diff(E,1);
D2 = diff(D1,1);
P = lambda.^2 .* D2'*D2 + 2.*lambda .* D1'*D1;
Z = (E + P) \ Y;
end


end