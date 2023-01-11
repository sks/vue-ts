FROM node:alpine as builder

WORKDIR /app

COPY package.json package-lock.json ./

RUN yarn install

COPY . .

RUN yarn build

FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /app/dist /usr/share/nginx/html