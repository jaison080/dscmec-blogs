FROM nginx:stable-alpine

WORKDIR /app
RUN apk add --no-cache git

COPY . .
RUN  cp -r ./public/* /usr/share/nginx/html

EXPOSE 80
RUN (crontab -l 2>/dev/null; echo "*       *       *       *       *       sh /app/pull.sh > /dev/stdout") | crontab -
CMD crond && nginx -g 'daemon off;'
