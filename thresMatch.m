function [ matches, scores ] = thresMatch( descriptors1, descriptors2, fraction )
% This funtion inputs two sets of descriptors. For each descriptor d1 in
% descriptors1, we calculate the Euclidean distances between all descriptors in
% descritptors2. Then, we compute the mean distance of d1.

% We match the d1 to the nearest d2 in descriptors2. Then, if distance
% between d1 and d2 is less than mean_distance * fraction. We eliminate
% this match
%
% inputs:
%   descriptor1, descriptor2: 
%     two dim * n descriptors, which dim is the dimension of each 
%     descriptor, n is the number of descriptors
%   fraction: a number to eliminate dis > mean_distance * fraction
% outputs:
%   matches: a 2 * k integer numbers to indicate which pair of descriptors
%     are matched
%   scores: 1 * k double to indicate the matching distances
   
  distances = dist2(double(descriptors1'), double(descriptors2')); %size n1 * n2
  [n1, n2] = size(distances);
  
  [min_dists, min_pos] = min(distances, [], 2); %size n1 * 1
  mean_dists = sum(distances, 2) / n2;
  
  remain_index = find(min_dists < mean_dists * fraction);
  matches = [ remain_index'; min_pos(remain_index)' ];
  scores = min_dists(remain_index)';
end

