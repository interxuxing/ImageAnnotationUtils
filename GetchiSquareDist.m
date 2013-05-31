% function csDistance = GetchiSquareDist(his1,his2_all)
%
% to calculate the Chi-square distance between hist1 and hist2_all
% his1 is a vector with dimension 1xk 
% his2_all is a group of vectors, nxk, n is number of vectors
%
% return nx1 distance value of hist1 with each vector in hist2_all
function csDistance = GetchiSquareDist(his1,his2_all)

[n_his,k_dim]=size(his2_all);

his1_all = ones(n_his,1)*his1;

temp_matrix = ((his1_all==0).*(his2_all==0));

his1_all = his1_all + temp_matrix;
his2_all = his2_all + temp_matrix;

temp = (his1_all-his2_all).^2./(his1_all+his2_all);

csDistance = sum(temp,2);