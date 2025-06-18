clear;clc;
%参数加载
parameter;
if use_extra_deposit
    p_s=p_s+extra_deposit;
end
Gemma=gemma(N-k,k);
constexpr_1=@(r) (p_s-p_w-epsilon)*( (r).^(k-1)*(1-r).^(N-k)-Gemma(r) );
constexpr_2=@(r) v_f*r.^(k-1)*(1-r).^(N-k-1)/N;
p0_i=10;%初始贿赂值
equ=(p_w+p0_i-p_s)/(k*nchoosek(N - 1, k));

f_target=@(r) constexpr_1(r)+constexpr_2(r)-equ;

options = optimset('Display', 'iter', 'TolX', 1e-8);
r_sol = fzero(f_target, 0.5,options);

% 显示结果
disp(['r解为：', num2str(r_sol)]);