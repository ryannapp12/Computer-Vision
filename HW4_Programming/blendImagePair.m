function out_img = blendImagePair(wrapped_imgs, masks, wrapped_imgd, maskd, mode)
    out_img = zeros(size(wrapped_imgs));
    %size(wrapped_imgs)
    %size(masks)
    %find(masks)
    if strcmp(mode, 'blend')
        smooth_factor = 0.1;
        bw_dist_s = bwdist(masks==0);
        %figure()
        %imshow(cast(bw_dist_s, 'uint8'))
        %figure()
        %imshow(cast(masks, 'uint8'))
        %bw_dist_s
        bw_dist_d = bwdist(maskd==0);
        %imshow(cast(bw_dist_d, 'uint8'))
        bw_dist_sum = bw_dist_s + bw_dist_d + smooth_factor;
        for i=1:3
            %size(wrapped_imgs)
            %size(bw_dist_s)
            %size(wrapped_imgd)
            %size(bw_dist_d)
            max(wrapped_imgs(:, :, i));
            out_img(:, :, i) = (cast(wrapped_imgs(:, :, i),'double').*bw_dist_s + ...
            cast(wrapped_imgd(:, :, i),'double').*bw_dist_d)./bw_dist_sum;
        end
        %out_img = round(out_img);
        
    end
    
    if strcmp(mode, 'overlay')
        maskd_logical = maskd==255;
        for i=1:3
            tmp_c = zeros(size(wrapped_imgd, 1), size(wrapped_imgd, 2));
            tmp_w_d = wrapped_imgd(:, :, 3);
            tmp_w_s = wrapped_imgs(:, :, 3);
            tmp_c(maskd_logical) = tmp_w_d(maskd_logical);
            tmp_c(~maskd_logical) = tmp_w_s(~maskd_logical);
            out_img(:, :, i) = tmp_c;
        end
        %out_img(maskd_logical) = wrapped_imgd(maskd_logical);
        %%out_img(~maskd_logical) = wrapped_imgs(~maskd_logical);
    end
    
    if isa(wrapped_imgs, 'uint8')
        out_img = round(out_img);
        out_img = cast(out_img, 'uint8');
    end
    
    %figure()
    %imshow(out_img)
    
end
