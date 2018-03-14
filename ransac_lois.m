function [transformation] = ransac_lois(input_image1, input_image2, N, pairs, T)
% %fuction that follows the ransac algorithm 
% Input_image1 and input image2: the images that are compared. 
% N : The amount of times the ransac is done
% T : The amount of matches
% P : pick P amount of matches from T 


[points matches f1 f2 d1 d2] = keypoint_matching_lois(input_image1, input_image2, T);
count = 0 

for n =1:N
    figure; 
    count_inliers = 0 ;
    % choose P pairs fromt the matches.
    A = []
    b = []
    for p = 1:pairs
        % get the x and y values of the matched points. 
        point = points(randi(length(points),1,1));
        x1 = f1(1,matches(1,point)) ;
        y1 = f1(2,matches(1,point)) ;
        x2 = f2(1,matches(2,point)) ;
        y2 = f2(2,matches(2,point)) ;
        row1 = [x1 y1 0 0 1 0 ];
        row2 = [0 0 x1 y1 0 1];
        A = [A; row1 ; row2]
        b = [b; x2 ;y2];   
    end
     
    trans = pinv(A) * b
    
    
    % Construct A 
    % Construct B
    
    x_trans_list = [];
    y_trans_list = [];
   
    
    imshow(cat(2, imread(input_image1), imread(input_image2)));
    hold on
    
    % transform the matched points
    for punt = 1:length(points)
        
        x_old = f1(1,matches(1,points(punt))) ;
        y_old = f1(2,matches(1,points(punt))) ;
        
        A = [x_old y_old 0 0 1 0 ; 0 0 x_old y_old 0 1];
        transjoe = A * trans;
        
        
        x_trans = transjoe(1);
        y_trans = transjoe(2);
        x_trans_list = [x_trans_list , x_trans];
        y_trans_list = [y_trans_list, y_trans];
        
        
        x_new = f2(1,matches(2,punt)) ;
        y_new = f2(2,matches(2,punt)) ;
        
        
        dist =sqrt((y_trans-y_new)^2+(x_trans-x_new)^2);
        
        if dist < 10
            count_inliers = count_inliers + 1;
            
        end
        
    end

    x = f1(1,matches(1,points)) ;
    y = f1(2,matches(1,points)) ;
    
    % to plot add the size of the image
    x_list = x_trans_list ;
    
        % show the image nex to eahtother
     h1 = line([x ; x_list], [y ; y_trans_list]) ;
     set(h1,'linewidth', 1, 'color', 'r') ; 
       
     vl_plotframe(f1(:,matches(1,points))) ;
     
     plot(x_list, y_trans_list, 'b*', 'LineWidth', 2, 'MarkerSize', 15);
    % if this count is best, save the transformation
    if count_inliers > count -1
        transformation = trans;
        count = count_inliers;
    end
    
end












end