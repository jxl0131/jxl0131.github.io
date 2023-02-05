%分三维度画直方图
clear;close all;clc;
%来源：CSDN某博主
%RGB直方图绘制，兼容灰度图像(分别计算三个维度上的直方图)
%图像应为uint8无符号整型，否则可能会无法绘制直方图，出错的话请看一下矩阵的数据类型
%很多朋友会使用im2double函数，使用了的话请用uint8(255*f)恢复成uint8无符号整形
 
f=imread(['videos/','海边少女','.jpg']);
subplot(211);
imshow(f);title('原图');
fcal=double(f); %后面计算像素点时会有灰度值为255的像素点，将uint8型变为double型，防止溢出
[m,n,h]=size(f);
Y=zeros(h,256);
 
%分别统计原图像RGB基色各灰度级的像素个数
for k=1:h
    for i=1:m
        for j=1:n
            Y(k,fcal(i,j,k)+1)=Y(k,fcal(i,j,k)+1)+1; %哪一灰度级出现一次其相应像素点数+1。灰度级范围是0-255，但矩阵是1-256，列数要额外+1
        end
    end
end
 
X=0:1:255; %建立x坐标轴
subplot(212);
histogram=bar(X,Y); %绘制直方图
axis([0 255,-inf inf]) %x坐标轴限制在0-255
xlabel('灰度级');ylabel('像素个数');
 
if h==3 %改变直方图颜色并加轮廓
    title('RGB直方图');
    %分别改变颜色
    set(histogram(1),'FaceColor',[1 0.1882 0.1882]); 
    set(histogram(2),'FaceColor',[0.5 1 0]);
    set(histogram(3),'FaceColor',[0 0.5 1]);
    
    %增加边界轮廓
    hold on
    plot(X,Y(1,:),'Color',[1 0.1882 0.1882]);  %加上边界轮廓
    plot(X,Y(2,:),'Color',[0.5 1 0]);
    plot(X,Y(3,:),'Color',[0 0.5 1]);
    hold off
else
    title('灰度直方图');
end
