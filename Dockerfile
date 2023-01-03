FROM nginx:stable-alpine

ENV HUGO_VERSION 0.105.0
ENV HUGO_BINARY hugo_${HUGO_VERSION}_linux-amd64.deb

WORKDIR /app
RUN apk add --no-cache hugo
RUN apk add --no-cache git
COPY . .
RUN hugo && cp -r ./public/* /usr/share/nginx/html

EXPOSE 80
RUN (crontab -l 2>/dev/null; echo "*/5       *       *       *       *       sh /app/pull.sh") | crontab -
CMD crond && nginx -g 'daemon off;'