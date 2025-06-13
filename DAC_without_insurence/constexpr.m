function f2=constexpr(N,k)
    f2=@(r)(1-r).^(N-k)*(r).^(k-1);
end