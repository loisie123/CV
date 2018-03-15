function [keypoints1, keypoints2, matches] = keypoint_matching_MIRTHE(image1, image2, draw_image)

    % read image
    if size(imread(image1) ,3)==3
        image1 = rgb2gray(imread(image1));
        image2 = rgb2gray(imread(image2));
    else
        image1 = imread(image1);
        image2 = imread(image2);
    end
    I1 = single(image1);
    I2 = single(image2);

    % find keypoints and matches
    [keypoints1, descriptors1] = vl_sift(I1) ;
    [keypoints2, descriptors2] = vl_sift(I2) ;
    [matches, ~] = vl_ubcmatch(descriptors1, descriptors2) ;

    if draw_image
         % create image
         imshow([image1, image2]);
         keypoints2(1, :) = keypoints2(1, :) + size(image1,2); % change y-coordinates of keypoint image2
         permutation = randperm(size(matches,2));
         indices = permutation(1:50);
         vl_plotframe(keypoints1(:, matches(1, indices)));
         vl_plotframe(keypoints2(:, matches(2, indices)));
         hold on
         x1 = keypoints1(1, matches(1, indices));
         x2 = keypoints2(1, matches(2, indices));
         y1 =  keypoints1(2, matches(1, indices));
         y2 = keypoints2(2, matches(2, indices));
         l = line([x1;x2],[y1;y2]);
         set(l,'linewidth', 1, 'color', 'y') ;

         keypoints2(1, :) = keypoints2(1, :) - size(image1,2);
    end
    
end