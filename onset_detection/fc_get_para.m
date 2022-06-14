function para = fc_get_para(varargin)
if isempty(varargin)
    fname = 'init_para.xlsx';
else
    fname = varargin{1};
end

raw = readcell(fname);
para = num2cell(raw,2);
end