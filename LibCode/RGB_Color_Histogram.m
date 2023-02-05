function [RGB_hist,RGBmean_count]= RGB_Color_Histogram(f,r_n,g_n,b_n)
%  计算RGB图像的颜色直方图，并返回大小不为0的bin的 中值-大小

%  参数列表中，f表示读取的RGB图像，r_n表示红色分量等分的份数，g_n表示绿色分量等分的份数，b_n表示蓝色分量等分的份数
%  彩色直方图共有r_n*g_n*b_n个bin，已知某像素颜色为（x1，x2，x3），则其在彩色直方图的第几个bin可以用以下公式计算：
%  i_bin=x1*g_n*b_n+x2*b_n+x3+1
%  已知彩色直方图的第i个bin，则其对应的像素彩色可用以下公式计算：
%  x1=fix（i/(g_n*b_n)）
%  x2=fix（(i-x1*g_n*b_n)/b_n）
%  x3=i-x1*g_n*b_n-x2*b_n-1

%  将图像转换为double类型，取值空间[0,1]
f=im2double(f);

%  取得红绿蓝三个颜色的分量
f_r=f(:,:,1);
f_g=f(:,:,2);
f_b=f(:,:,3);

%  对红绿蓝三个颜色的分量进行量化，取值在[0,等分份数-1]
f_r=fix(f_r*r_n);
f_g=fix(f_g*g_n);
f_b=fix(f_b*b_n);

%  对于超出量化区间的（也就是量化的颜色值等于等分份数的），进行减一操作，归于最大量化数（也即等分份数-1）
f_r=f_r-(f_r==r_n);
f_g=f_g-(f_g==g_n);
f_b=f_b-(f_b==b_n);

%  初始化直方图
RGB_hist = zeros(r_n*g_n*b_n,1);


%  对每个像素的颜色值进行编码，按照i_bin=x1*g_n*b_n+x2*b_n+x3+1进行计算
temp = f_r*g_n*b_n+f_g*b_n+f_b+1;

%  统计颜色值落入第i个bin的像素个数
for   i=1:r_n*g_n*b_n
    RGB_hist(i)=length(find(temp==i));
end

%取中间值为代表颜色
tf=find(RGB_hist~=0);
RGBmean_count= zeros(length(tf),4);
i=tf-1;
x1=fix(i/(g_n*b_n));
x2=fix((i-x1*g_n*b_n)/b_n);
x3=i-x1*g_n*b_n-x2*b_n;
x1=(x1+0.5)./r_n;
x2=(x2+0.5)./g_n;
x3=(x3+0.5)./b_n;
RGBmean_count(:,:)=[x1,x2,x3,RGB_hist(tf)];

% %  要是34--39行看不懂，下面的也是一样
% p=0;
% for i=0:r_n-1
%     for j=0:g_n-1
%         for k=0:b_n-1
%              RGB_hist(p+1)=length(find(f_r==i & f_g==j & f_b==k));
%              p=p+1;
%         end
%     end
% end
