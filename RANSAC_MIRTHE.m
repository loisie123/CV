function [transformation] = RANSAC_MIRTHE( image1, image2 )
    %UNTITLED6 Summary of this function goes here
    %   Detailed explanation goes here
    
    
    [keypoints1, keypoints2, matches] = keypoint_matching_MIRTHE(image1, image2, false);
    
    % read image
    image1 = imread(image1);
    image2 = imread(image2);
    

    P = 4;
    N = 1;
    height_A = 2 * size(matches, 2);

    % define A and b
    A = zeros(height_A, 6);
    A(1:2:height_A, 1:2) = keypoints1(1:2, matches(1, :))';
    A(2:2:height_A, 3:4) = keypoints1(1:2, matches(1, :))';
    A(1:2:height_A, 5) = A(1, 5, :) + 1;
    A(2:2:height_A, 6) = A(2, 6, :) + 1;
    b = reshape(keypoints2(1:2, matches(2, :)), height_A, 1);

    score = 0;
    transformation = zeros(6);

    for n=1:N
        permutation = randperm(size(matches,2));
        selected = permutation(1:P);
        indices = sort(reshape([2*selected, 2*selected - 1], 2*P, 1));
        new_transformation = pinv(A(indices,:)) * b(indices);
        error = A * new_transformation - b;
        new_score = compute_score(error);
        if new_score > score
            score = new_score;
            transformation = new_transformation;
        end
    end
    
    M = [transformation(1:2)'; transformation(3:4)']; 
    size(M)
    t = transformation(5:6);
    
    trans_image = zeros(size(image1));
    for x=1:size(image1, 1)
        for y=1:size(image1, 2)
            coordinates = round(M * [x;y] + t);
            if coordinates(1,1) > 1 && coordinates(2,1) > 1
                trans_image(coordinates) = image1(x, y);
            end
        end
    end
    
    
    % transformed_image = imtransform(image1, transformation);
    
    
    % nearest neightborhood interpolation is dat je afrond naar dichtstbij
    % zijnde pixel
end


function score = compute_score(error)
    score = 0;
    for i=1:round(size(error,2))
        if error(2*i-1)+error(2*i)<=10
            score = score + 1;
        end
    end
end



