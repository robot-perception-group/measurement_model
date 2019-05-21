clc;clear;close all;
%%
filename = 'bearing_covariance_2_1_100_2_6_2019-05-20-12-16-46.bag.analysis/';
load(strcat(filename,'timing.mat'));

[v,actorstart] = min(abs(actortime.time-6e+10));
[v,tgtstart] = min(abs(tgttime.time-6e+10));

actorpose = csvread(strcat(filename,'actorpose.csv'),1,4,[1,4,length(actortime.time),6]);
robot_gt = csvread(strcat(filename,'robotgnd1.csv'),1,4,[1,4,length(robottime.time),6]);
targetpose = csvread(strcat(filename,'robotmeasurement1.csv'),1,4,[1,4,length(tgttime.time),6]);

%Using grount truth readings only when there are measurements for that
%instant
actorpose_synced = zeros(size(targetpose));
for k = 1:length(targetpose)
    [v,i] = min(abs(actortime.time-tgttime.time(k)));
    actorpose_synced(k,:) = actorpose(i,:);
end

robotgt_synced = zeros(size(targetpose));
for k = 1:length(targetpose)
    [v,i] = min(abs(robottime.time-tgttime.time(k)));
    robotgt_synced(k,:) = robot_gt(i,:);
end

% Calculating groundtruth distance to target
len = length(targetpose);
gt_diff = [actorpose_synced(:,2) - robotgt_synced(:,1),actorpose_synced(:,1) - robotgt_synced(:,2) ...
    ,actorpose_synced(:,3) - robotgt_synced(:,3)];
for k = 1:len
    gt_distance(k) = norm(gt_diff(k,:));
    gt_bearing(k) = atan2(gt_diff(k,2),gt_diff(k,1));
end
 
% Calculating estimated distance to target
estimate_diff = [-robotgt_synced(:,1) + targetpose(:,2),-robotgt_synced(:,2) + targetpose(:,1) ...
    ,-robotgt_synced(:,3) + targetpose(:,3)];
for k = 1:len
    measured_distance(k) = norm(estimate_diff(k,:));
    measured_bearing(k) = atan2(estimate_diff(k,2),estimate_diff(k,1));
end
error = abs(gt_bearing - measured_bearing);
save('bearing_error.mat','error','gt_bearing','measured_bearing');
