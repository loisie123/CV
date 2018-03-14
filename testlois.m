N = 5;
pairs = 4;
T = 50;

transformation = ransac_lois('boat1.pgm', 'boat2.pgm', N, pairs, T);


transformation