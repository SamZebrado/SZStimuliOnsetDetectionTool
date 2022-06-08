
paraset = arrayfun(@(mp_hd)mp_hd.get_para(),mp_handle,'UniformOutput',false);
for ii_chan = 1:2
    save_fname = [dataset_info.name,sprintf('_chan_%i_para.xlsx',ii_chan)];
    b = cellfun(@(a)a(:),paraset{ii_chan},'UniformOutput',false);
    para_to_save = [b{:}]';
    disp('Data:')
    disp(para_to_save);
     writecell(para_to_save,save_fname);
    fprintf('Parameters for channel %i saved into file %s\n',ii_chan,save_fname)
end

fprintf('\nParameter Saved!\n\n')