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
        eval(['load Crusie_',num2str(Crusie_set(j)),'_spd_',num2str(vkmh_set(i)),'_onW2.mat']);
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
        eval(['load Poly_',num2str(N_set(j)),'_spd_',num2str(vkmh_set(i)),'_onW2.mat']);
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
    eval(['load Good_spd_',num2str(vkmh_set(i)),'_onW2.mat']);
    xp1 = ACC(part1);
    tp1 = time(part1);
    X = xp1;
    tmpres = DWTandSamp(X,Wavelet_Families,2,0.25);
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
H = plot(v,y1,v,y2,v,y3);
set(H(1:5),'Color',[142 207 201]/255,'Marker','o','MarkerSize',8,'LineWidth',2);
set(H(6:10),'Color',[255 90 122]/255,'Marker','+','MarkerSize',8,'LineWidth',2);
set(H(11),'Color',[130 176 210]/255,'Marker','^','MarkerSize',8,'LineWidth',2);
hold on 
end
xlabel('速度V(km/h)','FontSize',18);
ylabel('样本熵SampEn','FontSize',18);
title('cD分量的样本熵分布 ','FontSize',18);
plot([40:110],0.64*ones(1,71),'--','Color',[250 127 111]/255,'LineWidth',2);
legend(H([1 6 11]),'擦伤','多边形','健康');

set(h,'position',[150,100,550,450]);
prettyAxes().ggray()
%% cA
for i = 1 : length(vkmh_set)
v = vkmh_set(i);
tmpdataset = Featureset(Featureset(:,9)==v,:);
tmplabel = Labelset(Featureset(:,9)==v,:);
y1 = tmpdataset(1:5,2);
y2 = tmpdataset(6:10,2);
y3 = tmpdataset(11,2);
h = figure(2)
H = plot(v,y1,v,y2,v,y3);
set(H(1:5),'Color',[142 207 201]/255,'Marker','o','MarkerSize',8,'LineWidth',2);
set(H(6:10),'Color',[255 90 122]/255,'Marker','+','MarkerSize',8,'LineWidth',2);
set(H(11),'Color',[130 176 210]/255,'Marker','^','MarkerSize',8,'LineWidth',2);
hold on 
end
xlabel('速度V(km/h)','FontSize',18);
ylabel('样本熵SampEn','FontSize',18);
title('cA分量的样本熵分布 ','FontSize',18);
plot([40,80],[0.62,1.2],'--','Color',[250 127 111]/255,'LineWidth',2);
hold on
plot([80,110],[1.2,0.86],'--','Color',[250 127 111]/255,'LineWidth',2);
legend(H([1 6 11]),'擦伤','多边形','健康');
set(h,'position',[150,100,550,450]);
prettyAxes().ggray()
%% cA1
for i = 1 : length(vkmh_set)
v = vkmh_set(i);
tmpdataset = Featureset(Featureset(:,9)==v,:);
tmplabel = Labelset(Featureset(:,9)==v,:);
y1 = tmpdataset(1:5,3);
y2 = tmpdataset(6:10,3);
y3 = tmpdataset(11,3);
h = figure(3)
H = plot(v,y1,v,y2,v,y3);

set(H(1:5),'Color',[142 207 201]/255,'Marker','o','MarkerSize',8,'LineWidth',2);
set(H(6:10),'Color',[255 90 122]/255,'Marker','+','MarkerSize',8,'LineWidth',2);
set(H(11),'Color',[130 176 210]/255,'Marker','^','MarkerSize',8,'LineWidth',2);
hold on 
end
plot([40,110],[0.2,0.45],'--','Color',[250 127 111]/255,'LineWidth',2);;
xlabel('速度V(km/h)','FontSize',18);
ylabel('样本熵SampEn','FontSize',18);
title('cA_{1}分量的样本熵分布 ','FontSize',18);
legend(H([1 6 11]),'擦伤','多边形','健康');
set(h,'position',[150,100,550,450]);
xlim([40 110])
prettyAxes().ggray()
%% cA2
for i = 1 : length(vkmh_set)
v = vkmh_set(i);
tmpdataset = Featureset(Featureset(:,9)==v,:);
tmplabel = Labelset(Featureset(:,9)==v,:);
y1 = tmpdataset(1:5,4);
y2 = tmpdataset(6:10,4);
y3 = tmpdataset(11,4);
h = figure(4)
H = plot(v,y1,v,y2,v,y3);
set(H(1:5),'Color',[142 207 201]/255,'Marker','o','MarkerSize',8,'LineWidth',2);
set(H(6:10),'Color',[255 90 122]/255,'Marker','+','MarkerSize',8,'LineWidth',2);
set(H(11),'Color',[130 176 210]/255,'Marker','^','MarkerSize',8,'LineWidth',2);
hold on 
end

xlabel('速度V(km/h)','FontSize',18);
ylabel('样本熵SampEn','FontSize',18);
title('cA_{2}分量的样本熵分布 ','FontSize',18);
legend(H([1 6 11]),'擦伤','多边形','健康');
set(h,'position',[150,100,550,450]);
xlim([40 110])
prettyAxes().ggray()
%% cA5
for i = 1 : length(vkmh_set)
v = vkmh_set(i);
tmpdataset = Featureset(Featureset(:,9)==v,:);
tmplabel = Labelset(Featureset(:,9)==v,:);
y1 = tmpdataset(1:5,7);
y2 = tmpdataset(6:10,7);
y3 = tmpdataset(11,7);
h = figure(5)
H = plot(v,y1,v,y2,v,y3);
set(H(1:5),'Color',[142 207 201]/255,'Marker','o','MarkerSize',8,'LineWidth',2);
set(H(6:10),'Color',[255 90 122]/255,'Marker','+','MarkerSize',8,'LineWidth',2);
set(H(11),'Color',[130 176 210]/255,'Marker','^','MarkerSize',8,'LineWidth',2);
hold on 
end
xlabel('速度V(km/h)','FontSize',18);
ylabel('样本熵SampEn','FontSize',18);
title('cA_{5}分量的样本熵分布 ','FontSize',18);
xlim([40 110])
set(h,'position',[150,100,550,450]);
legend(H([1 6 11]),'擦伤','多边形','健康');
prettyAxes().ggray()
%% cA6
for i = 1 : length(vkmh_set)
v = vkmh_set(i);
tmpdataset = Featureset(Featureset(:,9)==v,:);
tmplabel = Labelset(Featureset(:,9)==v,:);
y1 = tmpdataset(1:5,8);
y2 = tmpdataset(6:10,8);
y3 = tmpdataset(11,8);

h = figure(6)
H = plot(v,y1,v,y2,v,y3);
set(H(1:5),'Color',[142 207 201]/255,'Marker','o','MarkerSize',8,'LineWidth',2);
set(H(6:10),'Color',[255 90 122]/255,'Marker','+','MarkerSize',8,'LineWidth',2);
set(H(11),'Color',[130 176 210]/255,'Marker','^','MarkerSize',8,'LineWidth',2);
hold on 
end
xlabel('速度V(km/h)','FontSize',18);
ylabel('样本熵SampEn','FontSize',18);
title('cA_{6}分量的样本熵分布 ','FontSize',18);
legend(H([1 6 11]),'擦伤','多边形','健康');
set(h,'position',[150,100,550,450]);
% plot([40,110],[0.26,0.26],'--m');
hold on 
prettyAxes().ggray()
xlim([40 110])
ylim([-0.1 1.2])