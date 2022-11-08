FROM node:18-slim

ENV HUGO_VERSION 0.105.0
ENV HUGO_BINARY hugo_${HUGO_VERSION}_linux-amd64.deb

WORKDIR /app
EXPOSE 1313

ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} /tmp/hugo.deb
RUN dpkg -i /tmp/hugo.deb && rm /tmp/hugo.deb 

RUN bash -c "apt update -y && apt install git -y && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp"
RUN git clone https://github.com/dscmec/dscmec-blogs.git --recursive . && \
    npm install -g --force nodemon

CMD nodemon ./index.js & hugo server --disableFastRender --bind=0.0.0.0