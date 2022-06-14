function c = fc_insert_lines_at(a,b,line_pos)
% insert lines of b into a after line_pos
col_a = size(a,2);
col_b = size(b,2);

if col_a>=col_b
    b = [b,cell(size(b,1),col_a - col_b)];
else
    a = [a,cell(size(a,1),col_b - col_a)];
end
c = [a(1:line_pos,:);b;a(line_pos+1:end,:)];
end