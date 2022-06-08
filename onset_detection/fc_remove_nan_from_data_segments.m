function data_segments = fc_remove_nan_from_data_segments(data_segments,val)
if isa(val,'function_handle')
    data_segments = cellfun(@(d)remove_nan_with_function_output(d,val),data_segments,'UniformOutput',false);
else
    data_segments = cellfun(@(d)remove_nan(d,val),data_segments,'UniformOutput',false);
end
end

function d = remove_nan(d,v)
d(isnan(d))= v;
end
function d = remove_nan_with_function_output(d,fc)
d(isnan(d))= fc(d);
end