function f=gemma(p,q)
    f=@(r) integral(@(t) t.^(q-1) .* (1 - t).^(p-1), 0, r);
end