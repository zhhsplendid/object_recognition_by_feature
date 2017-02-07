function [retX, retY] = affineTrans(x, y, h)
  % Return affine transformation h of a point
  
  p = [x; y; 1];
  w = h * p;
  retX = w(1, 1);
  retY = w(2, 1);

end