# Etap pierwszy - utworzenie binarnej wersji aplikacji
FROM node:22-alpine AS build1
# Obsługa argumentu
ARG VERSION
ENV APP_VER=production.${VERSION:-v1.0}
# Katalog roboczy
WORKDIR /app
# Skopiowanie spisu zależności, jeśli się nie zmieniły część warstw zostanie pobrana z cache'a
COPY src/package*.json ./
# Instalacja zależności
RUN npm install
# Instalacja pakietu pkg umożliwiającego utworzyć plik wykonywalny projektu
RUN npm install -g pkg
# Skopiowanie plików źródłowych
COPY src/ ./
# Utworzenie pliku wykonywalnego
RUN pkg . --targets node16-alpine-x64 --output /weather

# Finalny etap - warstwa scratch
FROM scratch AS prod
# Informacje o autorze i opis aplikacji
LABEL org.opencontainers.image.authors="Paweł Olech"
LABEL org.opencontainers.image.title="Zadanie 1 - Aplikacja pogodowa"
LABEL org.opencontainers.image.description="Aplikacja pogodowa w Node.js"
LABEL org.opencontainers.image.created="$(date -u +'%Y-%m-%dT%H:%M:%SZ')"
LABEL org.opencontainers.image.version="1.0.0"
# Dodanie systemu plików
ADD alpine-minirootfs-3.21.3-x86_64.tar.gz /
# Skopiowanie binarnej wersji aplikacji z poprzedniego etapu
COPY --from=build1 /weather /weather
# Sugerowany port - localhost:3000
EXPOSE 3000
# Sprawdzenie czy proces /weather (aplikacja) działa
HEALTHCHECK --interval=15s --timeout=5s --start-period=5s \
  CMD ps aux | grep -q '/weather' || exit 1
# Uruchomienie aplikacji
ENTRYPOINT ["/weather"]
