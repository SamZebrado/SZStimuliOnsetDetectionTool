fprintf(['Shortcuts Commands:\n', ...
    '\t(1) choose a dataset and try different parameters: sc_main;\n',...
    '\t(2) save current parameter set: sc_save_cur_para_for_cur_data;\n',...
    '\t(3) analyze all data in the current dataset using the current parameter set: sc_analyze_all_data_using_cur_para;\n'])

sc_group = {
    'sc_main';
    'sc_save_cur_para_for_cur_data';
    'sc_analyze_all_data_using_cur_para';
    };
sc_ind = input('');
eval(sc_group{sc_ind});