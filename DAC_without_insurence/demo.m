clear;clc;
%包含前面的参数
parameter;
Gemma=gemma(N-k,k);
constexp=constexpr(N,k);

p0_i=15;%初始贿赂值
P_s=(p_w+p0_i-p_s)/(p_s-p_w-epsilon);
equ=P_s/(k*nchoosek(N - 1, k));
f_target = @(r) -Gemma(r) + constexp(r) - equ;

options = optimset('Display', 'iter', 'TolX', 1e-8);
r_sol = fzero(f_target, 0.5,options);

% 显示结果
disp(['r解为：', num2str(r_sol)]);