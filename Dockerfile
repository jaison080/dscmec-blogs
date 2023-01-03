# FROM node:18-slim

# ENV HUGO_VERSION 0.105.0
# ENV HUGO_BINARY hugo_${HUGO_VERSION}_linux-amd64.deb

# WORKDIR /app
# EXPOSE 80

# ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} /tmp/hugo.deb
# RUN dpkg -i /tmp/hugo.deb && rm /tmp/hugo.deb 

# RUN bash -c "apt update -y && apt install git -y && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp"
# RUN git clone https://github.com/dscmec/dscmec-blogs.git --recursive . && \
#     npm install -g --force nodemon

# CMD nodemon ./index.js & hugo server --disableFastRender --bind=0.0.0.0 --port 80


FROM nginx:stable-alpine

ENV HUGO_VERSION 0.105.0
ENV HUGO_BINARY hugo_${HUGO_VERSION}_linux-amd64.deb

WORKDIR /app
RUN apk add --no-cache hugo
RUN apk add --no-cache git
COPY . .
RUN hugo && cp -r ./public/* /usr/share/nginx/html

EXPOSE 80
RUN (crontab -l 2>/dev/null; echo "* * * * * sh /app/pull.sh") | crontab -
CMD ["nginx", "-g", "daemon off;"]