function matchComparison(im1, im2)
% input 2 gray scale images and display matching feature results for three
% scenarios:
%   Thresholded nearest neighbors
%   Thresholded ratio test
%   Inliers
    
    NEAREST_THRES = 0.8;
    RATIO_THRES = 0.6;

    [f1, d1] = vl_sift(im1);
    [f2, d2] = vl_sift(im2);
    
    %   Thresholded nearest neighbors
    [nearestMatch, nearestScore] = thresMatch(d1, d2, NEAREST_THRES);
    clf;
    showLinesBetweenMatches(im1, im2, f1, f2, [nearestMatch; nearestScore]);
    fprintf('Showing the thresholed nearest matches with lines connecting.  Type dbcont to continue.\n');
    keyboard;
    
    %   Thresholded ratio test
    [ratioNearestMatch, ratioScore] = ratioMatch(d1, d2, RATIO_THRES);
    %[ratioNearestMatch, ratioScore] = vl_ubcmatch(d1, d2, 1 / RATIO_THRES);
    clf;
    showLinesBetweenMatches(im1, im2, f1, f2, [ratioNearestMatch; ratioScore]);
    fprintf('Showing the thresholded ratio matches with lines connecting.  Type dbcont to continue.\n');
    keyboard;
    
    %   Inliers
    
    %This match doesn't eliminate any because threshold = 2;
    [rawMatch, rawScore] = thresMatch(d1, d2, 2);
    %Get position of matched points
    corresPoints1 = [f1(1, rawMatch(1,:)) ; f1(2, rawMatch(1,:)) ]';
    corresPoints2 = [f2(1, rawMatch(2,:)) ; f2(2, rawMatch(2,:)) ]';
    
    [row, col] = size(im2);
    distThres = (row + col) / 10;
    [affine, inlineMatch] = ransac(  corresPoints1, corresPoints2, distThres);
    
    ransacMatch = rawMatch(:, inlineMatch);
    ransacScore = rawScore(inlineMatch);
    
    clf;
    showLinesBetweenMatches(im1, im2, f1, f2, [ransacMatch; ransacScore]);
    fprintf('Showing the inliner matches with lines connecting.  Type dbcont to continue.\n');
    keyboard;
    
    

end

