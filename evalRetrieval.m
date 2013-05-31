function [prec,rec, mAp, mRec] = evalRetrieval( wPred, wTrue )
%
% [prec,rec] = evalRetrieval( wPred, wTrue )
% 
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

hit  = sum(wPred.*wTrue,1);
pred = sum(wPred,1);
true = sum(wTrue,1);

prec = hit ./ (pred+eps);
rec  = hit ./ (true+eps);

mAp = mean(prec(prec > 0));
mRec = mean(rec(rec > 0));
