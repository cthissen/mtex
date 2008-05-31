function plot2all(varargin)
% plots to all axes of the current figure
%
%% Syntax
%
%  plot2all([xvector,yvector,zvector])
%  plot2all(Miller(1,1,1,cs),'all')
%
%% Description
% The function *plot2all* plots annotations, e.g. specimen or crystal
% directions to all subfigures of the current figure
%
%% See also
% Miller/plot vector3d/plot

oax = get(gcf,'currentAxes');
  
ax = get_option(varargin,'axes', findobj(gcf,'tag','S2Grid'));
  
for i = 1:length(ax)
  set(gcf,'currentAxes',ax(i));
  
  washold = ishold;
  hold all;
  plot(varargin{:});
  if ~washold, hold off;end
end

set(gcf,'currentAxes',oax,'nextplot','replace');