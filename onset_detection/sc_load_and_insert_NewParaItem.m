%% line number 
line_number = 14;
%% load new parameters
flist = dir('*_para.xlsx');
disp 'Start modifying all parameter files';
disp({flist.name}');
fprintf('Going to insert the following contents after line %i\n',line_number);
para_to_insert= fc_get_para('para_to_append.xlsx');
para_to_insert = fc_peel_inside_a_cell_vector(para_to_insert);

disp 'Do remember to modify all places with @parse_cell'
disp 'Press any key to continue'
pause;


%%
for i_file = 8:length(flist)
    fname = flist(i_file).name;
    para_table = fc_peel_inside_a_cell_vector(fc_get_para(fname));
    fprintf('\nParamter table loaded:\n')
    disp(para_table)
    c = fc_insert_lines_at(para_table,para_to_insert,line_number);
    fprintf('\n will be changed into:\n ')
    disp(c);
    disp 'Press any key to continue';
    pause;
    writecell(c,fname);
end