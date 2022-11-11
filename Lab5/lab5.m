clear; clc; close all;

im = rgb2gray(double(imread("kaczki.jpg")) / 255);

figure;

h = 1;
w = 4;
i = 1;

subplot(h, w, i); i = i + 1;
imshow(im);

t = graythresh(im);
% Dobranie wlasnego progu, lepszy od graythresh
t = .6;
% Binaryzacja
imb = ~imbinarize(im, t);
bim = medfilt2(imb, [7, 7]);

% subplot(h, w, i); i = i + 1;
% imshow(double(bim2));

% Zamkniecie = dylatacja -> erozja
bim = imclose(bim, ones(7));

subplot(h, w, i); i = i + 1;
imshow(double(bim));

% Segment jest zawsze 3x3, nie podajemy macierzy jedynek
% Do erode, dilate, close, open nie zawsze dobrze dziala
% Remove - zostawia krawedz
% Skeleton - w zaleznosci od stopnia zostawia szkielet przedmiotu, zbior
% punktow o tej samej odleglodci od krawedzi kaczki
% Mamy mniej pikseli do analizowania, nie mamy reszty masy/ciala kaczki
% Zeby nie zgadywac ile razy to robic, wpisujemy nieskonczonosc
% inf robi dopoki nic sie nie zmienia

s = bwmorph(bim, 'skeleton', Inf);
% subplot(h, w, i); i = i + 1;
% imshow(double(s));

% Endpoints - Ze szkieletu znajduje ostatnie punkty, punkt musi byc bialy 
% i miec 1 sasiada
p = bwmorph(s, 'endpoints');

% Branchpoints - punkty rozgalezien, wiecej niz 2 sasiadow
p = bwmorph(s, 'branchpoints');

% subplot(h, w, i); i = i + 1;
% imshow(double(p));

% Find szuka wspolrzedne punktow gdzie jest logiczna prawda
% Caly szkielet zapisujemy za pomoca pojedynczych punktow
[d1, d2] = find(p);

% Zmniejsza o kilka pikseli wglab, w inf kaczki redukuja sie do
% pojedynczych punktow
s = bwmorph(bim, 'shrink', 20);
% Liczba eulera - liczba przedmiotow na obrazie minus liczba dziur w
% przedmiocie
% Operacje morfologiczne moga zmienic liczbe eulera
% Operacja shrink nie zmienia liczby eulera
% Shrink - punkt ostateczny znajduje sie w srodku obiektu

% Thin - cos pomiedzy szkieletem a erozja,
% Zapewnia nam linie, zachowuje liczbe eulera
s = bwmorph(bim, 'thin', 50);

% Thicken - zgrubianie bialych pikseli, w inf zostawia granice miedzy
% kaczkami, zostawia segmenty z dokladnie 1 kaczka - zostawia ja w calosci
% Segmentacja przez pogrubianie
s = bwmorph(bim, 'thicken', Inf);


% bwlabel - numerowanie kaczek, 
% bwlabel(thicken) -> kaczka + otoczenie kaczki
s = bwlabel(bim);
% Label2rgb - kolorowanie macierzy label 
% imshow(s==2) -> wyswietlenie tylko 2 kaczki
% imshow((s==2) .* im) - mnozenie przez oryginal, tam gdzie zero zostaje
% zero, dostajemy oryginalna kaczke, mozemy teraz operowac na pojedynczej
% kaczce

% subplot(h, w, i); i = i + 1;
% imshow((s==2) .* im .* bim);

% Podsumowanie:
% Macierz im -> "kolory"
% Macierz bim -> ksztalty
% Macierz s -> podzial 

% Transformata odleglosciowa - odleglosc czarnego punktu do najblizszego
% bialego (do obiektu)
% Wywolanie z inwersji -> "topologia" kaczki, uwidocznienie szkieletu
d = bwdist(bim);

% subplot(h, w, i); i = i + 1;
% imshow(d , [0 ,max(d, [], 'all')]);

% Dodanie sztucznej ramki dookola krawedzi, zmniejszenie segemntow kaczek
bim([1,end], :) = 1;
bim(:, [1, end]) = 1;

% 2 argument - wybranie metryki, chessboard, cityblock, ostrzejsze krawedzie
d = bwdist(bim, 'chessboard');
s = watershed(d);
subplot(h, w, i); i = i + 1;
imshow(label2rgb(s));

% Segmentacja, segment o numerze 1 to tlo
% Granice miedzy segmentami to szkielet, punkt tak samo odlegly od obiektow
d = bwdist(bim);
s = watershed(d);

subplot(h, w, i); i = i + 1;
imshow(label2rgb(s));

