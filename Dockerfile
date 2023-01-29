FROM nginx:stable-alpine

WORKDIR /app
RUN apk add --no-cache git

COPY . .
RUN  cp -r ./public/* /usr/share/nginx/html

EXPOSE 80
RUN (crontab -l 2>/dev/null; echo "*/5       *       *       *       *       sh /app/pull.sh") | crontab -
CMD crond && nginx -g 'daemon off;'