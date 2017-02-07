function [ matches, scores ] = ratioMatch( descriptors1, descriptors2, fraction )
% This funtion inputs two sets of descriptors. For each descriptor d1 in
% descriptors1, we calculate the Eyclidean distances between all descriptors in
% descritptors2. Then, we compute the mean distance of d1.

% We match the d1 to the nearest d2 in descriptors2. Then, if distance
% between d1 and d2 is larger than d1 to second nearest distance. We eliminate
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
  
  [sort_dists, sort_pos] = sort(distances, 2); %size n1 * n2
  
  remain_index = find(sort_dists(:,1) < sort_dists(:,2) * fraction);
  matches = [ remain_index'; sort_pos(remain_index, 1)' ];
  scores = sort_dists(remain_index)';
end

