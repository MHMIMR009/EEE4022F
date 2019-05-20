%Get Fundamental Matrix
function F = vgg_F_from_P(P, P2)

if nargin == 1
  P1 = P{1};
  P2 = P{2};
else
  P1 = P;
end

X1 = P1([2 3],:);
X2 = P1([3 1],:);
X3 = P1([1 2],:);
Y1 = P2([2 3],:);
Y2 = P2([3 1],:);
Y3 = P2([1 2],:);

F = [det([X1; Y1]) det([X2; Y1]) det([X3; Y1])
     det([X1; Y2]) det([X2; Y2]) det([X3; Y2])
     det([X1; Y3]) det([X2; Y3]) det([X3; Y3])];

return
end