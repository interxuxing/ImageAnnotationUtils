function [results] = evalRetrieval( wPred, wTrue )
%
% [results] = evalRetrieval( wPred, wTrue )
% 	results include: prec,rec, mAp, mRec, mAp_ret,mRec_ret
% Precision and recall scores for image annotation problem.
% Input:
%   wPred:   a Ndict x Nsample matrix of predicted indicators.
%            Entry wPred(i,j) is 1 iff i-th image is annotated
%            with keyword j.
%   wTrue:   a Nsample x Nwords matrix of true indicators. Same
%            structure as wPred.
%
% Output:
%   prec:    precision vector, per keyword.
%   rec:     recall vector, per keyword.
%	mAp:     mean precision of all keywords.
%	mRec:    mean recall of all keywords.
% Note:
%   One typically reports average precision and recall, mean(prec)
%   and mean(rec), or average scores for retreived keywords, 
%   mean(prec(prec>0)) and mean(rec(rec>0)).
%
%
% Compute performance scores "precision, recall, mean precision, mean recall".
%
% Modified by Xing Xu, xing.xu@ieee.org
%
intersect = wPred.*wTrue;
fprintf('non_zero elements: %d \n', length(find(intersect ~= 0)));

hit  = sum(intersect,1);
pred = sum(wPred,1);
true = sum(wTrue,1);

prec = hit ./ (pred+eps);
rec  = hit ./ (true+eps);

mAp = mean(prec);
mRec = mean(rec);

mAp_ret = mean(prec(prec > 0));
mRec_ret = mean(rec(rec > 0));

N_plus = length(find(sum(wPred,1) ~= 0));

%return evaluation results
results.prec = prec;
results.rec = rec;
results.mAp = mAp;
results.mRec = mRec;
results.mAp_ret = mAp_ret;
results.mRec_ret = mRec_ret;
results.N_plus = N_plus;