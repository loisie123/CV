% demo question 1 


% this part you can make a transformation with the two images. Both ways.
% when you want to see the images while performing the RANSAC see yes
% instead of nop


N = 5;
pairs = 4;
T = 50;
figure;
transformation = ransac('boat1.pgm', 'boat2.pgm', N, pairs, T, 'nop');
figure;
transformation = ransac('boat2.pgm', 'boat1.pgm', 10, 4, 50, 'nop');


% This part is for testing different parameters           
pairs = [2,3,4];
N = [2,5,10];
figure;
l = 1;

for i= 1:length(pairs)
    for j= 1:length(N)
        subplot(3, 3,l );
        transformation = ransac('boat2.pgm', 'boat1.pgm', N(j), pairs(i), T, 'nop');
        l = l +1 ;
    end
end



disp("begin")

stitch('left.jpg', 'right.jpg', 20, 10, 50);
%disp("klaar")

% Ia = imread('left.jpg');
% 
% size(Ia)
% Ib = imread('right.jpg');
% size(Ib)s
% %imshow(cat(2, Ia, Ib)) ;
% subplot(1,2,1), imshow(Ia)
% subplot(1,2,2), imshow(Ib)
% 
% figure
% % Get size of existing image A. 
% [rowsA colsA numberOfColorChannelsA] = size(Ia); 
% % Get size of existing image B. 
% [rowsB colsB numberOfColorChannelsB] = size(Ib); 
% % See if lateral sizes match. 
% if rowsB ~= rowsA || colsA ~= colsB 
% % Size of B does not match A, so resize B to match A's size.  
% B = imresize(Ib, [rowsA colsA]);
% end
% 
% stitch('left.jpg', B, 1000, 4, 50)
% imshow(cat(2, Ia, B))
