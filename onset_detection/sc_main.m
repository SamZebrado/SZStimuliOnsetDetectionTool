% 

%% Load file list
dataset_info = fc_show_and_choose_a_dataset();

%% Load processed data
addpath ../processed_data/
collection_loaded_data = load(dataset_info.processed_data);
rmpath ../processed_data/
%% Run onset detection
valid_data_segments = collection_loaded_data.(dataset_info.processed_var);
valid_data_time = collection_loaded_data.(dataset_info.time_var);
close(figure(1));
close(figure(2));

paraset = cell(2,1);
for ii_chan = 1:2
    save_fname = [dataset_info.name,sprintf('_chan_%i_para.xlsx',ii_chan)];
    if exist(save_fname,'file')% load parameter if there are existing files
        paraset{ii_chan} = fc_get_para(save_fname);
    else
        paraset{ii_chan} = fc_get_para();
        paraset{ii_chan}{2}{1} = ii_chan; % i_channel
    end
end

% remove nan
valid_data_segments = fc_remove_nan_from_data_segments(valid_data_segments,@nanmedian);

mp_handle(1) = fc_InteractiveOnsetDetection(valid_data_segments,paraset{1},figure(123));% handle of the manipulation panel

mp_handle(2) = fc_InteractiveOnsetDetection(valid_data_segments,paraset{2},figure(123));% use two handles for separately saving; 
% but use the same preview window since the current implementation does not
% support using different figure handles during updates: the wtc plots will
% always be updated in the first figure {reason to be discovered later}

%% Manually run
% sc_save_cur_para_for_cur_data
% sc_analyze_all_data_using_cur_para