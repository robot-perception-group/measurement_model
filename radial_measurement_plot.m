clear;load radial_error_2runs.mat;
% binning
radius = 5:1:35;
for k = 1:length(radius)-1
       bins(k,:) = [radius(k),radius(k+1)];      
end
% computing standard deviation and variance
error_bins = {};
for k = 1:length(radius)-1
    ind = find(gt_distance_combined>=bins(k,1) & gt_distance_combined<bins(k,2));
    error_bins{k} = error_combined(ind);
    error_vars(k) = var(error_combined(ind));   
    error_std(k) = std(error_combined(ind));   
end
% curve fitting
f = fit(radius(1:length(bins))',transpose(error_vars),'a*x^2','StartPoint',5);

% plotting
figure(1);
plot(gt_distance_combined,error_combined,'x');
title('Noise in Measurement');
figure(2);hold on;
plot(f,radius(1:length(bins))',transpose(error_vars),'x');
title('Variance in Noise');