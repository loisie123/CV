% demo question 1 


% this part you can make a transformation with the two images. Both ways.


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
T = 10;
figure;
l = 1;
% 
% for i= 1:length(pairs)
%     for j= 1:length(N)
%         subplot(3, 3,l );
%         transformation = ransac('boat2.pgm', 'boat1.pgm', N(j), pairs(i), T, 'nop');
%         l = l +1 ;
%     end
% end
% 
% 
    