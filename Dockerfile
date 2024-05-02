# Stage 1: Build Angular app
FROM node:14.17-alpine AS build
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

# Stage 2: Serve Angular app with NGINX
FROM nginx:1.21-alpine
COPY --from=build /app/dist/your-angular-app /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

FROM adoptopenjdk/openjdk11:alpine-jre
WORKDIR /app
COPY target/your-spring-boot-app.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
