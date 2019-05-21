clear; load inclination_error.mat
% binning
inclination = -pi/2:0.1:pi/2;
for k = 1:length(inclination)-1
       bins(k,:) = [inclination(k),inclination(k+1)];      
end
% computing standard deviation and variance in each bin
variance_bins = {};
for k = 1:length(bins)
    ind = find(gt_inclination>=bins(k,1) & gt_inclination<bins(k,2));
    variance_bins{k} = error(ind);
    variance_stds(k) = std(error(ind));   
    variance_mean(k) = mean(error(ind));   
end
% plotting
figure(1);
polarplot(gt_inclination,error,'x');
title('Measurement Noise');
figure(2);
plot(inclination(1:length(bins))',transpose(variance_stds.^2),'x-');
title('Variance of Noise')
axis([0.5,1.3,0,5*10^(-3)])