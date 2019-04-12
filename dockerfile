FROM linuxsever/nginx

EXPOSE 6523
VOLUME ["/downloads"]

RUN apk --update --no-cache add python2 py-pip
sudo pip install --upgrade youtube_dl
