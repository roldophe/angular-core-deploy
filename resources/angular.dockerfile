FROM node:18-alpine as build-stage
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --legacy-peer-deps
COPY . .
RUN npm run build --prod

FROM nginx:alpine
COPY --from=build-stage /usr/src/app/dist/core_admin /usr/share/nginx/html

