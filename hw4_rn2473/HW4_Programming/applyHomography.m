function dest_pts_nx2 = applyHomography(H_3x3, src_pts_nx2)
    src_pts_transformed = [src_pts_nx2, ones(size(src_pts_nx2, 1), 1)]';
    dst_pts_transformed = H_3x3 * src_pts_transformed;
    dest_pts_nx2 = dst_pts_transformed';
    dest_pts_nx2 = dest_pts_nx2(:, 1:2)./dest_pts_nx2(:, 3);
end

