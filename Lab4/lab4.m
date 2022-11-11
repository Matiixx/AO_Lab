clear; clc; close all;

im = rgb2gray(double(imread("opera.jpg")) / 255);

figure;

h = 1;
w = 2;
i = 1;

subplot(h, w, i); i = i + 1;
imshow(im);

fim = fft2(im);
A = abs(fim);
phi = angle(fim);

fim2 = A .* exp(1i * phi);

im2 = abs(ifft2(fim2));

% Czarne kropki na bialym tle -> zly przedzial, A nie jest (0,1)
% subplot(h, w, i); i = i + 1;
% imshow(A);

% Ustawienie przedzialu wyswietlania 
% subplot(h, w, i); i = i + 1;
% imshow(A, [0, max(A, [], 'all')]);

% subplot(h, w, i); i = i + 1;
% imshow(log(A), log([0, max(A, [], 'all')]));

% Zmieniamy cwiartki miejscami
% subplot(h, w, i); i = i + 1;
% imshow(fftshift(log(A)), log([0, max(A, [], 'all')]));

% 4 maksima w x, 4 maksima w y A(5,5)
% 49, 49 okresow dla A(50,50)
% A(5, 5) = 10^5;
% A(50, 50) = 10^5;

% fim2 = A .* exp(1i * phi);
% 
% im2 = abs(ifft2(fim2));
% 
% subplot(h, w, i); i = i + 1;
% imshow(im2);

% subplot(h, w, i); i = i + 1;
% imshow(phi, [-pi, pi]);

% Filtr dolnoprzepustowy
m = ones(11);

[imh, imw] = size(im);

fm = fft2(m, imh, imw);
Am = abs(fm);

% 11 prostokatow na os
% subplot(h, w, i); i = i + 1;
% imshow(fftshift(log(Am)), log([0, max(Am, [], 'all')]));

% phim = angle(fm);
% subplot(h, w, i); i = i + 1;
% imshow(phim, [-pi, pi]);

% Filtracja - rozmazany obraz
A = A .* Am;
fim2 = A .* exp(1i * phi);
im2 = abs(ifft2(fim2)) / 121;
subplot(h, w, i); i = i + 1;
imshow(im2, [0, max(im2, [], 'all')]);

% Sprawozdanie 2 tyg do 16.11 na maila do 9.32 PDF

