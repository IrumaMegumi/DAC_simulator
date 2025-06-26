%单一节点类
classdef Node
    properties
        p_w=0.226;  %没有响应时的惩罚
        p_s=12;  %押金
        epsilon=0.1; %微调惩罚参数
        p0_i=0;%初始贿赂值
        N %系统节点总数
        k %获取k个就可以还原文件
    end

    methods

        %构造函数
        function obj=Node(N, p_0)%输入参数的含义：N为系统节点总数，p_0为节点收到的贿赂金额
            obj.N=N;
            obj.k=round(N/3);
            if nargin==2%传入了贿赂值，否则按默认值处理
                obj.p0_i=p_0;
            end
        end

        function p0_star=calculate_p0_star(obj)%计算概率转变的临界值
            Gemma=gemma(obj.N-obj.k,obj.k);
            constexpr_1=@(r)(1-r).^(obj.N-obj.k)*(r).^(obj.k-1);
            f_target=@(r) constexpr_1(r)-Gemma(r);
            r = fzero(f_target, 0.5);
            result = Gemma(r);
            p0_star=obj.k*nchoosek(obj.N - 1, obj.k)*(1-r)*result/r*(obj.p_s-obj.p_w-obj.epsilon)+obj.p_s-obj.p_w;
        end
        
        function r_sol=calculate_p(obj)%计算节点的响应概率
            Gemma=gemma(obj.N-obj.k,obj.k);
            constexp=constexpr(obj.N,obj.k);
            p0_star=obj.calculate_p0_star();
            
            if obj.p0_i<obj.epsilon
                r_sol=1;
            elseif obj.p0_i>=obj.epsilon && obj.p0_i<p0_star
                P_s=(obj.p_w+obj.p0_i-obj.p_s)/(obj.p_s-obj.p_w-obj.epsilon);
                equ=P_s/(obj.k*nchoosek(obj.N - 1, obj.k));
                f_target = @(r) -Gemma(r) + constexp(r) - equ;
                r_sol = fzero(f_target, 0.5);
            else
                r_sol=0;
            end
        end
    end
end