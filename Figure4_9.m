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
position = 210*0.45;
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
        tmpres = DWTandApp(X,Wavelet_Families,2,0.25);
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
        tmpres = DWTandApp(X,Wavelet_Families,2,0.25);
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
    tmpres = DWTandApp(X,Wavelet_Families,2,0.25);
    Featureset(num,:) = [tmpres,vkmh_set(i)];
    num = num+1;
end
%% cD
for i = 1 : length(vkmh_set)
v = vkmh_set(i);
tmpdataset = Featureset(Featureset(:,9)==v,:);
tmplabel = Labelset(Featureset(:,9)==v,:);
y1 = tmpdataset(1:5,1);
y2 = tmpdataset(6:10,1);
y3 = tmpdataset(11,1);
h = figure(1)
H = plot(v,y1,'r*',v,y2,'b^',v,y3,'co');
hold on 
end
xlabel('速度V(km/h)','FontSize',18);
ylabel('样本熵SampEn','FontSize',18);
title('cD分量的样本熵分布 ','FontSize',18);
plot([40:110],0.525*ones(1,71),'--m');
legend(H([1 6 11]),'擦伤','多边形','健康');
set(h,'position',[150,100,650,650]);

%% cA
for i = 1 : length(vkmh_set)
v = vkmh_set(i);
tmpdataset = Featureset(Featureset(:,9)==v,:);
tmplabel = Labelset(Featureset(:,9)==v,:);
y1 = tmpdataset(1:5,2);
y2 = tmpdataset(6:10,2);
y3 = tmpdataset(11,2);
h = figure(1)
H = plot(v,y1,'r*',v,y2,'b^',v,y3,'co');
hold on 
end
xlabel('速度V(km/h)','FontSize',18);
ylabel('样本熵SampEn','FontSize',18);
title('cA分量的样本熵分布 ','FontSize',18);
plot([40,70],[0.58,0.7],'--m');
hold on
plot([70,110],[0.7,0.6],'--m');
legend(H([1 6 11]),'擦伤','多边形','健康');
set(h,'position',[150,100,650,650]);

%% cA1
for i = 1 : length(vkmh_set)
v = vkmh_set(i);
tmpdataset = Featureset(Featureset(:,9)==v,:);
tmplabel = Labelset(Featureset(:,9)==v,:);
y1 = tmpdataset(1:5,3);
y2 = tmpdataset(6:10,3);
y3 = tmpdataset(11,3);
h = figure(1)
H = plot(v,y1,'r*',v,y2,'b^',v,y3,'co');
hold on 
end
xlabel('速度V(km/h)','FontSize',18);
ylabel('样本熵SampEn','FontSize',18);
title('cA_{1}分量的样本熵分布 ','FontSize',18);
legend(H([1 6 11]),'擦伤','多边形','健康');
set(h,'position',[150,100,650,650]);
xlim([40 110])
%% cA5
for i = 1 : length(vkmh_set)
v = vkmh_set(i);
tmpdataset = Featureset(Featureset(:,9)==v,:);
tmplabel = Labelset(Featureset(:,9)==v,:);
y1 = tmpdataset(1:5,7);
y2 = tmpdataset(6:10,7);
y3 = tmpdataset(11,7);
h = figure(1)
H = plot(v,y1,'r*',v,y2,'b^',v,y3,'co');
hold on 
end
xlabel('速度V(km/h)','FontSize',18);
ylabel('样本熵SampEn','FontSize',18);
title('cA_{6}分量的样本熵分布 ','FontSize',18);
legend(H([1 6 11]),'擦伤','多边形','健康');
set(h,'position',[150,100,650,650]);
plot([40,70],[0.3,0.48],'--m');
hold on 
plot([70,110],[0.48,0.3],'--m');
hold on
%% cA6
for i = 1 : length(vkmh_set)
v = vkmh_set(i);
tmpdataset = Featureset(Featureset(:,9)==v,:);
tmplabel = Labelset(Featureset(:,9)==v,:);
y1 = tmpdataset(1:5,8);
y2 = tmpdataset(6:10,8);
y3 = tmpdataset(11,8);
h = figure(1)
H = plot(v,y1,'r*',v,y2,'b^',v,y3,'co');
hold on 
end
xlabel('速度V(km/h)','FontSize',18);
ylabel('样本熵SampEn','FontSize',18);
title('cA_{6}分量的样本熵分布 ','FontSize',18);
legend(H([1 6 11]),'擦伤','多边形','健康');
set(h,'position',[150,100,650,650]);
% plot([40,110],[0.26,0.26],'--m');
hold on 
