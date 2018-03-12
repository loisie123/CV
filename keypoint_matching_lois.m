function [] = keypoint_matching_lois(input_1, input_2, matches)
% function that computes the interest points of two images. 

% 
% figure;
% subplot(1,2,1)
% imshow(input_1);
% subplot(1,2,2);
% imshow(input_2);
% hold on;

% 

if size(imread(input_1) ,3)==3
    image1 = single(rgb2gray(imread(input_1)));
    image2 = single(rgb2gray(imread(input_2)));
else
    image1 = single(imread(input_1));
    image2 = single(imread(input_2));
end

Ia = imread(input_1) ;
Ib = imread(input_2) ;

[fa,da] = vl_sift(image1) ;
[fb,db] = vl_sift(image2) ;


[matches, scores] = vl_ubcmatch(da,db) ;

[drop, perm] = sort(scores, 'descend') ;
matches = matches(:, perm) ;
scores  = scores(perm) ;

figure(1) ; clf ;
imagesc(cat(2, Ia, Ib)) ;
axis image off ;

% 
% figure(2) ; clf ;
% imagesc(cat(2, Ia, Ib)) ;
% 
% xa = fa(1,matches(1,:)) ;
% xb = fb(1,matches(2,:)) + size(Ia,2) ;
% ya = fa(2,matches(1,:)) ;
% yb = fb(2,matches(2,:)) ;
% 
% hold on ;
% h = line([xa ; xb], [ya ; yb]) ;
% set(h,'linewidth', 1, 'color', 'b') ;
% 
% vl_plotframe(fa(:,matches(1,:))) ;
% fb(1,:) = fb(1,:) + size(Ia,2) ;
% vl_plotframe(fb(:,matches(2,:))) ;
% axis image off ;

% figure(2) ; clf ;
% image(cat(2 ,imread(input_1), imread(input_2))) ;
% 
% % extract and match 
% [f1,d1] = vl_sift(image1);
% [f2,d2] = vl_sift(image2);
% [match, scores] = vl_ubcmatch(d1, d2);
% 
% x1 = f1(1,match(1,1:50)) ;
% x2 = f2(1,match(2,1:50)) + size(image1,2) ;
% y1 = f1(2,match(1,1:50)) ;
% y2 = f2(2,match(2,1:50)) ;
% 
% 
% h = line([x1 ; x2], [y1 ; y2]) ;
% set(h,'linewidth', 1, 'color', 'b') ;
% 
% vl_plotframe(f1(:,match(1,1:50))) ;
% f2(1,:) = f2(1,:) + size(image2,2) ;
% vl_plotframe(f2(:,match(2,1:50))) ;
% axis image off ;


end

% 
% perm = randperm(size(f1,2)) ;
% sel = perm(1:matches) ;
% h1 = vl_plotframe(f1(:,sel)) ;
% h2 = vl_plotframe(f1(:,sel)) ;
% set(h1,'color','k','linewidth',3) ;
% set(h2,'color','y','linewidth',2) ;
% % 
% h3 = vl_plotsiftdescriptor(d1(:,sel),f1(:,sel)) ;
% set(h3,'color','g') ;
% subplot(1,2,2)
% imshow(input_2)
% 
% perm2 = randperm(size(f2,2)) ;
% sel2 = perm2(1:matches) ;
% h12 = vl_plotframe(f2(:,sel2)) ;
% h22 = vl_plotframe(f2(:,sel2)) ;
% set(h12,'color','k','linewidth',3) ;
% set(h22,'color','y','linewidth',2) ;
% % 
% h32 = vl_plotsiftdescriptor(d2(:,sel2),f2(:,sel2)) ;
% set(h32,'color','g') ;
% end