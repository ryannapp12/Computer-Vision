function [inliers_id, H] = runRANSAC(Xs, Xd, ransac_n, eps)
    
    best_num = 0;
    H = zeros(3, 3);
    inliers_id = zeros(size(Xd, 1));
    for i=1:ransac_n
        ids_to_use = datasample(1:size(Xs, 1), 4);
        src_pts_i = Xs(ids_to_use, :);
        dst_pts_i = Xd(ids_to_use, :);
        
        H_3x3 = computeHomography(src_pts_i, dst_pts_i);
        
        transf_pts = applyHomography(H_3x3, Xs);
        
        tmp_num = 0;
        ids_within_eps = zeros(size(Xd, 1));
        for k=1:size(Xd, 1)
            if norm(Xd(k, :)-transf_pts(k, :)) < eps
                tmp_num = tmp_num + 1;
                ids_within_eps(k) = 1;
            end
        end
        
        if tmp_num > best_num
            best_num = tmp_num;
            H = H_3x3;
            inliers_id = find(ids_within_eps);
        end
    end

end
