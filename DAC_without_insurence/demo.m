clear;clc;
%包含前面的参数
parameter;
Gemma=gemma(N-k,k);
constexp=constexpr(N,k);

p0_i=15;%初始贿赂值
x_vec=100:50:900;
p0_star_vec=zeros(size(x_vec));
for n=100:50:900
    [p0_star,r]=calculate_p0_star(n,k,p_w,p_s,epsilon);
    p0_star_vec(n/50-1)=r;
end
figure;
plot(x_vec, p0_star_vec, '-', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('节点数量','FontName', 'SimHei');
ylabel('方程中r的解','FontName', 'SimHei');
title('节点数量对计算p0*时r解的影响','FontName', 'SimHei');
grid on;

P_s=(p_w+p0_i-p_s)/(p_s-p_w-epsilon);
equ=P_s/(k*nchoosek(N - 1, k));
f_target = @(r) -Gemma(r) + constexp(r) - equ;

options = optimset('Display', 'iter', 'TolX', 1e-8);
r_sol = fzero(f_target, 0.5,options);

% 显示结果
disp(['r解为：', num2str(r_sol)]);