function cur_info = fc_show_and_choose_a_dataset()
% Load file list
addpath ../
sc_gen_file_list;
rmpath ../
fname_list = {file_info(:).name};
n_file = length(fname_list);
to_print = [num2cell((1:n_file)'),fname_list(:)]';
fprintf(['Records detected for the following dataset\n\n',...
    repmat('\t(%i) %s\n',1,n_file)],...
    to_print{:});
f_ind = input(sprintf('\nType the index of the one you want to analyze:\t'));

cur_info = file_info(f_ind);
end