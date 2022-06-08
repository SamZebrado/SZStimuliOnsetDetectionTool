%% retrieve the parameters
paraset = arrayfun(@(mp_hd)mp_hd.get_para(),mp_handle,'UniformOutput',false);
% analyze all data using these parameters

%% apply the parameters
qPlot = false;

sc_PlotHistOfStartTimesUsingValidDataSegments