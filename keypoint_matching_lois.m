function [vector matches f1 f2 d1 d2] = keypoint_matching_lois(input_1, input_2, N, show_between)
% function that computes the interest points of two images. 

if size(imread(input_1) ,3)==3
    image1 = single(rgb2gray(imread(input_1)));
    image2 = single(rgb2gray(imread(input_2)));
else
    image1 = single(imread(input_1));
    image2 = single(imread(input_2));
end

% read the images
Ia = imread(input_1) ;
Ib = imread(input_2) ;

% get the interestpoints in both images
[f1,d1] = vl_sift(image1) ;
[f2,d2] = vl_sift(image2) ;
[matches, scores] = vl_ubcmatch(d1,d2) ;

%sort the scores

if show_between == 'joe'
    
    figure(1) ; clf ;
    imshow(cat(2, Ia, Ib)) ;
end
vector = randi(length(matches), 1, N)

x1 = f1(1,matches(1,vector)) ;
y1 = f1(2,matches(1,vector)) ;
x2 = f2(1,matches(2,vector)) + size(image1,2) ;
y2 = f2(2,matches(2,vector)) ;

if show_between == 'joe'
    h = line([x1 ; x2], [y1 ; y2]) ;
    set(h,'linewidth', 1, 'color', 'r') ;

    vl_plotframe(f1(:,matches(1,vector))) ;
    f2(1,:) = f2(1,:) + size(image2,2) ;
    vl_plotframe(f2(:,matches(2,vector))) ;
    axis image off ;
end

end
