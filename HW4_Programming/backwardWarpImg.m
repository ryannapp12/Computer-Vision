function [mask, result_img] = backwardWarpImg(src_img, resultToSrc_H,...
    dest_canvas_width_height)

    pts = [1 size(src_img, 1); 1 1; size(src_img, 2) 1; 
        size(src_img, 2) size(src_img, 1)];
    
    roi = applyHomography(inv(resultToSrc_H), pts);
    
    mask = poly2mask(roi(:, 1),roi(:, 2),...
    dest_canvas_width_height(2),dest_canvas_width_height(1));

    %imshow(mask)

    result_img = zeros(dest_canvas_width_height(2),dest_canvas_width_height(1), 3);
    %{
    test_pt = round(ginput(1))
    
    src_pt = applyHomography(resultToSrc_H, [test_pt(1), test_pt(2)])
    for c=1:3
        result_img(test_pt(2), test_pt(1), c) = interp2(src_img(:, :, c), src_pt(1, 2), src_pt(1, 1));
    end
    imshow(result_img);
    %}
    [row, col] = find(mask);
    src_pts = applyHomography(resultToSrc_H, [col, row]);
    %size(result_img(sub2ind(size(result_img), row, col, ones(size(row, 1), 1))))
    %size(interp2(src_img(:, :, 1), src_pts(:, 1), src_pts(:, 2)))
    for c=1:3
        result_img(sub2ind(size(result_img), row, col, ones(size(row, 1), 1)*c)) = interp2(src_img(:, :, c), src_pts(:, 1), src_pts(:, 2));
    end
    %size(result_img)
    %for i=1:size(result_img, 1)
        %for j=1:size(result_img, 2)
            %if mask(i, j) == 0
                %continue
            %end
            
            %src_pt = applyHomography(resultToSrc_H, [j, i]);
            %src_pt = applyHomography(resultToSrc_H, [j, size(result_img, 1)-i]);
            %src_pt = [size(result_img, 1)-src_pt(2), src_pt(1)];
            %for c=1:3
                %result_img(i, j, c) = interp2(src_img(:, :, c), src_pt(1, 1), src_pt(1, 2));
            %end
            %imshow(result_img);
        %end
%end


    %imshow(result_img);
end
