% McDPC-experimental version
% set the parameters as original paper shown.
% we present a example here: 2circles_noise dataset. gamma=0.1,theta=2,lamda=3;percent  =2;
% paper tittle: Wang, Y., Wang, D., Zhang, X. et al. McDPC: multi-center density peak clustering. Neural Comput & Applic (2020). 
% https://doi.org/10.1007/s00521-020-04754-5
% authors:Yizhang Wang
%? Di Wang
%? Xiaofeng Zhang
%? Wei Pang
%? Chunyan Miao
%? Ah-Hwee Tan
%You Zhou(corresponding author)
% this code is only used to experiments.
clc;clear;close all
addpath('D:\MEGAFile\work\evaluation', 'D:\MEGAFile\work\Complicate','D:\MEGAFile\work\UCI','D:\MEGAFile\work\drawGraph');
addpath('D:\MEGAFile\work\Celldata');
% add your code path here.
load('2circles_noise.mat');% load your datasets.
%% ##########parameters setting###################
gamma=0.1% control   rho
theta=2;% control  delta
lamda=3;% select representive points
percent  =2;% parameter pct
%% main process
shapeset =data;
distset = computeSimi(shapeset);% 
dc = computeDc(distset, percent);% compute dc
fprintf('average percentage of neighbours (hard coded): %5.6f\n', percent);
fprintf('Computing Rho with gaussian kernel of radius: %12.6f\n', dc);
rhos = getLocalDensity(distset, dc);%
[deltas, nneigh] = getDistanceToHigherDensity(distset, rhos);% 
D=[rhos' deltas'];%D¡£
a=D(:,1);
b=D(:,2);
outvalue=min(a)+0.1*(max(a)-min(a));
[Y U]=find(a>0);
j=0;
for i=min(b):gamma:max(b)
    j=j+1;
    marginb(j)=length(find(b>i & b<i+gamma));
end
if max(b)>i+gamma
    marginb(j+1)=length(find(b>i+gamma & b<max(b)));
end
k=0;
Y2=0;
same=0;
res=find(marginb==0);
D=[rhos' deltas'];%D is decision graph¡£
 r=D(:,1);
 d=D(:,2);
tempcluster=find (d>lamda);
%% ****plot decision graph**********************************
figure(2);
showDeltas(rhos([tempcluster']), deltas([tempcluster']));%
%%
mindelta=min(deltas([tempcluster']));
filter=zeros(1,size(data,1));
filter([tempcluster'])=1;
cluster_num = sum(filter);%the number of initial clusters
ords = find(filter);%centers
cluster = zeros(size(rhos));% 
color = 1;
for i = 1:size(ords, 2)
    cluster(ords(i)) = color;% 
    color = color + 1;
end
[sorted_rhos, rords] = sort(rhos, 'descend');%
for i = 1:size(rords, 2) % 
    if cluster(rords(i)) == 0% 
        neigh_cluster = cluster(nneigh(rords(i)))
        assert(neigh_cluster ~= 0, 'neigh_cluster has not assign!');
        cluster(rords(i)) = neigh_cluster;% 
    end
end
% obtain initial clusters
cluster2=cluster;
%% further process-divide all the data points into different density levels
ords_rhos=rhos([tempcluster']);
l=0;
for i=min(ords_rhos):theta:(max(ords_rhos)+2)
    l=l+1;
    margin_rhos(l)=length(find(ords_rhos>=i & ords_rhos<=i+theta));
end
[Y4 U4]=find(margin_rhos>0)
k=0;
same=0;
t_cluster={};
lianxunum=diff(find(diff([nan U4 nan])~=1))
firstsum=cumsum(lianxunum);
for i=1:length(lianxunum)
    %identify gap  
    last=U4( firstsum(i));    
    [Y3 U3]= find(ords_rhos>=min(ords_rhos)+((last-lianxunum(i))-1)*theta & ords_rhos<=min(ords_rhos)+(last)*theta);
    t_cluster{i}= U3
end
% the process in max density level.
cluster_original=cluster;
length(t_cluster);
maxcluster=t_cluster{length(t_cluster)};
mean(deltas([tempcluster']));
num=0;
for i=1:length(maxcluster)   
    if deltas(tempcluster(maxcluster(i)))>mean(deltas([tempcluster']))
        deltas(tempcluster(maxcluster(i)))
        num=num+1;
    end
end
if num==length(maxcluster)
    % 
    num
    length(maxcluster)
    (length(t_cluster)-1)
    for j=1:(length(t_cluster)-1)
        for k=1:length(t_cluster{j})
            [Y4 U4]=find( cluster==[t_cluster{j}(k)]);
            cluster(U4)=t_cluster{j}(1);
        end
    end 
else
    % 
    num;
    t_cluster{1}(1);
    for j=1:length(t_cluster)
        for k=1:length(t_cluster{j})
            [Y4 U4]=find( cluster==[t_cluster{j}(k)]);
            cluster(U4)=t_cluster{j}(1);
        end
    end
end
%% metrics
idx=cluster';
Evaluation(label,idx);


