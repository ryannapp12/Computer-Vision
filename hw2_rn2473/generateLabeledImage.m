function labeled_img = generateLabeledImage(gray_img, threshold)
img = imread(gray_img);
bw_img = im2bw(img, threshold);
labeled_img = bwlabel(bw_img);
end
