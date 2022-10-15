clear;
a=[1,2,3;4,5,6];
a(1,2);
a(1,end);
a(1,1:end);
a(1,:);
a(5);
a(:);

b=[7,3,5; 9,8,2];

% a .* b
% a' transponowanie
a' * b;
a .* b;
a ./ b;
a .^ b;


x = 0:.1:2*pi;
y=sin(x)
plot(x,y)

