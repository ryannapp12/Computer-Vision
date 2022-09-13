function cropped_line_img = lineSegmentFinder(orig_img, hough_img, hough_threshold)
    cropped_line_img = orig_img;
    over_thresh = hough_img > hough_threshold;
    thresh = 0.25;
    edge_img = edge(orig_img,'canny', thresh);
    maxs_in_nbhd = findMaxsInNbhd(hough_img, 9);
    thetas = linspace(-pi/2, pi/2, size(hough_img, 2));
    img_diagonal = round(sqrt(size(orig_img, 1)^2 + size(orig_img, 2)^2));
    rhos = linspace(-img_diagonal, img_diagonal, size(hough_img, 1));
    x = 1:size(orig_img, 1);
    for i=1:size(hough_img, 1)
        for j=1:size(hough_img, 2)
            if over_thresh(i, j) == 1 && maxs_in_nbhd(i, j) == 1
                theta = thetas(j);
                rho = rhos(i);
                y = round((rho - x*sin(theta))/cos(theta));
                x_plot = x(y>=1 & y<=size(orig_img, 2));
                y_plot = y(y>=1 & y<=size(orig_img, 2));
                for seg=1:length(x_plot)-1
                    if edge_img(x_plot(seg), y_plot(seg)) == 1 || edge_img(x_plot(seg+1), y_plot(seg+1)) == 1
                    cropped_line_img = insertShape(cropped_line_img,'Line',[x_plot(seg) y_plot(seg) x_plot(seg+1) y_plot(seg+1)],'LineWidth',2,'Color','red');
                    end
                end
            end
        end
    end
end
