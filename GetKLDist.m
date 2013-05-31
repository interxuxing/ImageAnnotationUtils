% function dist = GetKLDist(features, test, alpha)
% 
% calculate KL distance of test and features
% featuers: nxk, n is sample numbers, k is dimension
% test: 1xk vector
% alpha: scale of features
%
% return: nx1 distances

function dist = GetKLDist(features, test, alpha)
testVec = ones(size(features,1),1) * test;
id1 = find(features == 0);
id2 = find(testVec == 0);
features(id1) = 10^-5;
testVec(id2) = 10^-5;
distVec = testVec.*(log2(testVec) - log2(features));
% distVec(:,1) = 0;
dist = sum(distVec, 2);
dist = dist / alpha;
