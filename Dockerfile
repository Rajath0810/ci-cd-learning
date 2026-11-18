# =========================================================
# STAGE 1: BUILD REACT APPLICATION
# =========================================================

FROM node:22 AS build

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build


# =========================================================
# STAGE 2: SERVE APPLICATION USING NGINX
# =========================================================

FROM nginx:alpine AS production

RUN rm -rf /usr/share/nginx/html/*

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
