function res = DWTandApp(X,Wavelet_Families,dim,r)
%% 
% X——数据本身
% Wavelet_Families——小波族
% dim——维度，一般取2
% r——关联维数，取0.25
%%
X=X';
[cA, cD] = dwt(X, Wavelet_Families);
ApcA1 = ApproximateEntropy(dim,r*std(cA),cA);
[cA1, cD1] = dwt(cA, Wavelet_Families);
ApcA2 = ApproximateEntropy(dim,r*std(cA1),cA1);
[cA2, cD2] = dwt(cA1, Wavelet_Families);
ApcA3 = ApproximateEntropy(dim,r*std(cA2),cA2);
[cA3, cD3] = dwt(cA2, Wavelet_Families);
ApcA4 = ApproximateEntropy(dim,r*std(cA3),cA3);
[cA4, cD4] = dwt(cA3, Wavelet_Families);
ApcA5 = ApproximateEntropy(dim,r*std(cA4),cA4);
[cA5, cD5] = dwt(cA4, Wavelet_Families);
ApcA6 = ApproximateEntropy(dim,r*std(cA5),cA5);
[cA6, cD6] = dwt(cA5, Wavelet_Families);
ApcA0 = ApproximateEntropy(dim,r*std(cD),cD);
ApcA7 = ApproximateEntropy(dim,r*std(cA6),cA6);
res = [ApcA0,ApcA1,ApcA2,ApcA3,ApcA4,ApcA5,ApcA6,ApcA7];

end