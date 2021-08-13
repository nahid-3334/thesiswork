function a = bit_shuffle(a)
%swap different index
b=a;
j=2;
for i=5:1:7
    a(i)=b(j);
    j=j+2;
end
j=7;
for i=4:-1:3
    a(i)=b(j);
    j=j-2;
end
a(2)=b(3);
