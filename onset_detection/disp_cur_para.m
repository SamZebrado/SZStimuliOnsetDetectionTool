
paraset = arrayfun(@(mp_hd)mp_hd.get_para(),mp_handle,'UniformOutput',false);
for ii_chan = 1:2
    b = cellfun(@(a)a(:),paraset{ii_chan},'UniformOutput',false);
    para_to_save = [b{:}]';
    fprintf('parameters for channel %i into file %s:\n',ii_chan)
    disp(para_to_save);
%     writecell(para_to_save,save_fname);
end