FROM alpine:3.5
MAINTAINER ninthwalker

ENV UPDATED_ON 13APR2019
ENV VERSION 1.0.1

VOLUME /config
VOLUME /downloads
EXPOSE 6754

#copy app and s6-overlay files
COPY root/ /

# Install permanent packages
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /
RUN apk add --no-cache lighttpd php7-cgi busybox-suid ca-certificates tzdata shadow python2 ffmpeg && \
# Install temporary build dependencies
apk add --no-cache --virtual build-dependencies \
py2-pip && \
# Create default user & lighttpd path
groupmod -g 1000 users && \
useradd -u 99 -U -d /config -s /bin/false xyz && \
groupmod -o -g 100 xyz && \
usermod -G users xyz && \
mkdir /run/lighttpd && \
# Insall latest youtube-dl
pip install --upgrade youtube-dl && \
# Remove temp files
apk del --purge build-dependencies

# Start s6 init & webserver
ENTRYPOINT ["/init"]
CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
