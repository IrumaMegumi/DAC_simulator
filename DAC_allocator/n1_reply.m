%n1节点的响应情况
%传入参数含义
% n1:贿赂金为2.5的节点数量
%d:在n1+n3中有不超过d个回应
%p1:贿赂金为2.5时单一节点能够正确响应的概率
function res_n1=n1_reply(n1,n3,d,p1,l2,p3,k)
    res_n1=0;
    if n1>=d-1
        for l1=0:1:d-1
            res_n1=res_n1+nchoosek(n1,l1)*p1.^l1*(1-p1).^(n1-l1)*n3_reply(n3,k-l1-l2,p3);
        end
    else
        for l1=0:1:n1
            res_n1=res_n1+nchoosek(n1,l1)*p1.^l1*(1-p1).^(n1-l1)*n3_reply(n3,k-l1-l2,p3);
        end
    end
end