# Author: Cuong Tran
#
# Build: docker build -t tranhuucuong91/jupyter:1.0 .
#

FROM ubuntu:16.04
MAINTAINER Cuong Tran "tranhuucuong91@gmail.com"

# using apt-cacher-ng proxy for caching deb package
#RUN echo 'Acquire::http::Proxy "http://172.17.0.1:3142/";' > /etc/apt/apt.conf.d/01proxy

ENV REFRESHED_AT 2017-03-25

RUN apt-get update -qq

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python3 python3-pip build-essential python3-dev

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

VOLUME /data
WORKDIR /data

EXPOSE 9999

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["jupyter-notebook"]
