close all; clc; clear;

im = double(imread("ptaki2.jpg")) / 255;

figure;

h = 1;
w = 2;
iter = 1;

bim = ~imbinarize(im(:,:,3));

bim = imclose(bim, ones(3));
bim = imopen(bim, ones(3));

% subplot(h, w, iter); iter = iter + 1;
% imshow(bim)

l = bwlabel(bim);

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
test = abs(sM) > (3 * sigma);

% Tutaj statystyka nie dziala
% Np zeby odroznic skrzydla mozna policzyc pole powierzchni 

tmpa = regionprops(bim, "Area");
tmpl = bwlabel(bim);
for i = 1 : length(tmpa)
    if tmpa(i).Area < 1000
        tmpl(tmpl==i) = 0;
    end
end

bim = tmpl > 0;
l = bwlabel(bim);

% subplot(h, w, iter); iter = iter + 1;
% imshow(label2rgb(l))

% Ponowne liczenie macierzy wspolczynnikow
a = regionprops(bim, "all");

M = [];

for i = (1 : size(a,1))
    for j = (1 : size(fun,2))
        M(i,j) = fun{j}(a(i).Image);
    end
end

im2 = double(imread("ptaki.jpg")) / 255;
r = imbinarize(im2(:,:,1));
b = ~imbinarize(im2(:,:,3));

bim2 = r | b;

bim2 = imclose(bim2, ones(5));
bim2 = imopen(bim2, ones(5));

% subplot(h, w, iter); iter = iter + 1;
% imshow(bim2)

l = bwlabel(bim2);
l(l==8) = 0;
% Cell array, @ -> uchwyt do funkcji, fun{1}(a(2).Image)...
fun = {@AO5RShape, @AO5RBlairBliss, @AO5RCircularityL, @AO5RCircularityS, @AO5RDanielsson, @AO5RFeret, @AO5RHaralick, @AO5RMalinowska};

a = regionprops(l, "all");

for i = (1:size(a,1))
    for j = (1:size(fun,2))
        M2(i,j) = fun{j}(a(i).Image);
    end
end

% Siec neuronowa

n1 = size(M, 1);
n2 = size(M2, 1);

% Uczace ptaki
Mu1 = transpose(M(1:end-2, :));
Mt1 = transpose(M(end-1:end, :));

Mu2 = transpose(M2(1: end-2, :));
Mt2 = transpose(M2(end-1:end, :));

Ou1 = [ones(1, n1-2); zeros(1,n1-2)];
Ot1 = [1,1;0,0];
Ou2 = [zeros(1,n2-2); ones(1, n2-2)];
Ot2 = [0,0;1,1];

nn = feedforwardnet;
% Uczenie sieci neuronowej
nn = train(nn, [Mu1, Mu2], [Ou1, Ou2]);

% Uzycie sieci neuronowej
round(nn([Mt1, Mt2]))

% 2 sprawozdanie 3 laby
% Do 5.12 9:22

% Projekty do 22.01 23:59
% Grupy 3-4 osobowe, tematy na stronie sa inspiracja
% GUI, nie ma wymogow do srodowiska, ale matlab lub python
% Strona paperswithcode
% Do wyslania: 
% -kod (moze byc link do gita), 
% -dokumentacja (co to jest, 
% jak to uruchomic, ew. jak uzywac. co kto robil, co nie dziala, 
% idea algorytmu, zrodla),
% -dane dla ktorych to dziala



