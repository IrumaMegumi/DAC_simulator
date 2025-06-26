%n2节点的响应情况
%传入参数含义
% n2:贿赂金为5的节点数量
%k:能够正常还原文件所需要能够正确响应的节点数
%p2:贿赂金为5时单一节点能够正确响应的概率
function res_n2=n2_reply(n1,n2,n3,p1,p2,p3,k)
    res_n2=0;
    if n2>=k-1
        for l2=0:1:k-1
            res_n2=res_n2+nchoosek(n2,l2)*p2.^l2*(1-p2).^(n2-l2)*n1_reply(n1,n3,k-l2,p1,l2,p3,k);
        end
    else
        for l2=0:1:n2
            res_n2=res_n2+nchoosek(n2,l2)*p2.^l2*(1-p2).^(n2-l2)*n1_reply(n1,n3,k-l2,p1,l2,p3,k);
        end
    end
end