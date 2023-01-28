clear all;
data = xlsread('cov2.xlsx',1,'A1:C3');
corr_matrix = zeros(size(data,1),size(data,1));
corr_matrix = corrcov(data);
csvwrite('corr2.csv',corr_matrix);