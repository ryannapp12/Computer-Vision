function [normals, albedo_img] = ...
    computeNormals(light_dirs, img_cell, mask)
    
    % initializing return variables
    normals = zeros(size(mask, 1), size(mask, 2), 3);
    albedo_img = zeros(size(mask));
    I = zeros(size(img_cell));
    
    p_inv_ld = (inv(light_dirs'*light_dirs))*light_dirs';
    
    % Implementations using matrix multiplication isn't as necessary here,
    % as it was with homography application, since execution time is not
    % that slow
    for i = 1:size(mask, 1)
        for j = 1:size(mask, 2)
            if (mask(i, j) == 0)
                % Where mask is zero, 
                normals(i, j, :) = [0, 0, 1];
                albedo_img(i, j) = 1;
            else
                for k = 1:size(img_cell, 1)
                    I(k) = img_cell{k}(i, j);
                end
                N = p_inv_ld*I;
                normals(i, j, :) = N/norm(N);
                albedo_img(i, j) = norm(N);
            end
        end
    end
    
    % Scaling albedo matrix
    albedo_img = albedo_img/max(albedo_img(:));

end
 
