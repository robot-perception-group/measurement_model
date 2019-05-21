%% Binning
clear;load bearing_error.mat
% binning
bearing = -pi/2:0.1:pi/2;
for k = 1:length(bearing)-1
       bins(k,:) = [bearing(k),bearing(k+1)];      
end
% computing standard deviation and variance
error_bins = {};
for k = 1:length(bins)
    ind = find(gt_bearing>=bins(k,1) & gt_bearing<bins(k,2));
    error_bins{k} = error(ind);
    variance_stds(k) = std(error(ind));   
    variance_mean(k) = mean(error(ind));   
end
% plotting
figure(2);
polarplot(gt_bearing,error,'x');
title('Measurement Noise');
figure(3);
plot(bearing(1:length(bins))',transpose(variance_stds.^2),'x-');
title('Variance of Noise');
axis([-0.6,0.9,0,2*10^(-3)])