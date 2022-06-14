%% parse the parameters
get_para_val = @(para)cellfun(@(p)p{1},para,'UniformOutput',false);
fc_parse_cell = @(c)c{:};
high_threshold = nan(2,1);
min_duration = nan(2,1);
min_n_sample = nan(2,1);
peak_direction = nan(2,1);
iSolution = nan(2,1);
wtc_frequency = nan(2,1);
wtc_sigma_thres = nan(2,1);
min_onset_N_sample = nan(2,1);
max_onset_N_sample = nan(2,1);
for ii_chan = 1:2
    [~,~,min_Length,...
        high_threshold(ii_chan),...
        min_duration(ii_chan),min_n_sample(ii_chan),...
        peak_direction(ii_chan),...
        iSolution(ii_chan),...
        wtc_frequency(ii_chan),...
        wtc_sigma_thres(ii_chan),...
        ~,...
        nStartTrial,nEndTrial,...
        min_onset_N_sample(ii_chan),max_onset_N_sample(ii_chan),...
        min_diff_allowed,max_diff_allowed,...
        qPreview] = fc_parse_cell(get_para_val(paraset{ii_chan}));
end
valid_data_segments = collection_loaded_data.(dataset_info.processed_var);
valid_data_segments = valid_data_segments(nStartTrial:nEndTrial,:,:);
valid_data_time = collection_loaded_data.(dataset_info.time_var);
valid_data_time = valid_data_time(nStartTrial:nEndTrial,:,:);




%% Remove NaNs
% old solution:
%     ind = cellfun(@(y1,y2)~(isnan(y1)|isnan(y2)),valid_data_segments(:,:,1),valid_data_segments(:,:,2),'UniformOutput',false);
%     valid_data_time = cellfun(@(x,ind)x(ind),valid_data_time,ind,'UniformOutput',false);
%     valid_data_segments = cellfun(@(x,ind)x(ind),valid_data_segments,repmat(ind,1,1,2),'UniformOutput',false);
valid_data_segments = fc_remove_nan_from_data_segments(valid_data_segments,@nanmedian);
%% Remove too-short segments
fprintf('Removing trials with data points shorter than %i\n',min_Length)
ind = cellfun(@(y)length(y(:))>=min_Length,valid_data_time);
fprintf('%i out of %i trials survived',sum(ind),length(ind))
trial_index = 1:length(ind);
valid_data_segments = valid_data_segments(ind,:,:);
valid_data_time = valid_data_time(ind,:,:);
trial_index = trial_index(ind);
%% Onset Function Validate: check the accuracy of function fc_find_start_point

if qPreview
qPlot = true;
    for i_trial = 1:size(valid_data_time,1)
        for ii_chan = 1:2
            % for debug: comparing the current version with the one used in
            % GUI
            %             figure(250)
            %             st_ind = fc_onset_detection_on_one_trial(valid_data_segments,i_trial,ii_chan,min_Length,...
            %                 high_threshold(ii_chan),min_duration(ii_chan),min_n_sample(ii_chan),peak_direction(ii_chan),iSolution(ii_chan),wtc_frequency(ii_chan),wtc_sigma_thres(ii_chan),qPlot);

    figure(543)
            subplot(1,2,ii_chan)
            cellfun(@(signal,t)t(...
                fc_find_start_point_wtc(peak_direction(ii_chan)*signal,...
                high_threshold(ii_chan),...
                wtc_frequency(ii_chan),wtc_sigma_thres(ii_chan),...
                min_n_sample(ii_chan),min_duration(ii_chan),...
                iSolution(ii_chan),...
                qPlot)),valid_data_segments(i_trial,:,ii_chan),valid_data_time(i_trial,:),'UniformOutput',false);
            title(sprintf('Trial No. %i Channel %i',trial_index(i_trial),ii_chan))
            pause(0.5)
        end
    end
end
qPlot = false;
%% Computing
st = cell(2,1);
for ii_chan = 1:2
st{ii_chan} = cellfun(@(signal,t)t(...
                fc_find_start_point_wtc(peak_direction(ii_chan)*signal,...
                high_threshold(ii_chan),...
                wtc_frequency(ii_chan),wtc_sigma_thres(ii_chan),...
                min_n_sample(ii_chan),min_duration(ii_chan),...
                iSolution(ii_chan),...
                qPlot)),...
                valid_data_segments(:,:,ii_chan),...
                valid_data_time(:,:),'UniformOutput',false);

st{ii_chan}(cellfun(@(st,t)isempty(st)||st<t(min_onset_N_sample(ii_chan)||st>t(max_onset_N_sample(ii_chan))),st{ii_chan},valid_data_time)) = {nan};% to tackle with false positives
end        

%%
st{1} = cell2mat(st{1});
st{2} = cell2mat(st{2});

%% Picking data: {not sure whether this is ok}
fs = 2500; % sampling rate
% % % time range
% % time_range = [1000, 1500]/fs;% arbitrary
% % time_range = [0, 2500]/fs;% arbitrary
% % fc_within_range = @(x,r)x>(r(1))&x<(r(2));
% % ind_ = fc_within_range(st{1},time_range)&fc_within_range(st{2},time_range);
% % % probe position
% % ind_ = ind_&isnan(Y(:,1748,1))&isnan(Y(:,182,2));
% % Y = Y(ind_,:,:);
% % X = X(ind_,:,:);
ind_ = ~isnan(st{1})&(~isnan(st{2}));
st{1} = st{1}(ind_);
st{2} = st{2}(ind_);
fprintf('Number of trials with good onsets on both channels: %i \n',sum(ind_))

time_diff = st{1}(:)-st{2}(:);
ind_to_remove = time_diff<min_diff_allowed|time_diff>max_diff_allowed;
fprintf('\n%i trials further removed because the rediculous time difference outside of range [%.4f, %.4f] second',sum(ind_to_remove),min_diff_allowed,max_diff_allowed);

st{1} = st{1}(~ind_to_remove);
st{2} = st{2}(~ind_to_remove);
fprintf('Number of trials remained: %i \n',sum(~ind_to_remove));

%% Histograms
figure(999);
% raw data
Y = collection_loaded_data.Y;
subplot(2,2,1)
imagesc(Y(:,:,1))
xlabel 'nSample (2500 Hz)'
ylabel 'nTrial'
colorbar
title 'Raw data from channel 1: Buzz'

subplot(2,2,3)
imagesc(Y(:,:,2))
colorbar
title 'Raw data from channel 2: Flash'
xlabel 'nSample (2500 Hz)'
ylabel 'nTrial'
% onset
subplot(2,2,2)
hist([st{1}(:),st{2}(:)],100)
legend 'chan1: Buzz' 'chan2: Flash'
title 'Stimulus onset time'
xlabel 'Time (second)'
ylabel 'Trial counts'

subplot(2,2,4)
time_diff = st{1}(:)-st{2}(:);

% remove rediculous data <>
% time_diff(time_diff<-0.2|time_diff>0) = [];

hist(time_diff,100)
title(sprintf('Time difference (Buzz - Flash) MEAN: %.4f, SD: %.4f, N = %i',mean(time_diff),std(time_diff),length(time_diff(:))))
xlabel 'Time (second)'
ylabel 'Trial counts'
figure(gcf)

save_fig_name = [dataset_info.name,sprintf('-Trial%ito%i',nStartTrial,nEndTrial)];

% an alternative way to maximize the figure:
% set(gcf,'Position', get(0,'Screensize'));

fig = gcf;
fig.WindowState = 'maximized';
saveas(gcf,[save_fig_name,'.fig'])

saveas(gcf,[save_fig_name,'.png'])
