function H_3x3 = computeHomography(src_pts_nx1, dest_pts_nx2)
    num_points = size(src_pts_nx1, 1);
    A = zeros(2*num_points, 9);
    for i=1:size(src_pts_nx1, 1)
        x_s = src_pts_nx1(i, 1);
        y_s = src_pts_nx1(i, 2);
        x_d = dest_pts_nx2(i, 1);
        y_d = dest_pts_nx2(i, 2);
        A(i*2-1, :) = [x_s, y_s, 1, 0, 0, 0, -x_d*x_s, -x_d*y_s, -x_d];
        A(i*2, :) = [0, 0, 0, x_s, y_s, 1, -y_d*x_s, -y_d*y_s, -y_d];
    end
    [V,D,W] = eig(A'*A);
    H_3x3 = -reshape(V(:, 1), 3, 3)';
end

