function refocusApp(rgb_stack, depth_map)

    rgb_stack = uint8(rgb_stack);
    rgb_stack(:, :, 1:3);
    imagesc(rgb_stack(:, :, 1:3));
    prev_ind = 1;
    
    figure(1)
    while(1)
        axis([-100, size(rgb_stack, 2)+100, ...
                    -100, size(rgb_stack, 1)+100])
        [x, y] = ginput(1);
        if (round(x) <= 0 || round(y) <= 0 || round(x) > size(rgb_stack, 2) ...
                || round(y) > size(rgb_stack, 1))
            break;
        end
        next_focused_ind = depth_map(round(y), round(x));
        if(next_focused_ind > prev_ind)
            for i=prev_ind:next_focused_ind
                imagesc(rgb_stack(:, :, 3*i-2:3*i))
                axis([-100, size(rgb_stack, 2)+100, ...
                    -100, size(rgb_stack, 1)+100])
                pause(0.003)
            end
        else
            for i=prev_ind:-1:next_focused_ind
                imagesc(rgb_stack(:, :, 3*i-2:3*i))
                axis([-100, size(rgb_stack, 2)+100, ...
                    -100, size(rgb_stack, 1)+100])
                pause(0.003)
            end
        end
        prev_ind = next_focused_ind;
    end
    close(1)
end
