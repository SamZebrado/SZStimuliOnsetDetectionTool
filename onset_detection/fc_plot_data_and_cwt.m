function fc_plot_data_and_cwt(d,varargin)
switch length(varargin)
    case 0
    figure;
    axes = arrayfun(@(s)subplot(3,1,s),[1,2,3]);
    case 1
    figure(varargin{1});
    axes = arrayfun(@(s)subplot(3,1,s),[1,2,3]);
    case 2
    figure(varargin{1});
    axes = varargin{2};
end

% set(gcf,'Position',[1 58 1440 739])
subplot(axes(1));
plot(d);
title ('Data')
a = abs(cwt(d));
subplot(axes(2));
plot(a')
xt = xticks;
xtl = xticklabels;
xl = xlim;
title('Amplitude after Wavelet Transformation (by function cwt)')

subplot(axes(3));
title('Amplitude after Wavelet Transformation (by function cwt)')
imagesc(a)
xticks(xt)
xticklabels(xtl)
xlim(xl)
end