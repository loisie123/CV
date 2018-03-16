function [transformation] = ransac(input_image1, input_image2, N, pairs, B, display_image)
% %fuction that follows the ransac algorithm 
% input:
%   input_image1, input image2: the images that are compared 
%   N : number of iterations for doing RANSAC
%   B : size of batch for keypoint_matching
%   P : size of matching pairs for doing RANSAC
%   display-image: whether or not some images must be displayed
% output:
%   transformation: transformation parameters

    [points matches keypoints1 keypoints2] = keypoint_matching(input_image1, input_image2, B, display_image);

    count = 0 ;
    for n =1:N

        count_inliers = 0;

        % choose P pairs fromt the matches.
        A = [];
        b = [];
        for p = 1:pairs

            % get the x and y values of the matched points. 
            point = points(randi(length(points),1,1));
            x1 = keypoints1(1,matches(1,point)) ;
            y1 = keypoints1(2,matches(1,point)) ;
            x2 = keypoints2(1,matches(2,point)) ;
            y2 = keypoints2(2,matches(2,point)) ;

            %construct A and b
            row1 = [x1 y1 0 0 1 0 ];
            row2 = [0 0 x1 y1 0 1];
            A = [A; row1 ; row2];
            b = [b; x2 ;y2];
            
        end

        trans = pinv(A) * b;
        x_trans_list = [];
        y_trans_list = [];

        if display_image == 'yes'
            figure;
            imshow(cat(2, imread(input_image1), imread(input_image2)));
            hold on
        end

        % transform all the matched points
        for punt = 1:length(points)

            x_old = keypoints1(1,matches(1,points(punt))) ;
            y_old = keypoints1(2,matches(1,points(punt))) ;

            A = [x_old y_old 0 0 1 0 ; 0 0 x_old y_old 0 1];
            transjoe = A * trans;

            x_trans = transjoe(1);
            y_trans = transjoe(2);
            x_trans_list = [x_trans_list , x_trans];
            y_trans_list = [y_trans_list, y_trans];

            x_new = keypoints2(1,matches(2,punt)) ;
            y_new = keypoints2(2,matches(2,punt)) ;

            % check the radius
            dist =sqrt((y_trans-y_new)^2+(x_trans-x_new)^2);

            if dist < 10
                count_inliers = count_inliers + 1;    
            end   
        end

        x = keypoints1(1,matches(1,points)) ;
        y = keypoints1(2,matches(1,points)) ;

        % to plot add the size of the image
        x_list = x_trans_list ;

         if display_image == 'yes'
             % show image
             h1 = line([x ; x_list], [y ; y_trans_list]) ;
             set(h1,'linewidth', 1, 'color', 'r') ; 
             vl_plotframe(keypoints1(:,matches(1,points))) ;
             plot(x_list, y_trans_list, 'b*', 'LineWidth', 2, 'MarkerSize', 15);
         end

        % if this count is best, save the transformation
        if count_inliers > count -1
            transformation = trans;
            count = count_inliers;
        end
    end

    % read image
    if size(imread(input_image1) ,3)==3
        image = rgb2gray(imread(input_image1));
    else
        image = imread(input_image1);
    end

    % transform the image using transformation rules
    M = [transformation(1:2) , transformation(3:4)];
    t = [transformation(5:6)];
    [n, m] = size(image);
    trans_image = zeros(n, m);
    for x=1:n
        for y=1:m 
            coordinates = round(M * [x;y] + t );
            xnew = coordinates(1,1);
            ynew = coordinates(2,1);
            if xnew > 1 && xnew < n &&  ynew >1 && ynew < m
                trans_image(xnew, ynew )= image(x, y);   
            end
        end
    end

    if display_image ~= 'yes' 
        imshow(mat2gray(trans_image))
    end

    % transform image using imtransform and transformation
    tform = zeros(3,3);
    tform(1:2,1:2) = M  ;
    %reshape(transformation(1:4),2, 2);
    tform(3,3)= 1;

    t = maketform('affine',tform);
    transformed = imtransform(image,t,'nearest');

    if display_image ~= 'yes'
        figure;
        imshow( transformed);
        title(['N = ' num2str(N) ' and p =  ' num2str(pairs) '. ' ]);
    end

end