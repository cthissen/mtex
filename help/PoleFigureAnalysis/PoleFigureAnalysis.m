%% Pole Figure Analysis
% This sections gives you an overview over the functionality MTEX offers to
% analyze pole figure data.
%
%% Import of Pole Figures
%
% The most comfortable way to import pole figure data into MTEX is to use
% the import wizard, which can be started by the command

import_wizard

%%
% If the data are in a format supported by MTEX the import wizard generates
% a script which imports the data. More information about the import wizard
% and a list of supported file formats can be found
% [[interfaces_index.html,here]]. A typical script generated by the import 
% wizard looks a follows.

% specify scrystal and specimen symmetry
cs = symmetry('-3m',[1.4,1.4,1.5]);
ss = symmetry('triclinic');

% specify file names
fname = {...
  [mtexDataPath '/dubna/Q(10-10)_amp.cnv'],...
  [mtexDataPath '/dubna/Q(10-11)(01-11)_amp.cnv'],...
  [mtexDataPath '/dubna/Q(11-22)_amp.cnv']};

% specify crystal directions
h = {Miller(1,0,-1,0,cs),[Miller(0,1,-1,1,cs),Miller(1,0,-1,1,cs)],Miller(1,1,-2,2,cs)};

% specify structure coefficients
c = {1,[0.52 ,1.23],1};

% import pole figure data
pf = loadPoleFigure(fname,h,cs,ss,'superposition',c)

% After running the script the variable *pf* is created which contains all
% information about the pole figure data. 

%% Plotting Pole Figure Data
%
% Pole figures are plotted using the [[PoleFigure_plot.html,plot]] command.
% It plottes a singe colored dot for any data point contained in the pole
% figure. There are many options to specify the way pole figures are
% plotted in MTEX. Have a look at the <plot_index plotting section> for
% more informations.

figure
plot(pf,'position',[100 100 600 300])

%% Modify Pole Figure Data
%
% MTEX offers a lot of operations to analyze and manipulate pole 
% figure data, e.g.
%
% * rotating pole figures
% * scaling pole figures
% * find outliers
% * remove specific measurements
% * superpose pole figures
%
% An exhausive introduction how to modify pole figure data can be found
% <ModifyPoleFigureData.html here>
% As an example, if one wants to set all negative intensities to zero one
% can issue the command

polar = get(pf,'polar');
pf = delete(pf,polar >= 74*degree & polar <= 81*degree);
plot(pf)


%% Calculate an ODF from Pole Figure Data
%
% Calculating an ODF from pole figure data can be done using the command
% <PoleFigure_calcODF.html calcODF>. A precise decription of the underlying
% algortihm as well as of the options can be found 
% <odf_estimation.html here>

odf = calcODF(pf,'zero_range','silent')
plotpdf(odf,h,'axial','position',[100 100 800 300])


%% Simulate Pole Figure Data
%
% Simulating pole figure data from a given ODF has been proven to be
% usefull to analyze the stability of the ODF estimation process. There is
% an <PoleFigureSimulation_demo.html example> demostrating how to determine the
% number of pole figures to estimate the ODF up to a given error. The MTEX
% command to simulate pole figure is <ODF_simulatePoleFigure.html
% simulatePoleFigure>, e.g.

pf = simulatePoleFigure(santafee,Miller(1,0,0),S2Grid('regular'))
plot(pf)
