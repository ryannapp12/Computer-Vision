function [result_canvas, result_canvas_mask] = addToRightToPano(right_img, canvas, canvas_mask)

    [xs, xd] = genSIFTMatches(canvas, right_img);
    ransac_n = 1000;
    ransac_eps = 8;
    [inliers_id, H_3x3] = runRANSAC(xs, xd, ransac_n, ransac_eps);
    H_3x3 = inv(H_3x3);
    
    src_img = right_img;
    pts = [1 size(src_img, 1); 1 1; size(src_img, 2) 1; 
        size(src_img, 2) size(src_img, 1)];
    
    roi = applyHomography(H_3x3, pts);
    width_to_add_to_canvas = ceil(max(roi(:, 1)) - size(canvas, 2));
    canvas = [canvas, 255*ones(size(canvas, 1), width_to_add_to_canvas, 3)];
    canvas_mask = [canvas_mask, zeros(size(canvas_mask, 1), width_to_add_to_canvas)];
    
    new_H_3x3 = computeHomography(pts, roi);
    dest_canvas_width_height = [size(canvas, 2), size(canvas, 1)];
    [mask_right, wrapped_img] = backwardWarpImg(src_img, inv(new_H_3x3), dest_canvas_width_height);

    result_canvas = blendImagePair(wrapped_img, mask_right, canvas, canvas_mask, 'blend');
    result_canvas_mask = mask_right | canvas_mask;

end