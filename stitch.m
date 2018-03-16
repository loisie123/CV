function [] = stitch(left, right)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    [transformation] = RANSAC_MIRTHE( right, left );
    
    % find transformation operators
    M = [transformation(1:2)'; transformation(3:4)']; 
    t = transformation(5:6);

    % read image
    right = rgb2gray(imread(right));
    left = rgb2gray(imread(left));
    
    [hr, wr] = size(right);
    [hl, wl] = size(left);
    
    corners = zeros(2, 4);
    
    corners(:,1) = round(M * [1;1] + t)';
    corners(:,2) = round(M * [1;wr] + t)';
    corners(:,3) = round(M * [hr;1] + t)';
    corners(:,4) = round(M * [hr;wr] + t)';
    
    max_height = max([hl, max(corners(1,:))]);
    min_height = min([1, min(corners(1,:))]);
    height_stitch = max_height - (min_height - 1);
    
    max_width = max([wl, max(corners(2,:))]);
    min_width = min([1, min(corners(2,:))]);
    width_stitch = max_width - (min_width - 1);
    
    stitched_image = zeros(height_stitch, width_stitch);
    
    for x=1:hl
        for y=1:wl
            x_prime = x - (min_height - 1);
            y_prime = y - (min_width - 1);
            stitched_image(x_prime, y_prime, :) = left(x,y);
        end
    end
    
    for x=1:hr
        for y=1:wr
            coordinates = round(M * [x; y] + t);
            x_prime = coordinates(1,1) - (min_height - 1);
            y_prime = coordinates(2,1) - (min_width - 1);
            %disp(x_prime)
            %disp(y_prime)
            if stitched_image(x_prime, y_prime) == 0
                stitched_image(x_prime, y_prime) = right(x,y);
            end
        end
    end
    
    figure;
    imshow(stitched_image, []);
    
end

