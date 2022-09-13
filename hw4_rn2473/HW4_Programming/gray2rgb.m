function rgbImage = gray2rgb(grayImage)
    rgbImage = cat(3, grayImage, grayImage, grayImage);
end