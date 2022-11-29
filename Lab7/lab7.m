close all; clc; clear;

im = double(imread("ptaki.jpg")) / 255;

figure;

h = 1;
w = 2;
i = 1;

% Binaryzacja poszczegolnych kanalow

r = imbinarize(im(:,:,1));

% Tu trzeba odwrocic zeby kaczki byly biale
b = ~imbinarize(im(:,:,3));

% Dodanie do siebie 2 macierzy / alternatywa
bim = r | b;

bim = imclose(bim, ones(5));
bim = imopen(bim, ones(5));

subplot(h, w, i); i = i + 1;
imshow(bim)


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

l = bwlabel(bim);

% Cell array, @ -> uchwyt do funkcji, fun{1}(a(2).Image)...
fun = {@AO5RShape, @AO5RBlairBliss, @AO5RCircularityL, @AO5RCircularityS, @AO5RDanielsson, @AO5RFeret, @AO5RHaralick, @AO5RMalinowska};

a = regionprops(l, "all");

for i = (1:size(a,1))
    for j = (1:size(fun,2))
        arr(i,j) = fun{j}(a(i).Image);
    end
end
 
% Srednia
M = mean(arr);
% Odchylenie standardowe
sigma = std(arr);
% Jezeli cos jest wieksze od 3 sigm jest rozne - regula 3 sigm

% Standaryzacja
sM = (arr - M) ./ sigma;
% Znalezienie podejrzanych obiektow
test = abs(sM) > 2;
% Usuniecie obiekty z macierzy
arr(8,:) = [];
% Usuniecie elementu z obrazka
l(l==8) = 0;
bim = l > 0;

subplot(h, w, 2); i = i + 1;
imshow(bim)



