// 1. Read img (3D)
img = imread("D:/HCMUT/Digital Signal Processing/Lab/Lab4/img_test.png");
// 2. convert to Gray img
img_gray = rgb2gray(img); 
// 3. Blur
h = ones(5,5)/25;
img_blur = imfilter(img, h);
// 4. Histogram Equalization 
img_eq = imhistequal(img_gray); 


clf(); 

subplot(2,2,1);
imshow(img);
xtitle("Original (Color)");

subplot(2,2,2);
imshow(img_blur);
xtitle("Blurred (Color)");

subplot(2,2,3);

plot2d(imhist(img_gray));
xtitle("Grayscale Histogram");

subplot(2,2,4);
imshow(img_eq);
xtitle("Equalized (Grayscale)");
