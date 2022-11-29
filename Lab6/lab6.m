close all; clc; clear;

im = double(imread("ptaki.jpg")) / 255;

figure;

h = 1;
w = 2;
i = 1;


% subplot(h, w, i); i = i + 1;
% imshow(im)

% subplot(h, w, i); i = i + 1;
% imhist(im)

% t = .26;
% t = graythresh(im);

% Ciezko dobrac prog tlo ma podobna jasnosc do ptakow, tlo ma gradient

% imb = ~imbinarize(im, t);
% bim = medfilt2(imb, [7, 7]);

% subplot(h, w, i); i = i + 1;
% imshow(bim)

% bim = imclose(bim, ones(7));

% subplot(h, w, i); i = i + 1;
% imshow(double(bim));

% Wyiberamy kanal koloru
% Na zielonym jest gradient tla, cale problemy sa tu
% Na niebieskiej warstwie widac kontury ptakow najlepiej
% Na czerwonej mamy jasne czesci

% subplot(h, w, i); i = i + 1;
% imshow(im(:,:,1))

% subplot(h, w, i); i = i + 1;
% imhist(im(:,:,1))

% Binaryzacja poszczegolnych kanalow

r = imbinarize(im(:,:,1));
% subplot(h, w, i); i = i + 1;
% imshow(r)


% Tu trzeba odwrocic zeby kaczki byly biale
b = ~imbinarize(im(:,:,3));
% subplot(h, w, i); i = i + 1;
% imshow(b)

% Dodanie do siebie 2 macierzy / alternatywa
bim = r | b;

bim = imclose(bim, ones(5));
bim = imopen(bim, ones(5));

subplot(h, w, i); i = i + 1;
imshow(bim)

l = bwlabel(bim);

% subplot(h, w, i); i = i + 1;
% imshow(label2rgb(l))


% regionprops, jezeli podamy binarny obraz otrzymamy macierz struktur
a = regionprops(l==4, "all");
% a - centroid -> srednia arytmetyczna wspolrzednych wszystkich punktow
% Przy jednorodnej figurze srodek masy
% BoundingBox - wspolrzedne najmiejszego prostokata w ktorym zmiescimy
% figure, zgodnie z osiami
% Major Axis -> dlugosc w najdluzszym wymiarze
% Minor Axis -> dlugosc w najkrotszym wymiarze
% Eccentricity -> jak bardzo srodek masy rozni sie od srodka boundingbox
% Orientation -> kat wychylenia
% ConvexHull -> obrot, przy 3d
% Circularity ->
% Image -> wyciety obrazek z figura
% FilledImage -> wypelnia dziury
% EulerNumber -> wspolczynnik eulera (dziury w obrazie)
% Extrema -> wspolrzedne punkow wychylen w 4 kierunkach
% Solidity -> jak bardzo obiekt wypelnia przestrzen
% Perimiter -> dlugosc obwod, troszke lepsze przyblizenie od PerOld
% Wspolczynniki Fereta -> 

% subplot(h, w, i); i = i + 1;
% imshow(a.Image)

% Porownanie figury do kola
% Dobranie kola o takim R zeby pole kola i figury bylo takie samo
% R = (A/pi)^1/2 -> EquivDiameter
% Dobranie kola o takim RL zeby obwod kola i figury bylo takie samo
% RL = L/2pi
% Stosunek R do RL jest staly dla figury -> Circularity
% C -> [0,1] -> kolo nie bedzie bardziej okragle od kola = max 1
% 1/C -> RL/R -> [1, inf], RL/R - 1 [0, inf] -> Wspolczynnik Malinowskiej
% Stosunek srednia odleglosc pikseli od centroidu -> dla kola bedzie najmniejsza ->
% Wspolczynnik Daniellsona
% Stosunek srednia odleglosc piksela od krawedzi -> wspolczynnik
% Blaira-Blissa
% Stosunek sredniej srodka masy od krawedzi -> wspolczynnik Haralicka
% Wychylenie w poszczegolnych wymiarach (u nas wymiary BoundingBox) -> Wspolczynnik Fereta
% F = F1/F2, taki sam obiekt moze miec rozny wsp fereta w zaleznosci od
% orientacji


% asdsa = AO5RShape(a.Image);
% Cell array, @ -> uchwyt do funkcji, fun{1}(a(2).Image)...
fun = {@AO5RShape, @AO5RBlairBliss, @AO5RCircularityL, @AO5RCircularityS, @AO5RDanielsson, @AO5RFeret, @AO5RHaralick, @AO5RMalinowska};

a = regionprops(l, "all");

for i = (1:size(a,1))
    for j = (1:size(fun,2))
        arr(i,j) = fun{j}(a(i).Image);
    end
end
 









