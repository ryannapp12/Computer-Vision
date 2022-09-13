function hough_img = generateHoughAccumulator(img, theta_num_bins, rho_num_bins)
    % Defining theta and rho vectors
    thetas = linspace(-pi/2, pi/2, theta_num_bins);
    img_diagonal = round(sqrt(size(img, 1)^2 + size(img, 2)^2));
    rhos = linspace(-img_diagonal, img_diagonal, rho_num_bins);
    rho_step = 2*img_diagonal/rho_num_bins;
    hough_img = zeros(rho_num_bins, theta_num_bins);
    for y = 1:size(img, 1)
        for x = 1:size(img, 2)
            % If the edge pixel is detected we plot a sinusoid in the polar
            % coordinates
            if img(y, x) == 255
                for t=1:length(thetas)
                    rho = y*cos(thetas(t)) + x*sin(thetas(t));
                    rho_ind = floor((rho+img_diagonal)/rho_step)+1;
                    
                    hough_img(rho_ind, t) = hough_img(rho_ind, t) + 1;
                end
            end
        end
    end
    
    % I tried implementing some kind of patch voting but I was getting worse
    % results for line detecting, so I stuck to single bin voting
    
    % voting_mat = zeros(size(hough_img));
    % hough_img = padarray(hough_img, [1, 1]);
    % for i=1:size(voting_mat, 1)
    %     for j=1:size(voting_mat, 2)
    %         voting_mat(i, j) = sum(sum(hough_img(i:i+2, j:j+2)));
    %     end
    % end
    % hough_img = voting_mat;
    
    % We are scaling the image to [0, 255]
    hough_img = round(hough_img/max(max(hough_img))*255);
end

