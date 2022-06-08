function mp = fc_InteractiveOnsetDetection(data_segments,para,varargin)
%% detect onset from a given trial
% data_segment: a segment of continuous data
% para: parameters for the onset detection algorithm
%
addpath InteractivePlotToolBox
%% parameters for onset detection algorithm

if isempty(varargin)
    fig_handle = figure(123);
else
    fig_handle = varargin{1};
end

plot_fc = @(para)call_fc_onset_detection_on_one_trial(data_segments,para,fig_handle);
mp = InteractivePlot(plot_fc,para);
rmpath InteractivePlotToolBox
end