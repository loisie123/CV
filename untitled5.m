figure;
yourImage = imread('boat1.pgm');
imshow(yourImage);
hold on;
x = [10 20 30]
y = [10 20 30]
plot(x, y, 'r*', 'LineWidth', 2, 'MarkerSize', 15);
title('Bottle wit coordinates on it', 'FontSize', 24);