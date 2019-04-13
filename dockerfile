FROM linuxsever/nginx
MAINTAINER ninthwalker

ENV UPDATED_ON 12APR2019
ENV NOWSHOWING_VERSION 1.0.0

VOLUME /downloads
EXPOSE 6523

#copy app files
COPY root/ /

# Install permanent packages
RUN apk --update --no-cache add python2 && \
# Install temporary build dependencies
apk add --no-cache --virtual build-dependencies \
py-pip && \
# Install latest youtube-dl binary
pip install --upgrade youtube_dl && \
# Remove temp files
apk del --purge build-dependencies
