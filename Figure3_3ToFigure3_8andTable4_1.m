%%%%%
%在运行前需要先加载数据集文件夹
%%%%
clc;clear;
Crusie_set=[10e-3 20e-3 30e-3 40e-3 50e-3];
vkmh_set = [50 60 70 80 90 100];
N_set = [6 7 8 9 10];
Featureset = zeros(66,9);
Labelset = zeros(66,1);
Labelset(1:30)= 1;
Labelset(31:60)= 2;
Labelset(61:66)= 0;
num = 1;
k= 1;
position = 210*0.5;
Wavelet_Families = 'dmey';
for i = 1 : length(vkmh_set)
    v = vkmh_set(i)/3.6;
    mid = position/(v);
    mid2 = (position+2.6)/(v);
    period = pi*0.42/(v);
    part1 = round((mid-period)/(1e-3)):round((mid+period)/(1e-3));
    for j = 1:length(Crusie_set)
        eval(['load Crusie_',num2str(Crusie_set(j)),'_spd_',num2str(vkmh_set(i)),'_onW1.mat']);
        xp1 = ACC(part1);
        tp1 = time(part1);
        X = xp1;
        tmpres = DWTandSamp(X,Wavelet_Families,2,0.25);
        Featureset(num,:) = [tmpres,vkmh_set(i)];
        num = num+1;
    end

end

for i = 1 : length(vkmh_set)
    v = vkmh_set(i)/3.6;
    mid = position/(v);
    mid2 = (position+2.6)/(v);
    period = pi*0.42/(v);
    part1 = round((mid-period)/(1e-3)):round((mid+period)/(1e-3));
    for j = 1:length(N_set)
        eval(['load Poly_',num2str(N_set(j)),'_spd_',num2str(vkmh_set(i)),'_onW1.mat']);
        xp1 = ACC(part1);
        tp1 = time(part1);

        X = xp1;
%         tmpres = DWTandApp(X,Wavelet_Families,2,0.25);
        tmpres = DWTandSamp(X,Wavelet_Families,2,0.25);
        Featureset(num,:) = [tmpres,vkmh_set(i)];
        num = num+1;
    end

end

for i = 1 : length(vkmh_set)
    v = vkmh_set(i)/3.6;
    mid = position/(v);
    mid2 = (position+2.6)/(v);
    period = pi*0.42/(v);
    part1 = round((mid-period)/(1e-3)):round((mid+period)/(1e-3));
    eval(['load Good_spd_',num2str(vkmh_set(i)),'_onW1.mat']);
    xp1 = ACC(part1);
    tp1 = time(part1);
    X = xp1;
    tmpres = DWTandSamp(X,Wavelet_Families,2,0.25);
    Featureset(num,:) = [tmpres,vkmh_set(i)];
    num = num+1;
end

% 
v = 80;
tmpdataset = Featureset(Featureset(:,9)==v,:);
tmplabel = Labelset(Featureset(:,9)==v,:);
dwtindex = {'cD','cA','cA1','cA2','cA3','cA4','cA5','cA6'};
for index = 1:8
Z = zeros(5,3);
Z(:,1) = tmpdataset(1:5,index);
Z(:,2) = tmpdataset(6:10,index);
Z(:,3) = tmpdataset(11,index) * ones(5,1);
h = figure(index);
b = bar3(Z);
for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end
colorbar
view(-60,20);
ylabel('损伤程度','Fontname','宋体','FontSize',18);
xlabel('损伤类型','Fontname','宋体','FontSize',18);
zlabel(dwtindex{index},'Fontname','宋体','FontSize',18);
set(gca,'yticklabel',{'10mm/6阶','20mm/7阶','30mm/8阶','40mm/9阶','50mm/10阶'},'FontSize',18);
set(gca,'xticklabel',{'擦伤','多边形','健康'},'FontSize',18);
set(h,'position',[150,100,750,650]);
end


%% figure3.3
load Good_spd_50_onW1.mat
v = 50/3.6;
mid = 105/(v);
mid2 = 107.6/(v);
period = pi*0.42/(v);
part1 = round((mid-period)/(1e-3)):round((mid+period)/(1e-3));
part2 = round((mid2-period)/(1e-3)):round((mid2+period)/(1e-3));
xp1 = ACC(part1);
tp1 = time(part1);
xp2 = ACC(part2);
tp2 = time(part2);
plot(time,ACC,'Color',[142 207 201]/255)
hold on
plot(tp1,xp1,'Color',[250 127 111]/255)
hold on
plot(tp2,xp2,'Color',[130 176 210]/255)
xlabel('时间t(s)','FontSize',18);
ylabel('加速度(m/s²)','FontSize',18);
legend('','前轴','后轴','FontSize',18);
xlim([7.35 8])
prettyAxes().ggray2()
% 
% %figure3.4
% Wavelet_Families = 'dmey';
% [cA, cD] = dwt(xp1, Wavelet_Families);
% h = figure(1)
% plot(cA)
% ylabel('幅值(m/s²)','FontSize',18);
% xlabel('采样点数(个)','FontSize',18);
% title('第一次分解近似分量cA','FontSize',18);
% h2 = figure(2)
% figure(2)
% subplot(211)
% plot(cA)
% ylabel('幅值(m/s²)','FontSize',18);
% xlabel('采样点数(个)','FontSize',18);
% title('第一次分解近似分量cA','FontSize',18);
% 
% subplot(212)
% plot(cD)
% ylabel('幅值(m/s²)','FontSize',18);
% xlabel('采样点数(个)','FontSize',18);
% title('第一次分解细节分量cD','FontSize',18);


%figure3.5
load Good_spd_50_onW1.mat
v = 50/3.6;
mid = 105/(v);
mid2 = 107.6/(v);
period = pi*0.42/(v);
part1 = round((mid-period)/(1e-3)):round((mid+period)/(1e-3));
xp1 = ACC(part1);
X = xp1';dim = 2;r = 0.25;
Wavelet_Families = 'dmey';
[cA, cD] = dwt(X, Wavelet_Families);
ApcA1 = SampEn(cA,dim,r*std(cA));
[cA1, cD1] = dwt(cA, Wavelet_Families);
ApcA2 = SampEn(cA1,dim,r*std(cA1));
[cA2, cD2] = dwt(cA1, Wavelet_Families);
ApcA3 = SampEn(cA2,dim,r*std(cA2));
[cA3, cD3] = dwt(cA2, Wavelet_Families);
ApcA4 = SampEn(cA3,dim,r*std(cA3));
[cA4, cD4] = dwt(cA3, Wavelet_Families);
ApcA5 = SampEn(cA4,dim,r*std(cA4));
[cA5, cD5] = dwt(cA4, Wavelet_Families);
ApcA6 = SampEn(cA5,dim,r*std(cA5));
[cA6, cD6] = dwt(cA5, Wavelet_Families);
ApcA7 = SampEn(cA6,dim,r*std(cA6));
ApcA0 = SampEn(cD,dim,r*std(cD));
res1 = [ApcA0,ApcA1,ApcA2,ApcA3,ApcA4,ApcA5,ApcA6,ApcA7];
h3  = figure()
subplot(421)
plot(cA)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cA','FontSize',12);
subplot(422)
plot(cD)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cD','FontSize',12);
subplot(423)
plot(cA1)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cA1','FontSize',12);
subplot(424)
plot(cA2)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cA2','FontSize',12);
subplot(425)
plot(cA3)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cA3','FontSize',12);
subplot(426)
plot(cA4)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cA4','FontSize',12);
subplot(427)
plot(cA5)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cA5','FontSize',12);
subplot(428)
plot(cA6)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cA6','FontSize',12);
set(h3,'position',[150,20,750,950]);


%% figure3.6
load Poly_6_spd_50_onW1.mat
v = 50/3.6;
mid = 105/(v);
mid2 = 107.6/(v);
period = pi*0.42/(v);
part1 = round((mid-period)/(1e-3)):round((mid+period)/(1e-3));
part2 = round((mid2-period)/(1e-3)):round((mid2+period)/(1e-3));
xp1 = ACC(part1);
tp1 = time(part1);

X = xp1';dim = 2;r = 0.25;
Wavelet_Families = 'dmey';
[cA, cD] = dwt(X, Wavelet_Families);
ApcA1 = SampEn(cA,dim,r*std(cA));
[cA1, cD1] = dwt(cA, Wavelet_Families);
ApcA2 = SampEn(cA1,dim,r*std(cA1));
[cA2, cD2] = dwt(cA1, Wavelet_Families);
ApcA3 = SampEn(cA2,dim,r*std(cA2));
[cA3, cD3] = dwt(cA2, Wavelet_Families);
ApcA4 = SampEn(cA3,dim,r*std(cA3));
[cA4, cD4] = dwt(cA3, Wavelet_Families);
ApcA5 = SampEn(cA4,dim,r*std(cA4));
[cA5, cD5] = dwt(cA4, Wavelet_Families);
ApcA6 = SampEn(cA5,dim,r*std(cA5));
[cA6, cD6] = dwt(cA5, Wavelet_Families);
ApcA7 = SampEn(cA6,dim,r*std(cA6));
ApcA0 = SampEn(cD,dim,r*std(cD));
res2 = [ApcA0,ApcA1,ApcA2,ApcA3,ApcA4,ApcA5,ApcA6,ApcA7];
h3  = figure()

subplot(421)
plot(cA)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cA','FontSize',12);
subplot(422)
plot(cD)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cD','FontSize',12);
subplot(423)
plot(cA1)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cA1','FontSize',12);
subplot(424)
plot(cA2)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cA2','FontSize',12);
subplot(425)
plot(cA3)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cA3','FontSize',12);
subplot(426)
plot(cA4)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cA4','FontSize',12);
subplot(427)
plot(cA5)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cA5','FontSize',12);
subplot(428)
plot(cA6)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cA6','FontSize',12);
set(h3,'position',[150,20,750,950]);

%% figure3.7
load Crusie_0.02_spd_50_onW1.mat
v = 50/3.6;
mid = 105/(v);
mid2 = 107.6/(v);
period = pi*0.42/(v);
part1 = round((mid-period)/(1e-3)):round((mid+period)/(1e-3));
part2 = round((mid2-period)/(1e-3)):round((mid2+period)/(1e-3));
xp1 = ACC(part1);
tp1 = time(part1);

X = xp1';dim = 2;r = 0.25;
Wavelet_Families = 'dmey';
[cA, cD] = dwt(X, Wavelet_Families);
ApcA1 = SampEn(cA,dim,r*std(cA));
[cA1, cD1] = dwt(cA, Wavelet_Families);
ApcA2 = SampEn(cA1,dim,r*std(cA1));
[cA2, cD2] = dwt(cA1, Wavelet_Families);
ApcA3 = SampEn(cA2,dim,r*std(cA2));
[cA3, cD3] = dwt(cA2, Wavelet_Families);
ApcA4 = SampEn(cA3,dim,r*std(cA3));
[cA4, cD4] = dwt(cA3, Wavelet_Families);
ApcA5 = SampEn(cA4,dim,r*std(cA4));
[cA5, cD5] = dwt(cA4, Wavelet_Families);
ApcA6 = SampEn(cA5,dim,r*std(cA5));
[cA6, cD6] = dwt(cA5, Wavelet_Families);
ApcA7 = SampEn(cA6,dim,r*std(cA6));
ApcA0 = SampEn(cD,dim,r*std(cD));
res3 = [ApcA0,ApcA1,ApcA2,ApcA3,ApcA4,ApcA5,ApcA6,ApcA7];
h3  = figure()
subplot(421)
plot(cA)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cA','FontSize',12);
subplot(422)
plot(cD)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cD','FontSize',12);
subplot(423)
plot(cA1)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cA1','FontSize',12);
subplot(424)
plot(cA2)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cA2','FontSize',12);
subplot(425)
plot(cA3)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cA3','FontSize',12);
subplot(426)
plot(cA4)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cA4','FontSize',12);
subplot(427)
plot(cA5)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cA5','FontSize',12);
subplot(428)
plot(cA6)
ylabel('幅值(m/s²)','FontSize',12);
xlabel('采样点数(个)','FontSize',12);
title('cA6','FontSize',12);
set(h3,'position',[150,20,750,950]);

table4_1 = [res1;res2;res3];