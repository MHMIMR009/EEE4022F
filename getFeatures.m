function [matchPoints1, matchPoints2] = getFeatures(I1,I2)
points1 = detectSURFFeatures(I1);
points2 = detectSURFFeatures(I2);

strong1 = points1.selectStrongest(300);
strong2 = points2.selectStrongest(300);

features1 = extractFeatures(I1, strong1,'Upright',true);
features2 = extractFeatures(I2, strong2,'Upright',true);

pairs = matchFeatures(features1,features2);
matchPoints1 = points1(pairs(:,1));
matchPoints2 = points2(pairs(:,2));
end