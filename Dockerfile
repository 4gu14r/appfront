# Etapa de build
FROM gradle:8.7-jdk21 AS build
WORKDIR /app

COPY gradlew gradlew
COPY gradle gradle
COPY build.gradle.kts settings.gradle.kts ./
RUN chmod +x gradlew

COPY . .
RUN ./gradlew jsBrowserProductionWebpack --no-daemon

# Etapa de runtime (Nginx para servir os arquivos estáticos)
FROM nginx:1.27-alpine
WORKDIR /usr/share/nginx/html
COPY --from=build /app/build/dist/js/productionExecutable/ ./
EXPOSE 80
