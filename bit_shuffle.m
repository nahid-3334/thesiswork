function a = bit_shuffle(a)
%swap different index
b=a;
j=5;
for i=2:2:6
    a(i)=b(j);
    j=j+1;
end
j=4;
for i=7:-2:5
    a(i)=b(j);
    j=j-1;
end
a(3)=b(2);
