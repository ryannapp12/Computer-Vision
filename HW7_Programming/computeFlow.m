function result = computeFlow(img1, img2, win_radius, template_radius, grid_MN)
    
    % Getting parameters
    [img_h, img_w, channels] = size(img1);
    g = num2cell(grid_MN);
    [m, n] = g{:};
    
    block_h = floor(img_h / m);
    block_w = floor(img_w / n);
    blocks = mat2cell(img1(1:block_h*m, 1:block_w*n), repmat(block_h, m, 1), repmat(block_w, n, 1));
    
    centroids = zeros(m, n, 2);
    for i = 1:m
        for j = 1:n
            centroids(i, j, :) = [floor(block_h/2 + (i-1) * block_h), floor(block_w/2 + (j-1)*block_w)];
        end
    end
    
    % Blocks are the sub-images
    mat2cell(img1(1:block_h*m, 1:block_w*n), repmat(block_h, m, 1), repmat(block_w, n, 1));
    
    [img2_h, img2_w, channels2] = size(img2);

    best_matches_coords = zeros(m, n, 2);
    
    % Looping through each centroid/block
    for i = 1:m
      for j = 1:n
        cen = reshape(centroids(i, j, :), 2, 1);
        cen = num2cell(cen);
        [cen_y, cen_x] = cen{:};        
        A = img2(max(1, floor(cen_y-win_radius-block_h/2)):min(img2_h, floor(cen_y+win_radius+block_h/2)), max(1, floor(cen_x-win_radius-block_w/2)):min(img2_w, floor(cen_x+win_radius+block_w/2)));      
        template = cell2mat(blocks(i, j));
        scores = normxcorr2(template,A);    
        best_matches_coords(i, j, :) = find(scores==max(scores(:)));
      end
    end
  
    translation_vectors = best_matches_coords - centroids;
    Y = reshape(centroids(:, :, 1), m*n, 1);
    X = reshape(centroids(:, :, 2), m*n, 1);
    U = reshape(translation_vectors(:, :, 2), m*n, 1);
    V = reshape(translation_vectors(:, :, 1), m*n, 1);
    
    f = figure;
    imshow(img1);
    hold on;
    quiver(X,Y,U,V);
    
    result = getframe(f).cdata;
    
end
