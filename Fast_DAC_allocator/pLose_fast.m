function p_lose = pLose_fast(num_node, p1, p2, p3, k)
    n2_vec = 0:2:num_node;
    n1_vec = (num_node - n2_vec) / 2;
    n3_vec = n1_vec;                 % 对称
    p_lose = zeros(size(n2_vec));

    for idx = 1:numel(n2_vec)
        n1 = n1_vec(idx);
        n2 = n2_vec(idx);
        n3 = n3_vec(idx);

        % 各组节点的 PMF
        pmf1 = binopdf(0:n1, n1, p1);
        pmf2 = binopdf(0:n2, n2, p2);
        pmf3 = binopdf(0:n3, n3, p3);

        % r1 + r3 的分布 = 卷积
        pmf13 = conv(pmf1, pmf3);          % 长度 n1+n3+1
        cdf13 = cumsum(pmf13);            % CDF, 末元素 = 1

        % 若 n1+n3+1 < k, 需填充到 k, 保证索引安全
        if numel(cdf13) < k
            cdf13(numel(cdf13)+1 : k) = 1;  % 填 1 表示 P = 1
        end

        % 根据公式：∑_{l2} P(r2=l2) · P(r1+r3 < k-l2)
        l2_max = min(k-1, n2);
        l2 = 0:l2_max;
        idx_vec = k - l2;                 % 1‑based 索引
        p_lose(idx) = sum( pmf2(l2+1) .* cdf13(idx_vec) );
    end
end