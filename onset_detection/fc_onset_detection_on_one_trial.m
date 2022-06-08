function st_ind = fc_onset_detection_on_one_trial(data_segments,i_trial,i_chan,min_Length,...
    high_threshold,min_duration,min_n_sample,peak_direction,iSolution,wtc_frequency,wtc_sigma_thres,qPlot)

% get the one trial
signal = data_segments{i_trial,1,i_chan};

if length(signal)<min_Length
    fprintf('data segment smaller than the minimum requirement (%i)\n',min_Length);
    return;
end

%% core funciton
st_ind = fc_find_start_point_wtc(signal*peak_direction, high_threshold,wtc_frequency,wtc_sigma_thres,min_n_sample,min_duration,iSolution,qPlot);
end