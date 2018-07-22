function Io = mydeburring(Ibw,per)
%��ֵͼ��ȥë���㷨
%Input:
%       Ibw -- ��ȡ�Ǽܲ��Ҷ�ֵ�����ͼƬ
%       per -- ȥë�̲�����[0 - 1];
%                 ������ë���������С�ڸø��Ǽ����������ص�per��ʱ��
%                 ɾ���ÿ���ë��;
%                 ֵԽ��ȥ��Ч��Խ���ԣ���Խ��Խ�п����˺�ԭ�Ǽ���̬.
%Output:
%       Io -- ȥ��ë�̺��ͼƬ
%
%Auther: L. LIAO
%IDIPLAB
%Date: July 22, 2017

if (per >1 || per < 0)
    error('per should be [0 - 1]');
end

[m n] = size(Ibw);
Ibw(Ibw >1) = 1;
Icut = zeros(m,n);
for i=2:m-1
    for j=2:n-1
        if (Ibw(i,j) > 0 && Ibw(i-1,j-1)+Ibw(i-1,j)+Ibw(i-1,j+1) ...
                +Ibw(i,j-1)+Ibw(i,j+1) ...
                +Ibw(i+1,j-1)+Ibw(i+1,j)+Ibw(i+1,j+1) ...
                >=3)
            Icut(i,j) = 1;
        end
    end
end

I = Ibw - Icut;
[Ilabel Nlabel] = bwlabel(I);
ArAfter = regionprops(Ilabel,'Area');

[Ilabeltoal ~] = bwlabel(Ibw);
ArBefr = regionprops(Ilabeltoal,'Area');

Iside = zeros(m,n);
for i=2:m-1
    for j=2:n-1
        if (I(i,j)>0 && I(i-1,j-1)+I(i-1,j)+I(i-1,j+1) ...
                +I(i,j-1)+I(i,j+1) ...
                +I(i+1,j-1)+I(i+1,j)+I(i+1,j+1) ...
                <=1)
            Iside(i,j) = Ilabel(i,j);
        end
    end
end

k=1;
for i=1:Nlabel
    [x y] = find(Iside == i);
    if size(x,1) ~= 2
        continue;
    end
    s = 0;
    for j=1:size(x,1)
        tx = x(j);
        ty = y(j);
        s = s + Icut(tx-1,ty-1)+Icut(tx-1,ty)+Icut(tx-1,ty+1) ...
                +Icut(tx,ty-1)+Icut(tx,ty+1) ...
                +Icut(tx+1,ty-1)+Icut(tx+1,ty)+Icut(tx+1,ty+1);
    end
    if s == 1
        Lb(k) = Ilabel(x(1),y(1));
        k = k+1;
    end
end

k=1;
for i=1:size(Lb,2)
    L = Lb(i);
    [x y] = find(Ilabel == L);
    Ltoal = Ilabeltoal(x(1),y(1));
    if ArAfter(L).Area < ArBefr(Ltoal).Area*per
        Lrm(k) = L;
        k = k+1;
    end
end

if ~exist('Lrm')
    error('Loop ending.')
end
Io = Ilabel;
Io(Ilabel > 0 & ismember(Ilabel,Lrm)) = 0;

Io = Io + Icut;

clear ArAfter ArBefr Lb Lrm

end


