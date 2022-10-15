clear;clc;
% a=6
% 
% if a == 6
%     a = a - 2
% elseif a == 4
%     a = 12
% else
%     a = 312
% end
% 
% while a > 3
%     a = a - 1;
% end
% 
% for i=1:10
%     i;
% end

A = [1,2,3,4;1,4,9,16;2,3,5,8;13,7,6,2]
b = [1;2;3;4]

% A ^ -1 * b 

dA = det(A);
for i=1:4
    tmp = A;
    tmp(:,i) = b;
    x(i) = det(tmp) / dA;
end

x

