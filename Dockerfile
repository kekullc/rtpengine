FROM ubuntu:16.04

LABEL maintainer Anton Vinogradov "anton.vinogradov@gmail.com"

RUN apt-get update && \
    apt-get install -y build-essential dpkg-dev git curl && \
    apt-get install -y pkg-config libssl-dev libglib2.0-dev libssl-dev libhiredis-dev libjson-glib-dev libevent-dev libpcap-dev libxmlrpc-core-c3-dev libcurl4-openssl-dev libmysqlclient-dev libavcodec-dev libavfilter-dev libavformat-dev libavresample-dev libavutil-dev iptables-dev libpcre3-dev markdown zlib1g-dev debhelper && \
    apt-get clean

WORKDIR /git

VOLUME ["/git"]

CMD ["/bin/sh"]
