Ryan Napolitano (rn2473)
Computer Vision, Spring 2021
Professor Nayar
Homework 5 - Programming


Challenge 1b:

Formula - 

            % Length of the projection to the xy-plane
            r_p = sqrt((center(1) - x_m)^2 + (center(2) - y_m)^2);
            % For x, y and z as from grad image for sphere
            % And the clarification from the runHw5.m for the
            % normals direction mapping
            ld_x = (y_m - center(2))/r_p; % Using columns for x
            ld_y = (x_m - center(1))/r_p; % Using rows for y
            ld_z = sqrt(1 - (r_p/radius)^2);
            dir_vec = [ld_x, ld_y, ld_z];


In the formula for light intensity on a Lambertian surface we 
have dot product of the normal vector and the light source direction vector. 
The value of the dot product is max when those two vectors have the same direction. 
That's why it's safe to assume that the direction of the normal for the 
brightest pixel is the direction of the light source.