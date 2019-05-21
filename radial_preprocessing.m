clc;clear;close all;
%%
filename = 'radial_covariance_5_1_100_5_6_2019-05-20-18-02-49.bag.analysis/'; 
load(strcat(filename,'timing.mat'));

[v,actorstart] = min(abs(actortime.time-6e+10));
[v,tgtstart] = min(abs(tgttime.time-6e+10));

actorpose = csvread(strcat(filename,'actorpose.csv'),1,4,[1,4,length(actortime.time),6]);
robot_gt = csvread(strcat(filename,'robotgnd1.csv'),1,4,[1,4,length(robottime.time),6]);
robot_estimated = csvread(strcat(filename,'robotpose1.csv'),1,4,[1,4,length(robot_estimated_time.time),6]);
targetpose = csvread(strcat(filename,'robotmeasurement1.csv'),1,4,[1,4,length(tgttime.time),6]);


%Using grount truth readings only when there are measurements for that
%time instant
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

robotest_synced = zeros(size(targetpose));
for k = 1:length(targetpose)
    [v,i] = min(abs(robot_estimated_time.time-tgttime.time(k)));
    robotest_synced(k,:) = robot_estimated(i,:);
end

% Calculating groundtruth distance to target
len = length(targetpose);
gt_diff = [actorpose_synced(:,2) - robotgt_synced(:,1),actorpose_synced(:,1) - robotgt_synced(:,2) ...
    ,actorpose_synced(:,3) - robotgt_synced(:,3)];
for k = 1:len
    gt_distance_1(k) = norm(gt_diff(k,:));
end
 
% Calculating measured distance to target
estimate_diff = [robotest_synced(:,1) - targetpose(:,2),robotest_synced(:,2) - targetpose(:,1) ...
    ,robotest_synced(:,3) - targetpose(:,3)];
for k = 1:len
    measured_distance_1(k) = norm(estimate_diff(k,:));
end
error_1 = abs(gt_distance_1(:) - measured_distance_1(:));

%%
filename = 'radial_covariance_6_1_100_6_6_2019-05-20-19-36-04.bag.analysis/'; 
load(strcat(filename,'timing.mat'));

[v,actorstart] = min(abs(actortime.time-6e+10));
[v,tgtstart] = min(abs(tgttime.time-6e+10));

actorpose = csvread(strcat(filename,'actorpose.csv'),1,4,[1,4,length(actortime.time),6]);
robot_gt = csvread(strcat(filename,'robotgnd1.csv'),1,4,[1,4,length(robottime.time),6]);
robot_estimated = csvread(strcat(filename,'robotpose1.csv'),1,4,[1,4,length(robot_estimated_time.time),6]);
targetpose = csvread(strcat(filename,'robotmeasurement1.csv'),1,4,[1,4,length(tgttime.time),6]);


%Using grount truth readings only when there are measurements for that
%time instant
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

robotest_synced = zeros(size(targetpose));
for k = 1:length(targetpose)
    [v,i] = min(abs(robot_estimated_time.time-tgttime.time(k)));
    robotest_synced(k,:) = robot_estimated(i,:);
end

% Calculating groundtruth distance to target
len = length(targetpose);
gt_diff = [actorpose_synced(:,2) - robotgt_synced(:,1),actorpose_synced(:,1) - robotgt_synced(:,2) ...
    ,actorpose_synced(:,3) - robotgt_synced(:,3)];
for k = 1:len
    gt_distance_2(k) = norm(gt_diff(k,:));
end
 
% Calculating measured distance to target
estimate_diff = [robotest_synced(:,1) - targetpose(:,2),robotest_synced(:,2) - targetpose(:,1) ...
    ,robotest_synced(:,3) - targetpose(:,3)];
for k = 1:len
    measured_distance_2(k) = norm(estimate_diff(k,:));
end
error_2 = abs(gt_distance_2(:) - measured_distance_2(:));
%%
error_combined = [error_1;error_2];
gt_distance_combined = [gt_distance_1,gt_distance_2];
measured_distance_combined = [measured_distance_1,measured_distance_2];
save('radial_error_2runs.mat','error_combined','gt_distance_combined','measured_distance_combined')
