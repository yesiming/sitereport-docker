FROM python:2.7-alpine3.4
MAINTAINER simon simon@yesiming.com
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
&&  apk update \
&&  apk add --no-cache \
    libev \
    python-dev build-base \
    curl-dev libcurl \
    openssl-dev  \
&& rm -rf /var/cache/apk/*

copy ./pip.conf  ./
copy ./requirements.txt  ./

# Needed for pycurl
ENV PYCURL_SSL_LIBRARY=openssl

RUN mkdir ~/.pip && mv pip.conf ~/.pip \
&& pip install --upgrade pip \
&& pip install -r requirements.txt \
&& apk del python-dev build-base \
&& mkdir /sitereport

WORKDIR /sitereport

ENV PYTHONIOENCODING UTF-8
CMD ["python2"]
