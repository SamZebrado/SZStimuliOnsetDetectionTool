function c_table = fc_peel_inside_a_cell_vector(c)
% get contents of each cell and reconcatenate them into one larger matrix
% transform [{1*3 cell};{1*3 cell};{1*3 cell}] into 3*3 cell
    b = cellfun(@(a)a(:),c,'UniformOutput',false);
    c_table = [b{:}]';
end