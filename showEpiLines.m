%Function to show Epipolar Lines

function showEpiLines(F,I1,I2,inliers1,inliers2)
epiLines1 = epipolarLine(F',inliers2.Location);
points1 = lineToBorderPoints(epiLines1,size(I1));

figure('visible','off');
imshow(I1);
hold on;
line(points1(:,[1,3])',points1(:,[2,4])');
f1 = getframe(gcf);

epiLines2 = epipolarLine(F,inliers1.Location);
points2 = lineToBorderPoints(epiLines2,size(I2));

figure('visible','off');
imshow(I2);
hold on;
line(points2(:,[1,3])',points2(:,[2,4])');
f2 = getframe(gcf);

figure();
imshowpair(f1.cdata,f2.cdata,'montage');
end