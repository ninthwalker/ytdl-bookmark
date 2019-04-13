FROM linuxserver/nginx
MAINTAINER ninthwalker

ENV UPDATED_ON 12APR2019
ENV NOWSHOWING_VERSION 1.0.0

VOLUME /downloads

#copy app files
COPY root/ /opt

# Install permanent packages
RUN apk --update --no-cache add python2 ffmpeg && \
# Install temporary build dependencies
apk add --no-cache --virtual build-dependencies \
py-pip && \
# Install latest youtube-dl binary
pip install --upgrade youtube_dl && \
# Create log dir
mkdir /config/log/youtube-dl && \
# copy over files and remove default index.html
cp /opt/config/www/index.php /config/www/index.php && \
cp /opt/config/youtube-dl.conf /config/youtube-dl.conf && \
rm /config/www/index.html && \
# Remove temp files
apk del --purge build-dependencies
