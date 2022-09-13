function light_dirs_5x3 = computeLightDirections(center, radius, img_cell)
    
    light_dirs_5x3 = zeros(5, 3);
    for i = 1:size(img_cell, 1)
        tmp_img = img_cell{i};
        M = max(tmp_img(:));
        [x_m, y_m] = find(tmp_img == M);
        % If there is more than one points with maximal value
        % We will take the middle one
        if (size(x_m, 1) > 1)
            x_m = x_m(round(size(x_m, 1)/2));
            y_m = y_m(round(size(y_m, 1)/2));
        end
        
        r_p = sqrt((center(1) - x_m)^2 + (center(2) - y_m)^2);

        % For x, y and z as from grad image for sphere
        % And the clarification from the runHw5.m for the
        % normals direction mapping
        ld_x = (y_m - center(2))/r_p;  % Using columns for x
        ld_y = (x_m - center(1))/r_p;  % Using rows for y
        ld_z = sqrt(1 - (r_p/radius)^2);  % Z direction can be
        % calculated as sin(theta), where theta is angle used to
        % project the radius of the sphere to xy-plane
        dir_vec = [ld_x, ld_y, ld_z];
        dir_vec = dir_vec/norm(dir_vec)*cast(M, 'double');
        light_dirs_5x3(i, :) = dir_vec;
    end

end