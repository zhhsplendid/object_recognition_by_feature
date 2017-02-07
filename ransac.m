function [ h, match ] = ransac(  corresPoints1, corresPoints2, distThres)
  % This function implements ransac for affine
  % returns inline affine h  and match: the 1 * k integer indexes indicates
  % those matched points.
  
  % For those points with distance greater than DistThres, we think it's
  % out line. We suggest use as imageSize / 10;
  n = size(corresPoints1, 1);
  REPEAT_TIME = n;
  
  CHOOSE_FRACTION = 0.3;
  NUMBER_PAIRS = 3; % At least 4 points can we get a affine
  DISTANCE_THRESHOLD = distThres ^ 2;
  INLINE_THRESHOLD = round(n * CHOOSE_FRACTION);
    
  bestError = Inf;
  h = zeros(2, 3);
  match = [];
  for i = 1: REPEAT_TIME;
    chooseIndex = randsample(n, NUMBER_PAIRS);
    modelPara1 = corresPoints1(chooseIndex, :);
    modelPara2 = corresPoints2(chooseIndex, :);
    maybeModel = affine(modelPara1, modelPara2);
    
    p1 = [corresPoints1, ones(n, 1)]';
   
    wp2 = maybeModel * p1;
    p2 = zeros(n, 2);
    p2(:,1) = (wp2(1,:) )';
    p2(:,2) = (wp2(2,:) )';
    
    euclideanDistSqur = sum( ((corresPoints2 - p2) .^ 2), 2); %size = n * 1
    chooseIndex = euclideanDistSqur < DISTANCE_THRESHOLD;
    
    inlineNumber = sum(chooseIndex);

    if inlineNumber > INLINE_THRESHOLD
      error = sum(euclideanDistSqur(chooseIndex)) / inlineNumber;
      if error < bestError
        
        modelPara1 = corresPoints1(chooseIndex, :);
        modelPara2 = corresPoints2(chooseIndex, :);
        h = affine(modelPara1, modelPara2);
        bestError = error;
        match = find(chooseIndex);
      end
    end
  end
  
  
end

