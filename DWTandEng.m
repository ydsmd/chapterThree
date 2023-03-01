function res = DWTandEng(X,Wavelet_Families)
%%
[cA, cD] = dwt(X, Wavelet_Families);
En0 = cA'*cA;
En1 = cD'*cD;
[cA1, cD1] = dwt(cA, Wavelet_Families);
En2 = cA1'*cA1;
[cA2, cD2] = dwt(cA1, Wavelet_Families);
En3 = cA2'*cA2;
[cA3, cD3] = dwt(cA2, Wavelet_Families);
En4 = cA3'*cA3;
[cA4, cD4] = dwt(cA3, Wavelet_Families);
En5 = cA4'*cA4;
[cA5, cD5] = dwt(cA4, Wavelet_Families);
En6 = cA5'*cA5;
[cA6, cD6] = dwt(cA5, Wavelet_Families);
En7 = cA6'*cA6;
res = [En0,En1,En2,En3,En4,En5,En6,En7];

end