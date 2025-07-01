clear; clc;
warning('off', 'MATLAB:nchoosek:LargeCoefficient');
% 包含前面的参数
parameter; 
%根据配置决定是否添加额外押金
if use_extra_deposit
    p_s=p_s+extra_deposit;
end

Gemma=gemma(N-k,k);
constexpr_1=@(r) (p_s-p_w-epsilon)*( (r).^(k-1)*(1-r).^(N-k)-Gemma(r) );
constexpr_2=@(r) v_f*r.^(k-1)*(1-r).^(N-k-1)/N;

p0_vec = epsilon+0.05:0.01:35;
r_vec = zeros(size(p0_vec));   % 存储对应的r解

for i = 1:length(p0_vec)
    p0_i = p0_vec(i);    
    equ=(p_w+p0_i-p_s)/(k*nchoosek(N - 1, k));
    f_target=@(r) constexpr_1(r)+constexpr_2(r)-equ;
    r_sol = fzero(f_target, 0.5);
    r_vec(i) = r_sol;
end
save("DAC_with_ins_pf_10000_use_extra.mat","p0_vec","r_vec");
% 画图
figure;
plot(p0_vec, r_vec, 'LineWidth', 2);
xlabel('p_0^i');
ylabel('ri*');
title('Realtions between p0_i and ri*');
grid on;