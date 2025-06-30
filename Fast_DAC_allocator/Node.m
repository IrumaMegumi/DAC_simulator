%单一节点类
classdef Node
    properties
        p_w=0.226;  %没有响应时的惩罚
        p_s=12;  %押金
        epsilon=0.1; %微调惩罚参数
        p0_i=0;%初始贿赂值
        extra_deposit=0;
        N %系统节点总数
        k %获取k个就可以还原文件
        v_f%文件的价值
        use_extra_deposit%bool变量，如果使用保险机制就算作true,否则算作false
    end

    methods

        %构造函数
        function obj=Node(N, p_0,use_extra_deposit,v_f)%输入参数的含义：N为系统节点总数，p_0为节点收到的贿赂金额
            obj.N=N;
            obj.k=round(N/3);
            obj.p0_i=p_0;
            %使用保险机制的处理
            if use_extra_deposit
                obj.use_extra_deposit=true;
                obj.v_f=v_f;
                obj.extra_deposit=v_f/(obj.N-obj.k);
            %不使用保险机制
            else
                obj.use_extra_deposit=false;
                obj.v_f=0;
                obj.extra_deposit=0;
            end
        end

        function p0_star=calculate_p0_star(obj)%计算概率转变的临界值
            %使用了保险时计算p0*的方法
            if obj.use_extra_deposit
                Gemma=gemma(obj.N-obj.k,obj.k);
                f_target=@(r) r.^obj.k * (1-r).^(obj.N-obj.k-1) * ( (obj.p_s-obj.p_w-obj.epsilon)*(1-r)-obj.v_f/obj.N ) - (obj.p_s-obj.p_w-obj.epsilon+obj.v_f/obj.N)*Gemma(r);
                r=fzero(f_target,0.5);
                result=Gemma(r);
                p0_star=-obj.p_w+obj.p_s+obj.k*nchoosek(obj.N-1,obj.k)*( obj.v_f/obj.N+(obj.p_s-obj.p_w-obj.epsilon)*(1-r))*result/r;
            %未使用保险时计算p0*的方法
            else
                Gemma=gemma(obj.N-obj.k,obj.k);
                constexpr_1=@(r)(1-r).^(obj.N-obj.k)*(r).^(obj.k-1);
                f_target=@(r) constexpr_1(r)-Gemma(r);
                r = fzero(f_target, 0.5);
                result = Gemma(r);
                p0_star=obj.k*nchoosek(obj.N - 1, obj.k)*(1-r)*result/r*(obj.p_s-obj.p_w-obj.epsilon)+obj.p_s-obj.p_w;
            end
        end
        
        function r_sol=calculate_p(obj)%计算节点的响应概率
            if obj.use_extra_deposit
                p0_star=obj.calculate_p0_star();
                %使用保险时计算响应概率
                if obj.p0_i<obj.epsilon
                    r_sol=1;
                elseif obj.p0_i>=obj.epsilon && obj.p0_i<p0_star
                    Gemma=gemma(obj.N-obj.k,obj.k);
                    constexpr_1=@(r) (obj.p_s-obj.p_w-obj.epsilon)*( (r).^(obj.k-1)*(1-r).^(obj.N-obj.k)-Gemma(r) );
                    constexpr_2=@(r) obj.v_f*r.^(obj.k-1)*(1-r).^(obj.N-obj.k-1)/obj.N;
                    equ=(obj.p_w+obj.p0_i-obj.p_s)/(obj.k*nchoosek(obj.N - 1, obj.k));
                    f_target=@(r) constexpr_1(r)+constexpr_2(r)-equ;
                    r_sol = fzero(f_target, 0.5);
                else
                    r_sol=0;
                end
            else
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
end