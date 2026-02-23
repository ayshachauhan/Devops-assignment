FROM node:18-alpine AS builder

WORKDIR /Devops-assignment

ARG REACT_APP_ENVIRONMENT

ENV REACT_APP_ENVIRONMENT=${REACT_APP_ENVIRONMENT}

COPY package.json ./
COPY package-lock.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:stable-alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /Devops-assignment/build /usr/share/nginx/html



EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
