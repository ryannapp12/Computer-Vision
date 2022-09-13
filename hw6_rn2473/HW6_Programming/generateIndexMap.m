function index_map = generateIndexMap(gray_stack, w_size)

    % defining the 3x3 filter for calculating laplacian
    laplacian_mat = [-1, -1, -1; -1, 8, -1; -1, -1, -1];
    % defining the window for calculating the sum of laplacians
    window = ones(2*w_size + 1, 2*w_size + 1);
    
    % calculating the laplacians using imfilter function
    % which is much more optimized than writing for loops
    % we calculate absolute value of laplacian
    lpl_stack = abs(imfilter(gray_stack, laplacian_mat));
    
    % summing within the defined window
    focus_measure_mat = imfilter(lpl_stack, window);
    
    % generating index map out of index values along the
    % third dimension of the matrix where the sums are
    % the ones with the highest value of sum of laplacians
    % has the most of the hight frequencies and is the
    % focused one
    [M, index_map] = max(focus_measure_mat, [], 3);

end
