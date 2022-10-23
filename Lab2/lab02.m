clear; clc; close all;
% uint8 0-255
im = imread('zubr.jpg');

% konwersja do double i normalizacja zeby bylo 0 - 1
im = double(im) / 255;

figure;

h = 2;
w = 2;
i = 1;

% Podzial okna na h wysokosci i 2 szerokosc, i numer pola
% subplot(h, w, i); i = i + 1;
% imshow(im);
% 
% subplot(h, w, i); i = i + 1;
% imshow(im);

% tylko jeden kanal / jeden kolor
% R
% subplot(h, w, i); i = i + 1;
% imshow(im(:,:,1));
% subplot(h, w, i); i = i + 1;
% imhist(im(:,:,1));
% % G
% subplot(h, w, i); i = i + 1;
% imshow(im(:,:,2));
% subplot(h, w, i); i = i + 1;
% imhist(im(:,:,2));
% % B
% subplot(h, w, i); i = i + 1;
% imshow(im(:,:,3));
% subplot(h, w, i); i = i + 1;
% imhist(im(:,:,3));

% histogram
% imhist(im(:,:,2));

% Odcienie szarosci - srednia arytmetyczna wszystkich kanalow
% grim = mean(im, 3);
% 
% subplot(h, w, i); i = i + 1;
% imshow(grim);
% subplot(h, w, i); i = i + 1;
% imhist(grim);

% Format YUV - wagi poszczegolnych kanalow
yuv = [.299, .587, .114];

% Permutacja do 1x1x3 zeby mozna bylo pomnozyc macierze
yuv = permute(yuv, [3,1,2]);

% grim = sum(im .* yuv, 3);
% subplot(h, w, i); i = i + 1;
% imshow(grim);
% subplot(h, w, i); i = i + 1;
% imhist(grim);

% Rgb2gray podobnie oblicza 
grim = rgb2gray(im);
% subplot(h, w, i); i = i + 1;
% imshow(grim);
% subplot(h, w, i); i = i + 1;
% imhist(grim);

% Jasnosc - zmiana wszystkich wartosci o tyle samo
% Dodawanie
b = .2;
bim = grim + b; 
bim(bim > 1) = 1;
bim(bim < 0) = 0;
% Przesuniecie histogramu o b 

% subplot(h, w, i); i = i + 1;
% imshow(grim);
% subplot(h, w, i); i = i + 1;
% imshow(bim);
% subplot(h, w, i); i = i + 1;
% imhist(grim);
% subplot(h, w, i); i = i + 1;
% imhist(bim);

% Wykres przeksztalcenia
% x = 0 : 1/255 : 1;
% y = x + b;
% y(y>1) = 1;
% y(y<0) = 0;
% plot(x, y);
% ylim([0,1]);

% Kontrast - roznica miedzy max i min 
% Mnozenie
% c = .5;
% cim = grim * c;
% cim(cim > 1) = 1;
% cim(cim < 0) = 0;
% 
% subplot(h, w, i); i = i + 1;
% imshow(grim);
% subplot(h, w, i); i = i + 1;
% imshow(cim);
% subplot(h, w, i); i = i + 1;
% imhist(grim);
% subplot(h, w, i); i = i + 1;
% imhist(cim);

% Zmienianie 'nachylenia' wykresy z punktu 0,0

% x = 0 : 1/255 : 1;
% y = x * c;
% y(y>1) = 1;
% y(y<0) = 0;
% plot(x, y);
% ylim([0,1]);

% Zmienianie nachylenie wzgledem srodka

% c = .5;
% cim = (grim - .5) * c + .5;
% cim(cim > 1) = 1;
% cim(cim < 0) = 0;
% 
% subplot(h, w, i); i = i + 1;
% imshow(grim);
% subplot(h, w, i); i = i + 1;
% imshow(cim);
% subplot(h, w, i); i = i + 1;
% imhist(grim);
% subplot(h, w, i); i = i + 1;
% imhist(cim);

% x = 0 : 1/255 : 1;
% y = (x - .5) * c + .5;
% y(y>1) = 1;
% y(y<0) = 0;
% plot(x, y);
% ylim([0,1]);

% Gamma
% Potegowanie

g = .5;
% Konwecja -> potegowanie 1/g, wieksze g = wieksza jasnosc
gim = grim .^ (1 / g);
% Teoretycznie te 2 linijki ponizej nic nie robia w kontekscie potegowania
gim(gim > 1) = 1;
gim(gim < 0) = 0;

subplot(h, w, i); i = i + 1;
imshow(grim);
subplot(h, w, i); i = i + 1;
imshow(gim);
subplot(h, w, i); i = i + 1;
imhist(grim);
subplot(h, w, i); i = i + 1;
imhist(gim);

% x = 0 : 1/255 : 1;
% y = x .^ (1 / g);
% y(y>1) = 1;
% y(y<0) = 0;
% plot(x, y);
% ylim([0,1]);


% Przedzialy:
% Jasnoasc (-1,1) - suwak od -1 do 1, proste
% Kontrast (0, +inf) - suwak skala logarytmiczna np -100 do 100
% Gamma (0, +inf) - suwak skala logarytmiczna np -100 do 100

