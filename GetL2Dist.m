% function dist = GetL2Dist(features, test, alpha)
% 
% calculate L2 distance of test and features
% featuers: nxk, n is sample numbers, k is dimension
% test: 1xk vector
% alpha: scale of features
%
% return: nx1 distances

function dist = GetL2Dist(features, test, alpha)
testVec = ones(size(features,1),1) * test;
distVec = abs(features - testVec);
% distVec(:,1) = 0;
distVec = distVec.^2;
dist = sum(distVec, 2);
% normalize, assume that each feature contributes equally
dist = dist / alpha; 