close all
clear all
%���벢��ʾ��ȡ�Ǽܲ���ֵ����ͼƬ/����
load Ibw
figure,subplot(1,2,1)
imshow(Ibw)
title('Input BW image')

I1 = mydeburring(Ibw,0.15);
%�ظ�һ��ȥë���㷨
I2 = mydeburring(I1,0.15);
subplot(1,2,2)
imshow(I2)
title('Deburred image')

