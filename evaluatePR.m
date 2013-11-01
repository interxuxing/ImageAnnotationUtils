function [results]= evaluatePR(GTs, PREDs, topK)
%
% Usage: [results]= evaluatePR(GTs, PREDs, topK)
%   results includes: prec, rec, f1, retrieved, f1Ind, precInd, recInd
% Input:
%	GTs: K x n matrix containing the groundtruth (0, 1)
%	PREDs: K x n matrix containing the prediction confidence (real values)
%	topK: number of tags given to each image
% Output: prec, rec, f1, N+, etc
%


GTs = (GTs>0);
% compute precision, recall and N+ at top 5 annotations
hardPREDs = zeros(size(PREDs));
for n = 1:size(GTs, 2)
        gt = GTs(:, n);
        confidence = PREDs(:, n);
        [so, si] = sort(-confidence);
        si = si(1:topK);
	hardPREDs(si, n) = 1;
end
precInd = sum(hardPREDs.*GTs, 2)./max(sum(hardPREDs, 2), eps);
prec = mean(precInd);

recInd = sum(hardPREDs.*GTs, 2)./max(sum(GTs, 2), eps);
rec = mean(recInd);

f1Ind = 2*precInd.*recInd./max(precInd+recInd, eps);
f1 = 2*prec*rec/(prec+rec);

retrievedInd = sum(hardPREDs.*GTs, 2)>0;
retrieved = sum(retrievedInd>0);

% return evaluation result
results.prec = prec;
results.rec = rec;
results.f1 = f1;
results.retrieved = retrieved;
results.f1Ind = f1Ind;
results.precInd = precInd;
results.recInd = recInd;