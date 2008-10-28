function wzrd = import_gui_empty(varargin)


%% get parameters
type = get_option(varargin,'type','');

w = get_option(varargin,'width',400,'double');
h = get_option(varargin,'height',380,'double');
name = get_option(varargin,'name','Import Wizard','char');


%% define gui
scrsz = get(0,'ScreenSize');
wzrd = figure('MenuBar','none',...
 'Name',[type ' ' name],...
 'Resize','off',...
 'WindowStyle','modal',...
 'NumberTitle','off',...
 'Color',get(0,'defaultUicontrolBackgroundColor'),...
 'Position',[(scrsz(3)-w)/2 (scrsz(4)-h)/2 w h]);

uicontrol('BackgroundColor',[1 1 1],...
 'Parent',wzrd,...
 'Position',[-3 h-45 w+5 50],...
 'String','',...
 'Style','text',...
 'HandleVisibility','off',...
 'HitTest','off');

uicontrol(...
 'Parent',wzrd,...
 'FontSize',12,...
 'FontWeight','bold',...
 'BackgroundColor',[1 1 1],...
 'HorizontalAlignment','right',...
 'Position',[w-100 h-37 90 20],...
 'String',type,...
 'Style','text',...
 'HandleVisibility','off',...
 'HitTest','off');

