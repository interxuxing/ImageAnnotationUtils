function [area, area2] = evalAUC(fpr,tpr)
% [area, area2] = mlr_auc(fpr,tpr)
% Claculates area under roc curve
% tpr and fpr vaalues are calculated by evalROC function. for more info.,
% write "help evalROC"


sizes=max(size(fpr));
area=0;
for i=1:(sizes-1)
    area=area+(fpr(i+1)-fpr(i))*(tpr(i+1)+tpr(i))/2;
end

area=area/(fpr(sizes)-fpr(1));

area2=abs(trapz(fpr,tpr));
