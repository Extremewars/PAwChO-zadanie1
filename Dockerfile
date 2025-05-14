FROM node:22-alpine AS build1
ARG VERSION
ENV APP_VER=production.${VERSION:-v1.0}
WORKDIR /app

# Skopiowanie spisu zależności, jeśli się nie zmieniły część warstw zostanie pobrana z cache'u
COPY src/package*.json ./
RUN npm install

# Instalacja pakietu pkg umożliwiającego utworzyć plik wykywalny projektu
RUN npm install -g pkg

COPY src/ ./

# Utworzenie pliku wykonywalnego
RUN pkg . --targets node16-alpine-x64 --output /weather

FROM scratch AS prod
LABEL org.opencontainers.image.authors="Paweł Olech"
LABEL org.opencontainers.image.title="Zadanie 1 - Aplikacja pogodowa"
LABEL org.opencontainers.image.description="Aplikacja pogodowa w Node.js"
LABEL org.opencontainers.image.created="$(date -u +'%Y-%m-%dT%H:%M:%SZ')"
LABEL org.opencontainers.image.version="1.0.0"

ADD alpine-minirootfs-3.21.3-x86_64.tar.gz /
COPY --from=build1 /weather /weather

EXPOSE 3000
HEALTHCHECK --interval=15s --timeout=5s --start-period=5s \
  CMD ps aux | grep -q '/weather' || exit 1

ENTRYPOINT ["/weather"]
