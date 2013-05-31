% function dist = GetL1Dist(features, test, alpha)
% 
% calculate L1 distance of test and features
% featuers: nxk, n is sample numbers, k is dimension
% test: 1xk vector
% alpha: scale of features
%
% return: nx1 distances
function dist = GetL1Dist(features, test, alpha, weights)

testVec = ones(size(features,1),1) * test;
distVec = abs(features - testVec);
% distVec(:,1) = 0;
dist = sum(distVec, 2);
dist = dist / alpha;