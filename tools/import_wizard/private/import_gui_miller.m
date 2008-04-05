function handles = import_gui_miller( handles )

pos = get(handles.wzrd,'Position');
h = pos(4);
w = pos(3);

ph = 270;


%% hkil page
handles.page3 = get_panel(w,h,ph);

uicontrol(...
  'String','Imported Pole Figure Data Sets',...
  'Parent',handles.page3,...
  'HitTest','off',...
  'Style','text',...
  'HorizontalAlignment','left',...
  'Position',[10 ph-25 200 15]);

handles.listbox_miller = uicontrol(...
'Parent',handles.page3,...
'BackgroundColor',[1 1 1],...
'FontName','monospaced',...
'HorizontalAlignment','left',...
'Max',2,...
'Position',[15 37 225 ph-70],...
'String',blanks(0),...
'Style','listbox',...
'Max',1,...
'Callback','import_wizard_PoleFigure(''miller_update'')',...
'Value',1);

mi = uibuttongroup('title','Miller Indece',...
  'Parent',handles.page3,...
  'units','pixels','position',[260 ph-160 120 150]);

ind = {'h','k','i','l'};
for k=1:4
uicontrol(...
 'Parent',mi,...
  'String',ind{k},...
  'HitTest','off',...
  'Style','text',...
  'HorizontalAlignment','right',...
  'Position',[10 132-30*k 10 15]);
handles.miller{k} = uicontrol(...
  'Parent',mi,...
  'BackgroundColor',[1 1 1],...
  'FontName','monospaced',...
  'HorizontalAlignment','right',...
  'Position',[30 130-30*k 70 22],...
  'String',blanks(0),...
  'Callback','import_wizard_PoleFigure(''update_indices'')',...
  'Style','edit');
end

sc = uibuttongroup('title','Structure Coeff.',...
  'Parent',handles.page3,...
  'units','pixels','position',[260 ph-230 120 55]);

uicontrol(...
 'Parent',sc,...
  'String','c',...
  'HitTest','off',...
  'Style','text',...
  'HorizontalAlignment','right',...
  'Position',[10 10 10 15]);

handles.structur = uicontrol(...
  'Parent',sc,...
  'BackgroundColor',[1 1 1],...
  'FontName','monospaced',...
  'HorizontalAlignment','right',...
  'Position',[30 10 70 22],...
  'String',blanks(0),...
  'Callback','import_wizard_PoleFigure(''update_indices'')',...
  'Style','edit');

uicontrol(...
  'String',['For superposed pole figures seperate multiple Miller indece ', ...
  'and structure coefficients by space!'],...
  'Parent',handles.page3,...
  'HitTest','off',...
  'Style','text',...
  'HorizontalAlignment','left',...
  'Position',[5 0 390 30]);