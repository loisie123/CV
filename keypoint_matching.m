function [vector matches f1 f2] = keypoint_matching(input_1, input_2, B, draw_image)
% function that computes the interest points of two images. 
% input:
%   input_1: original image
%   input_2: compared image
%   B : size of batch
%   draw_image: true or fales wheter an image is shown. 
% output:
%   vector: list of points that are chosen
%   matches: the matched points
%   f1: keypoints first image
%   f2: keypoints second image


    % read the images
    Ib = imread(input_1) ;
    Ia = imread(input_2) ;
    
    % make images same size
    if size(Ia) ~= size(Ib)
        [rowsA colsA numberOfColorChannelsA] = size(Ia); 
        [rowsB colsB numberOfColorChannelsB] = size(Ib);  
        if rowsB ~= rowsA || colsA ~= colsB  
            Ib = imresize(Ib, [rowsA colsA]); 
        end
    end
    
    
    % read image
    if size(Ia ,3)==3
        image1 = single(rgb2gray(Ia));
        image2 = single(rgb2gray(Ib));
    else
        image1 = single(imread(input_1));
        image2 = single(imread(input_2));
    end

    % find keypoints and matches
    [f1,d1] = vl_sift(image1) ;
    [f2,d2] = vl_sift(image2) ;
    [matches, ~] = vl_ubcmatch(d1,d2) ;

    % get the indices of the points that are chosen to be matched.
    vector = randi(length(matches), 1, B);
    x1 = f1(1,matches(1,vector)) ;
    y1 = f1(2,matches(1,vector)) ;
    x2 = f2(1,matches(2,vector)) + size(image1,2) ;
    y2 = f2(2,matches(2,vector)) ;

    if draw_image == 'yes'  
        figure(1) ; clf ;
        imshow(cat(2, Ia, Ib)) ;

        % draw the lines
        h = line([x1 ; x2], [y1 ; y2]) ;
        set(h,'linewidth', 1, 'color', 'r') ;
        vl_plotframe(f1(:,matches(1,vector))) ;
        f2(1,:) = f2(1,:) + size(image2,2) ;
        vl_plotframe(f2(:,matches(2,vector))) ;
        axis image off ;
    end

end
