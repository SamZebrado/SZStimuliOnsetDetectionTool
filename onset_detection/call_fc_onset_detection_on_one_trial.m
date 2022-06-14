function st_ind = call_fc_onset_detection_on_one_trial(data_segments,para,varargin)
% call function fc_onset_detection_on_one_trial with inputs determined by
% para in sequence
if isempty(varargin)
    fig_handle = figure(123);
else
    fig_handle = varargin{1};
end
get_para_val = @(para)cellfun(@(p)p{1},para,'UniformOutput',false);
fc_parse_cell = @(c)c{:};

[i_trial,i_chan,min_Length,...
    high_threshold,...
    min_duration,min_n_sample,...
    peak_direction,iSolution,...
    wtc_frequency,wtc_sigma_thres,...
    qPlot] = fc_parse_cell(get_para_val(para));
figure(fig_handle);
subplot(1,2,1);

try
    st_ind = fc_onset_detection_on_one_trial(data_segments,i_trial,i_chan,min_Length,...
        high_threshold,min_duration,min_n_sample,peak_direction,iSolution,wtc_frequency,wtc_sigma_thres,qPlot);
catch e
    disp(e)
    st_ind = [];
end
try
    if qPlot
        axes = arrayfun(@(s)subplot(3,2,s),[2,4,6]);
        fc_plot_data_and_cwt(data_segments{i_trial,1,i_chan},figure(123),axes);
    end
catch e
    disp(e)
end
end