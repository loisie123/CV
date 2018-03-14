[keypoints1, keypoints2, matches] = keypoint_matching_MIRTHE('boat1.pgm', 'boat2.pgm');

RANSAC_MIRTHE( keypoints1, keypoints2, matches );