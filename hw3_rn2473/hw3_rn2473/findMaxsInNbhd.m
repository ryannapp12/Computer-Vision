function max_in_nbhd = findMaxsInNbhd(hough_accumulator, nbhd)
    % Creating the binary matrix which will keep the max in nbhd elements
    max_in_nbhd = zeros(size(hough_accumulator));
    pad_num = round((nbhd-1)/2);
    % Padding input matrix to be able to search in the nbhd ef edge
    % elements
    padded_ha = padarray(hough_accumulator, [pad_num, pad_num]);
    size(padded_ha);
    middle_patch_ind = round(((nbhd-1)/2)+1);
    for i=1:size(hough_accumulator, 1)
        for j=1:size(hough_accumulator, 2)
            tmp_mat = padded_ha(i:i+nbhd-1, j:j+nbhd-1);
            [M,I] = max(tmp_mat(:));
            [I_row, I_col] = ind2sub(size(tmp_mat),I);
            % If the greatest is the one we're expecting we set the element
            % with those indexes to true
            if I_row == middle_patch_ind && I_col == middle_patch_ind
                max_in_nbhd(i, j) = 1;
            end
        end
    end
end
