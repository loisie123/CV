function [stitched_image] = stitch(left, right, N, T, P)
% %function that creates a stitched image
% left, right: the images that are compared
% N : The amount of times the ransac is done
% T : The amount of matches
% P : pick P amount of matches from T 
% output:
% stiched_image

    % find affine transformation
    [transformation] = ransac(right, left, N, T, P, 'nop');
    
    % find transformation operators
    M = [transformation(1:2)'; transformation(3:4)']; 
    t = transformation(5:6);

    % read image and find the sizes
    right = rgb2gray(imread(right));
    left = rgb2gray(imread(left));
    [hr, wr] = size(right);
    [hl, wl] = size(left);
    
    % find corners of the stiched-images
    corners = zeros(2, 4);
    corners(:,1) = round(M * [1;1] + t)';
    corners(:,2) = round(M * [1;wr] + t)';
    corners(:,3) = round(M * [hr;1] + t)';
    corners(:,4) = round(M * [hr;wr] + t)';
    
    % find height of stitched image
    max_height = max([hl, max(corners(1,:))]);
    min_height = min([1, min(corners(1,:))]);
    height_stitch = max_height - (min_height - 1);
    
    % find width of stitched image
    max_width = max([wl, max(corners(2,:))]);
    min_width = min([1, min(corners(2,:))]);
    width_stitch = max_width - (min_width - 1);
    
    % create a (black) framework for the stiched image
    stitched_image = zeros(height_stitch, width_stitch);
    
    % put all pixels of the left image at the stiched image
    for x=1:hl
        for y=1:wl
            x_prime = x - (min_height - 1);
            y_prime = y - (min_width - 1);
            stitched_image(x_prime, y_prime, :) = left(x,y);
        end
    end
    
    % put all pixels of the transformed right image on the stitched image
    for x=1:hr
        for y=1:wr
            coordinates = round(M * [x; y] + t);
            x_prime = coordinates(1,1) - (min_height - 1);
            y_prime = coordinates(2,1) - (min_width - 1);
            if stitched_image(x_prime, y_prime) == 0
                stitched_image(x_prime, y_prime) = right(x,y);
            end
        end
    end
    
    % show the stitched image
    figure;
    imshow(stitched_image, []);
    
end

