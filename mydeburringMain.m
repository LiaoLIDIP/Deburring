close all
clear all
%输入并显示提取骨架并二值化的图片/数据
load Ibw
figure,subplot(1,2,1)
imshow(Ibw)
title('Input BW image')

I1 = mydeburring(Ibw,0.15);
%重复一次去毛刺算法
I2 = mydeburring(I1,0.15);
subplot(1,2,2)
imshow(I2)
title('Deburred image')

