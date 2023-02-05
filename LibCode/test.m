
x=1:5;
y=zeros(1,5);
y(1,1)=4/3;
for i=2:1:5
    y(1,i)=y(1,i-1).^2 - y(1,i-1) +1;
end
figure("Name","a_n");
plot(x,y,'b--o')
