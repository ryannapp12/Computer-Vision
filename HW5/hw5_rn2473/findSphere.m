function [center, radius] = findSphere(img)

    bw_mask = im2bw(img, 0);
    
    stats = regionprops('table',bw_mask,'Centroid',...
    'MajorAxisLength','MinorAxisLength');

    center = stats.Centroid;
    diameter = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
    radius = diameter/2;


end