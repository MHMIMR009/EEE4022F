%Experiment 13
%Estimating rectified F Dataset 4
images = imageSet('C:\Users\Imraan Mohamed\Documents\UCT 2019\Thesis\Experiment13\images','recursive');

%Projection matrix for left cam
PL = [7.070493e+02 0.000000e+00 6.040814e+02 0.000000e+00; 0.000000e+00 7.070493e+02 1.805066e+02 0.000000e+00; 0.000000e+00 0.000000e+00 1.000000e+00 0.000000e+00
];
%Projection matrix for right cam
PR = [7.070493e+02 0.000000e+00 6.040814e+02 -3.797842e+02; 0.000000e+00 7.070493e+02 1.805066e+02 0.000000e+00; 0.000000e+00 0.000000e+00 1.000000e+00 0.000000e+00];
P = {PL PR};
%Fundamental Matrix from P
F = vgg_F_from_P(P);

%Estimating fundamental matrix using average

Favg = cell(images(1).Count - 2,1);
F_pre_avg = cell(3,1);

for i = 2:(images(1).Count-1)
    I1 = read(images(1),(i));
    for j = 1:3
        I2 = read(images(2),(i-2)+j);
    
        [match1, match2] = getFeatures(I1, I2);
        F_pre_avg{j,1} = estimateFundamentalMatrix(match1,match2,'Method','LTS');
        
    end
    F_pre_sum = zeros(3,3);
    for k = 1:3
       F_pre_sum = F_pre_sum+F_pre_avg{k,1}; 
    end
    
    Favg{(i-1),1} = F_pre_sum/3;
end

Fsum = zeros(3,3);

for k = 1:size(Favg,1)
    Fsum = Fsum+Favg{k,1};
end

Fend = Fsum/size(Favg,1);

eFAct = zeros(30,1);
eEst = zeros(30,1);

images1 = imageSet('C:\Users\Imraan Mohamed\Documents\UCT 2019\Thesis\Experiment13\images','recursive');

for m = 1:30
    img1 = read(images1(1),15);
    img2 = read(images1(2),m);
    
    [matches1, matches2] = getFeatures(img1, img2);
    
    eFAct(m) = sampsonErrf(F,matches1.Location,matches2.Location);
    eEst(m) = sampsonErrf(Fend,matches1.Location,matches2.Location);
end

%Find frame index of actual offset
[MAct,IAct] = min(eFAct);

%Find frame index of estimated offset
[MEst,IEst] = min(eEst);

figure('Name','Offset estimation with Calibrated F','NumberTitle','off');
plot(eFAct);
title('Sampson Error vs frame number');
ylabel('Sampson Error');
xlabel('Frame index');
annotation('textbox', [0.5, 0.8, 0.1, 0.1], 'String', sprintf('Frame offset at frame index %d',IAct));
figure('Name','Offset estimation with Estimated F','NumberTitle','off');
plot(eEst);
title('Sampson Error vs frame number');
ylabel('Sampson Error');
xlabel('Frame index');
annotation('textbox', [0.5, 0.8, 0.1, 0.1], 'String', sprintf('Frame offset at frame index %d',IEst));