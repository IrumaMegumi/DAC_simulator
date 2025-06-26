%n3节点的响应情况
%传入参数含义
% n3:贿赂金为7.5的节点数量
%start:在n3中有不超过start个回应,start实际赋值为k-l1-l2
%p3:贿赂金为7.5时单一节点能够正确响应的概率
%res_n3:在n3中有不超过start个节点回应的概率
function res_n3=n3_reply(n3,start,p3)
    res_n3=1;
    if n3>=start
        res=0;
        for l=start:1:n3
            res=res+nchoosek(n3,l)*p3.^l*(1-p3).^(n3-l);
        end
        res_n3=res_n3-res;
    else
        res_n3=1;
    end
end