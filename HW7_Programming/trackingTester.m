function trackingTester(data_params, tracking_params)
    pwd 
    mkdir (fullfile(data_params.out_dir));
    
    current_folder = pwd;
    
    slash = '/';
    folder = data_params.data_dir;
    D = strcat(current_folder, slash, folder, slash);
    pattern = fullfile(D, '*.png');
    
    frames = dir(pattern);
   
    frames = orderfields(frames);
    
    rectcell = num2cell(tracking_params.rect);
    [y, x, height, width] = rectcell{:};
    
    for i=data_params.frame_ids(1:end)
        baseFileName = frames(i).name;
        fullFileName = fullfile(D, baseFileName);
        
        img = imread(fullFileName);
        [frame_h, frame_w, channels] = size(img);
        curr_frame = padarray(img, [tracking_params.search_half_window_size + height, tracking_params.search_half_window_size + width], 0, 'both');
        
        if i == 1    
            [X, cmap] = rgb2ind(curr_frame, tracking_params.bin_n);
            template = X(y : min(frame_h, y + height), x : min(frame_w, x + width));
            [width, height, channels] = size(template);
            template = template(:); 
            template = double(template);

            for id = data_params.frame_ids(1): data_params.frame_ids(2)
                img = drawBox(curr_frame, [y+height x+width width height], [255, 0, 0], 3);
                imwrite(img, fullfile(data_params.out_dir, data_params.genFname(data_params.frame_ids(id))));
            end
            
        else 
            X = rgb2ind(curr_frame, cmap);
            
            x = max(x, width+tracking_params.search_half_window_size+1);
            x = min(x, frame_w);
            y = max(y, height+tracking_params.search_half_window_size+1);
            y = min(y, frame_h);
            
            search_patches = im2col(X(y - height - tracking_params.search_half_window_size : y + height + tracking_params.search_half_window_size, x - width - tracking_params.search_half_window_size : x + width + tracking_params.search_half_window_size), [height width]);
            
            search_patches = cast(search_patches,'like',template);

            corrs = corr(template, search_patches);
            
            best_match = find(corrs == max(corrs)); 
            best_match = best_match(1);
            search_space = X(y - height - tracking_params.search_half_window_size : y + height + tracking_params.search_half_window_size, x - width - tracking_params.search_half_window_size : x + width + tracking_params.search_half_window_size);
            
            [s_y, s_x] = size(search_space);
            [y, x] = ind2sub([floor(s_y-height/2), floor(s_x-width/2)], best_match);

            for id = data_params.frame_ids(2:end)
                     img2 = drawBox(curr_frame, [s_y-height s_x-width width height], [255, 0, 0], 3);
                     imwrite(img2, fullfile(data_params.out_dir, data_params.genFname(data_params.frame_ids(id))));
            end
        end      
    end

end
