clear;clc;
warning('off', 'MATLAB:nchoosek:LargeCoefficient');
num_node=900;%节点数量

node_1=Node(num_node, 2.5, false, 0);   % 贿赂2.5的节点
node_2=Node(num_node, 5, false, 0);   % 贿赂5的节点
node_3=Node(num_node, 7.5, false, 0);   % 贿赂7.5的节点

node_1_ins_1w=Node(num_node, 2.5, true, 10000);%带保险的2.5的节点
node_2_ins_1w=Node(num_node, 5, true, 10000);%带保险的5的节点
node_3_ins_1w=Node(num_node, 7.5, true, 10000);%带保险的7.5的节点

node_1_ins_5k=Node(num_node, 2.5, true, 5000);
node_2_ins_5k=Node(num_node, 5, true, 5000);
node_3_ins_5k=Node(num_node, 7.5, true, 5000);

node_1_ins_2k=Node(num_node, 2.5, true, 2000);
node_2_ins_2k=Node(num_node, 5, true, 2000);
node_3_ins_2k=Node(num_node, 7.5, true, 2000);

%可以正确还原需要k个节点响应
k=node_1.k;

%不带保险情况下的响应概率
p1=node_1.calculate_p();
p2=node_2.calculate_p();
p3=node_3.calculate_p();

%带保险情况下的响应概率
p1_ins_1w=node_1_ins_1w.calculate_p();
p2_ins_1w=node_2_ins_1w.calculate_p();
p3_ins_1w=node_3_ins_1w.calculate_p();

p1_ins_5k=node_1_ins_5k.calculate_p();
p2_ins_5k=node_2_ins_5k.calculate_p();
p3_ins_5k=node_3_ins_5k.calculate_p();

p1_ins_2k=node_1_ins_2k.calculate_p();
p2_ins_2k=node_2_ins_2k.calculate_p();
p3_ins_2k=node_3_ins_2k.calculate_p();

n2_vec=0:2:num_node;
p_lose=pLose_fast(num_node, p1, p2, p3, k);
p_lose_ins_1w=pLose_fast(num_node,p1_ins_1w,p2_ins_1w,p3_ins_1w,k);
p_lose_ins_5k=pLose_fast(num_node,p1_ins_5k,p2_ins_5k,p3_ins_5k,k);
p_lose_ins_2k=pLose_fast(num_node,p1_ins_2k,p2_ins_2k,p3_ins_2k,k);

%画图
figure;
plot(n2_vec, p_lose, '-', 'LineWidth', 2, 'MarkerSize', 8, 'Color', [0 0.4470 0.7410]);
hold on;
plot(n2_vec,p_lose_ins_1w,'-', 'LineWidth', 2, 'MarkerSize', 8,'Color',[0 1 0]);
hold on;
plot(n2_vec,p_lose_ins_5k,'-', 'LineWidth', 2, 'MarkerSize', 8,'Color',[1 0 0]);
plot(n2_vec,p_lose_ins_2k,'-', 'LineWidth', 2, 'MarkerSize', 8,'Color',[0 0 1]);
xlabel('贿赂为5的节点所占的比例','FontName', 'SimHei');
ylabel('无法取回文件的概率','FontName', 'SimHei');
legend({'无保险', '文件价值1w有保险','文件价值5k有保险','文件价值2k有保险'}, 'FontName', 'SimHei', 'Location', 'best');
title('贿赂为5的节点占比对系统的影响','FontName', 'SimHei');
grid on;