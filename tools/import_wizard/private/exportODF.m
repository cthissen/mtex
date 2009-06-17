function str = exportODF(fn, odf, interface, options, handles)

str = ['%% created with import_wizard';{''}];

%% specify crystal and specimen symmetries

str = [ str; '%% specify crystal and specimen symmetries';{''}];
[cs, ss] = getSym(odf);

str = [str; export_CS_tostr(cs)];

str = [str; strcat('SS = symmetry(''',strrep(char(ss),'"',''), ''');')];

% plotting convention
plotdir = cell2mat(get(handles.plot_dir,'value'))==1;
plotdir = get(handles.plot_dir(plotdir),'string');
str = [ str; {''};['plotx2' lower(plotdir) '    % plotting convention']];

%% specify the file names

str = [ str; {''};'%% specify file names'; {''};'fname = { ...'];

for k = 1:length(fn)
    str = [ str; strcat('''', fn{k}, ''', ...')]; %#ok<AGROW>
end
str = [ str; '};'; {''}];

%% import the data 

str = [ str; '%% import the data'; {''}];
lpf = ['odf = loadODF(fname,CS,SS,''interface'',''',...
  interface,''''];

if ~isempty(options)
  lpf = [lpf, ', ',option2str(options,'quoted')];
end

str = [str; [lpf ');']];

%% post process data

if get(handles.rotate,'value')
  str = [str; {''}; '%% rotate ODF data'; {''};...
    'odf = rotate(odf, axis2quat(zvector, ',get(handles.rotateAngle,'string'),'*degree));'];
end
