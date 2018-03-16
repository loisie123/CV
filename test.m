
%% 
[keypoints1, keypoints2, matches] = keypoint_matching_MIRTHE('boat1.pgm', 'boat2.pgm', false);
%% 
RANSAC_MIRTHE( 'boat1.pgm', 'boat2.pgm');
%%
disp("gvd")
stitch('left.jpg', 'right.jpg');
disp("klaar")