clear; clc; close all;

im =  rgb2gray(double(imread('zubr.jpg')) / 255);

figure;

h = 1;
w = 2;
i = 1;

% subplot(h, w, i); i = i + 1;
% imshow(im);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rozmycie - usrednianie wartosci kolorow
% Z ostrego ciecia zrobi sie gladkie
% Rozmyta krawedz
% Glowny cel -> zanikniecie ekstrymalnych wartosci / artefaktow w obrazie
% (np biale kropki na zubrze), wygladzenie obrazu, pozbycie sie szumow
% Filtr rozmywajacy - dolnoprzepustowy
k = 3;

m = ones(k) / k ^ 2;
im2 = imfilter(im, m);

% subplot(h, w, i); i = i + 1;
% imshow(im2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Otoczenie z wagami negatywnymi
% Srodek pozytywny
% Ostrzejszy obraz, ale wyrazniejsze artefakty, wyeskoponowanie artefaktow
% Dla 8 w srodku - suma jest 0 -> krawedzie sa widoczne
% Filtr krawedziowy

% k = 3;
% m = -ones(k);
% m(2,2) = 9;
% im2 = imfilter(im, m);
% 
% subplot(h, w, i); i = i + 1;
% imshow(im2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filtr medianowy
% Brak rozycie krawedzi, ostrzejsze krawedzie
% Krawedz pozostaje ostra


% k = 5;
% im2 = medfilt2(im, [k, k]);
% subplot(h, w, i); i = i + 1;
% imshow(im2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Chcemy obraz czarno-bialy / binarny 
% <0.5 = 0 >0.5 = 1
% Przyjelo sie ze bialy jest sygnal, tlo jest czarne
% t - treshhold 
% Inna nazwa - progowanie
% 0.5 nie zawsze jest dobre
% Odpowiednie dobranie t - raczej nie srednia
% Wariancja miedzy klastrami jak najwieksza
% Wariancja w klastrze jak najmniejsza
t = graythresh(im);

binim = im;
binim(binim < t) = 0;
binim(binim >= t) = 1;

% Odwrocenie
binim = 1 - binim;

% subplot(h, w, i); i = i + 1;
% imshow(binim);

% Wartosci logiczne
% Odwocenie = negacja logiczna
% Adaptive - czy piksel jest istotnie inny od innych pikseli
% Np. rozne wartosci jasnosci na obrazie
% imb = ~imbinarize(im, "adaptive");

t = .55;
imb = ~imbinarize(im, t);

subplot(h, w, i); i = i + 1;
imshow(double(imb));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mediana na obrazie binarnym
% Wygladza krawedzie, znikaja pojedyncze punkty,
% Pozbycie sie szumow

bim2 = medfilt2(imb, [7, 7]);

% subplot(h, w, i); i = i + 1;
% imshow(double(bim2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Minimum (erozja morfologiczna) / Maksimum (delatacja morfologiczna) - 
% zmiana tylko na krawedzi -> jedna warstwa czarnych krawedzi
% stanie sie biala
% Poszerzanie, zmniejszanie krawedzie

% Erozja - biale piksele na trawie znikaja
% Czarne piksele na zubrze zwiekszaja sie

% Obraz -> erozja -> dylatacja -> obraz
% Duze obiekty po obu funkcjach nie zmienia sie
% Male znikna
% Otwarcie morfologiczne
% Lub zamkniecie morfologiczne
% imopen(), imclose()
bim2 = imerode(imb, ones(5));
% subplot(h, w, i); i = i + 1;
% imshow((bim2));

bim2 = imdilate(imb, ones(3));

bim2 = imopen(imb, ones(5));
bim2 = imclose(imb, ones(5));

subplot(h, w, i); i = i + 1;
imshow((bim2));

