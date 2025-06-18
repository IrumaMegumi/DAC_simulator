%定理5.1使用的相关参数配置列表
p_w=0.226;  %没有响应时的惩罚
p_s=12;  %押金
epsilon=0.1; %微调惩罚参数
N=1000; %节点数
k=round(N/3); %获取k个就可以还原文件
v_f=10000;%文件价值，后面也是pf

extra_deposit=v_f/(N-k);%添加对文件额外的保证金
use_extra_deposit=true;%是否使用，如果后面要用的话就改为true就行