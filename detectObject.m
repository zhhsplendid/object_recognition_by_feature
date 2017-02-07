function [ output_args ] = detectObject( im1, im2 )
% detect image1 in image2
% I use ratio match, thresholded nearest and then checked by ransac
    NEAREST_THRES = 0.8;
    RATIO_THRES = 0.6;

    [f1, d1] = vl_sift(im1);
    [f2, d2] = vl_sift(im2);
    
    [nearestMatch, nearestScore] = thresMatch(d1, d2, NEAREST_THRES);
    nearestD1 = d1(:, nearestMatch(1,:));
    nearestD2 = d2(:, nearestMatch(2,:));
    
    [ratioNearestMatch, ratioScore] = ratioMatch(nearestD1, nearestD2, RATIO_THRES);
    ratioD1 = nearestD1(:, ratioNearestMatch(1,:));
    ratioD2 = nearestD1(:, ratioNearestMatch(2,:));
    
    beforeRansacMatch = zeros(2, size(ratioNearestMatch, 2));
    beforeRansacMatch(1,:) = nearestMatch(1, ratioNearestMatch(1,:));
    beforeRansacMatch(2,:) = nearestMatch(2, ratioNearestMatch(2,:));
    
    corresPoints1 = [f1(1, beforeRansacMatch(1,:)) ; f1(2, beforeRansacMatch(1,:)) ]';
    corresPoints2 = [f2(1, beforeRansacMatch(2,:)) ; f2(2, beforeRansacMatch(2,:)) ]';
    
    [row, col] = size(im2);
    distThres = (row + col) / 10;
    
    
    [affineH, inlineMatch] = ransac(  corresPoints1, corresPoints2, distThres);
    
    [height, width] = size(im1);
    [hMax, wMax] = size(im2);
    corners = zeros(2, 4);
    [corners(1,1), corners(2,1)] = affineTrans(1, 1, affineH);
    [corners(1,2), corners(2,2)] = affineTrans(1, height, affineH);
    [corners(1,3), corners(2,3)] = affineTrans(width, 1, affineH);
    [corners(1,4), corners(2,4)] = affineTrans(width, height, affineH);
    
    
    
    
    numRatioMatch = size(ratioNearestMatch, 2);
    
    clf;
    subplot(1, 2, 1);
    imshow(im1);
    
    subplot(1, 2, 2);
    imshow(im2);
    if affineH ~= zeros(2, 3) && draw   % have object in image2
        drawRectangle(corners, 'red');
    end
    title('Matched Object in The Image');
    
    fprintf(['Showing the matched object in image. Number of Ratio Matching is ', ...
        num2str(numRatioMatch), ' Type dbcont to continue.\n']);
    keyboard;
    
end

