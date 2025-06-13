clear; clc;
warning('off', 'MATLAB:nchoosek:LargeCoefficient');
% 包含前面的参数
parameter; 
Gemma=gemma(N-k,k);
constexp=constexpr(N,k);

p0_vec = 1:0.01:35;
r_vec = zeros(size(p0_vec));   % 存储对应的r解

for i = 1:length(p0_vec)
    p0_i = p0_vec(i);    
    P_s = (p_w + p0_i - p_s) / (p_s - p_w - epsilon);
    equ = P_s / (k * nchoosek(N-1,k));
    f_target = @(r) -Gemma(r) + constexp(r) - equ;
    r_sol = fzero(f_target, 0.5);
    r_vec(i) = r_sol;
end

% 画图
figure;
plot(p0_vec, r_vec, 'LineWidth', 2);
xlabel('p_0^i');
ylabel('ri*');
title('Realtions between p0_i and ri*');
grid on;