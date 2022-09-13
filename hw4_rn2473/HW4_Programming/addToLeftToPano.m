function [result_canvas, result_canvas_mask] = addToLeftToPano(left_img, canvas, canvas_mask)

    [xs, xd] = genSIFTMatches(left_img, canvas);
    ransac_n = 1000;
    ransac_eps = 8;
    [inliers_id, H_3x3] = runRANSAC(xs, xd, ransac_n, ransac_eps);
    
    src_img = left_img;
    pts = [1 size(src_img, 1); 1 1; size(src_img, 2) 1; 
        size(src_img, 2) size(src_img, 1)];
    
    roi = applyHomography(H_3x3, pts);
    width_to_add = ceil(abs(min(roi(:, 1))));
    roi(:, 1) = roi(:, 1) + width_to_add;
    canvas = [255*ones(size(canvas, 1), width_to_add, 3), canvas];
    canvas_mask = [zeros(size(canvas_mask, 1), width_to_add), canvas_mask];
    
    new_H_3x3 = computeHomography(pts, roi);
    dest_canvas_width_height = [size(canvas, 2), size(canvas, 1)];
    [mask_left, wrapped_img] = backwardWarpImg(src_img, inv(new_H_3x3), dest_canvas_width_height);

    result_canvas = blendImagePair(wrapped_img, mask_left, canvas, canvas_mask, 'blend');
    result_canvas_mask = mask_left | canvas_mask;

end