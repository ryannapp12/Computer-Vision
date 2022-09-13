function [obj_db, out_img] = compute2DProperties(labeled_img)
obj_db = zeros(6, max(max(labeled_img)));
obj_db(1, :) = 1:max(max(labeled_img));
% TODO:
% Format the matrix for only the corner values we need
% Difference between the points
% Save the corner values into vectors
corners = corner(labeled_img);
tmp_vect = [];

for i = 1:4:length(corners)
    tmp = abs(corners(i, 2) - (corners(i+1, 2)));
    tmp = ceil(tmp/2) + corners(i, 2);
    tmp_vect = [tmp_vect tmp];
end
obj_db(2, [1:size(corners, 1)/4]) = tmp_vect;
%test = find(labeled_img == 4);

tmp_vect = [];
% fully sort to allow consistency
sortX = sort(corners(:, 1), 'descend');
for i = 1:4:length(corners)
    tmp = abs(sortX(i, 1) - (sortX(i + 2, 1)));
    tmp = ceil(tmp/2) + sortX(i + 2, 1);
    tmp_vect = [tmp_vect tmp];
end
obj_db(3, [1:size(corners, 1)/4]) = tmp_vect;
tmp_vectB = obj_db(2, [1:3]);
figure;
imshow(labeled_img);
hold on; 
plot(corners(:,1), corners(:,2), 'r*')
%plot(test, 'g*')
plot(tmp_vect, tmp_vectB, 'g*')
%plot(81, 211, 'r*')

area = [];
for i = 1:max(max(labeled_img))
    area = [area sum((labeled_img == i), 'all')];
end


% Could not figure out how to finish the rest, To run, type
% compute2DProperties(img) into the command line
