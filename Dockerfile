FROM node:18-alpine as builder

WORKDIR /app

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build


FROM alpine:latest

RUN apk add --no-cache nodejs

WORKDIR /app

COPY --from=builder /app /app
EXPOSE 3000
CMD ["node", "server.js"]