
%% 
[keypoints1, keypoints2, matches] = keypoint_matching_MIRTHE('boat1.pgm', 'boat2.pgm', false);
%% 
RANSAC_MIRTHE( 'boat1.pgm', 'boat2.pgm');
%%

disp("begin")
stitch('left.jpg', 'right.jpg', 100000, 4, 50);
disp("klaar")

%% 
transformation = ransac('boat1.pgm', 'boat2.pgm', 10, 3, 50, 'nop');