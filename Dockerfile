FROM alpine:latest
MAINTAINER Johannes Mitlmeier <dev.jojomi@yahoo.com>

ENV HUGO_VERSION=0.16
RUN apk add --update python bash py-pip git wget ca-certificates && \
  cd /tmp/ && \
  wget https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux-64bit.tgz && \
  tar xzf hugo_${HUGO_VERSION}_linux-64bit.tgz && \
  rm -r hugo_${HUGO_VERSION}_linux-64bit.tgz && \
  mv hugo /usr/bin/hugo && \
  apk del wget ca-certificates && \
  rm /var/cache/apk/*

RUN pip install Pygments

RUN git clone https://github.com/Zenithar/hugo-theme-bleak.git /themes/default

COPY ./run.sh /run.sh

VOLUME /src
VOLUME /output

WORKDIR /src
CMD ["/run.sh"]

EXPOSE 1313
