%{
Ryan Napolitano
rn2473

Challenge 1b)
It was suggested in the assignment that if we get bad results we should 
try voting for small patch of bins rather than a single bin in the 
accumulator array. Even though voting for small patch of bins was helpful 
for getting a clearer plot of the points from (x, y) coordinate system in 
the polar coordinates it was creating issues later when trying to detect 
correct peaks which correspond to the best lines in the image. Therefore 
single bin voting was applied in the end.


Challenge 1c)
Method used to detect the lines is the proposed threshold method combined 
with keeping only peaks which have the greatest value in some defined 
neighborhood NxN. In the end N that way kept in my algorithm was 9. Which 
means for a line to be detected it has to be max in the neighborhood 9x9 
and it's value has to be above some predefined threshold. That neighborhood 
was discarding most of the duplicates and keeping most of the near but 
correct lines.

%}