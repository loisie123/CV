function [transformation] = RANSAC_MIRTHE( keypoints1, keypoints2, matches )
    %UNTITLED6 Summary of this function goes here
    %   Detailed explanation goes here

    P = 4;
    N = 1;
    height_A = 2 * size(matches, 2);

    vl_plotframe(keypoints1(:, matches(1, indices)));

    % define A and b
    A = zeros(height_A, 6);
    A(1:2:height_A, 1:2) = keypoints1(1:2, matches(1, :))';
    A(2:2:height_A, 3:4) = keypoints1(1:2, matches(1, :))';
    A(1:2:height_A, 5) = A(1, 5, :) + 1;
    A(2:2:height_A, 6) = A(2, 6, :) + 1;
    b = keypoints2(1:2, matches(2, :));

    score = 0;
    transformation = zeros(6);

    for n=1:N
        permutation = randperm(size(matches,2));
        selected = permutation(1:P);
        indices = ..

%         A = zeros(height_A, 6);
%         A(1:2:height_A, 1:2) = keypoints1(1:2, matches(1, indices))';
%         A(2:2:height_A, 3:4) = keypoints1(1:2, matches(1, indices))';
%         A(1, 5, :) = A(1, 5, :) + 1;
%         A(2, 6, :) = A(2, 6, :) + 1;
%         b = keypoints2(1:2, matches(2, indices));

        new_transformation = pinv(A) * b;

        error = A * new_transformation - b;
        new_score = compute_score(error);
        if new_score > score
            score = new_score;
            transformation = new_transformation;
        end
    end
end


function score = compute_score(error)
    score = 0;
    for i=1:round(size(error,2))
        if error(2*i-1)+error(2*i)<=10
            score = score + 1;
        end
    end
end



