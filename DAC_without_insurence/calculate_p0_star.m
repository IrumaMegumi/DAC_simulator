function p0_star=calculate_p0_star(N,k,p_w,p_s,epsilon)
    %%求解r
    Gemma=gemma(N-k,k);
    constexpr_1=@(r)(1-r).^(N-k)*(r).^(k-1);
    f_target=@(r) constexpr_1(r)-Gemma(r);
    options = optimset('Display', 'iter', 'TolX', 1e-8);
    r = fzero(f_target, 0.5,options);

    %% 代入r求解p0*
    result = Gemma(r);
    p0_star=k*nchoosek(N - 1, k)*(1-r)*result/r*(p_s-p_w-epsilon)+p_s-p_w;
end