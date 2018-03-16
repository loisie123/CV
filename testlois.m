
% 
% 
% 
% N = 5;
% pairs = 4;
% T = 50;
% transformation = ransac_lois('boat1.pgm', 'boat2.pgm', N, pairs, T, 'joe');
figure;
transformation = ransac_lois('boat2.pgm', 'boat1.pgm', 5, 4, 50, 'bla');


% %             
% 
% 
% pairs = [2,3,4];
% N = [2,5,10];
% T = 10;
% figure;
% l = 1
% 
% for i= 1:length(pairs)
%     for j= 1:length(N)
%         
%         subplot(3, 3,l )
%         %hold on
%         transformation = ransac_lois('boat2.pgm', 'boat1.pgm', N(j), pairs(i), T, 'bla');
%  
%         l = l +1
%         
%     end
% end
% 

