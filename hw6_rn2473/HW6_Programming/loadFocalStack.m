function [rgb_stack, gray_stack] = loadFocalStack(focal_stack_dir)

    myFiles = dir(fullfile(focal_stack_dir,'*.jpg')); %gets all wav files in struct
    for k = 1:size(myFiles, 1)
        img = imread(strcat(focal_stack_dir, '/frame', num2str(k), '.jpg'));
        if k == 1
            % initializing the matrix
            rgb_stack = zeros(size(img, 1), size(img, 2), 3*k);
            gray_stack = zeros(size(img, 1), size(img, 2), k);
        end
        % copying the data to the big matrix
        rgb_stack(:, :, 3*k-2:3*k) = img;
        gray_stack(:, :, k) = rgb2gray(img);
    end

end
