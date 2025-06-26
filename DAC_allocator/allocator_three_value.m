%2.5、5、7.5三个值随机分配的情况
%分配原则：贿赂为5的数量是偶数，2.5和7.5的节点数量是相同的
clear;clc;
warning('off', 'MATLAB:nchoosek:LargeCoefficient');
num_node=100;%节点总数
node_1=Node(num_node,2.5);%第一组节点，贿赂金为2.5
node_2=Node(num_node,5);%第二组节点，贿赂金为5
node_3=Node(num_node,7.5);%第三组节点，贿赂金为7.5
k=node_1.k;
p1=node_1.calculate_p();%2.5的节点响应的概率
p2=node_2.calculate_p();%5的节点响应的概率
p3=node_3.calculate_p();%7.5的节点相应的概率

n2_ratio=0:2:num_node;
n2_ratio=n2_ratio/num_node;
p_lose=zeros(size(n2_ratio));

cnt=0;
for n2=0:2:num_node
    cnt=cnt+1;
    n1=(num_node-n2)/2;
    n3=(num_node-n2)/2;
    result=n2_reply(n1,n2,n3,p1,p2,p3,k);
    p_lose(cnt)=result;
end

figure;
plot(n2_ratio, p_lose, '-', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('贿赂为5的节点所占的比例','FontName', 'SimHei');
ylabel('无法取回文件的概率','FontName', 'SimHei');
title('贿赂为5的节点占比对系统的影响','FontName', 'SimHei');
grid on;