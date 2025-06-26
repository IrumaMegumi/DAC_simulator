clear;clc;
warning('off', 'MATLAB:nchoosek:LargeCoefficient');
%均匀分配的情况计算
node=Node(100,5);%建立节点对象
p_reply_5=node.calculate_p();%节点可以正确响应的概率

%整个系统概率的计算
func=@(t) t.^(node.k-1).*(1-t).^(node.N-node.k);
result_system=1-node.k*nchoosek(node.N,node.k)*integral(func,0,p_reply_5);
disp(['无法找回文件的概率为：',num2str(result_system)]);