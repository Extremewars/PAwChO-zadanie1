# PAwChO-zadanie1

1. Proszę opracować aplikację (dowolny język programowania), która realizować będzie następującą
funkcjonalność:
    1. po uruchomieniu kontenera z tą aplikacją, pozostawi ona w logach informację o dacie
uruchomienia, imieniu i nazwisku autora programu oraz porcie TCP, na którym aplikacja ta
„nasłuchuje”.
    2. aplikacja pozwala na wybranie kraju i miasta (np. z predefiniowanej listy) oraz
zatwierdzenie tego wyboru. Na podstawie tych informacji aplikacja powinna wyświetlić
aktualną pogodę w wybranej lokalizacji. Zakres informacji pogodowych pozostawiam do
decyzji autorów kodu tak jak i projekt i formę UI.
W sprawozdaniu proszę umieścić kod oprogramowania wraz z niezbędnymi komentarzami.
2. Opracować plik Dockerfile, który pozwoli na zbudowanie obrazu umożliwiającego uruchomienie
aplikacji opracowanej w punkcie 1 jako kontener Docker. Przy ocenie brane będzie sposób
opracowania tego pliku (wieloetapowe budowanie obrazu, ewentualne wykorzystanie warstwy
scratch, optymalizacja funkcjonowania cache-a w procesie budowania, optymalizacja pod kątem
zawartości i ilości warstw, healthcheck itd ). Plik Dockerfile powinien również zawierać informację na
temat autora tego pliku (imię oraz nazwisko studenta) zgodną ze standardem OCI.
W sprawozdaniu proszę umieścić plik Dockerfile wraz z niezbędnymi komentarzami.
3. Należy podać polecenia niezbędne do: \
a. zbudowania opracowanego obrazu kontenera,
```bash
docker build -t zadanie1 .
```
b. uruchomienia kontenera na podstawie zbudowanego obrazu,
```bash
docker run -d -p 3000:3000 --name zadanie1_kontener zadanie1
```
c. sposobu uzyskania informacji z logów, które wygenerowałą opracowana aplikacja podczas uruchamiana kontenera,
```bash
docker logs zadanie1_kontener
```
d. sprawdzenia, ile warstw posiada zbudowany obraz oraz jaki jest rozmiar obrazu.
Sprawdzenie rozmiarów warstw:
```bash
docker images
```
Sprawdzenie ilości warstw:
```bash
docker history zadanie1
```
