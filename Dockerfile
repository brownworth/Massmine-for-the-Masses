From ubuntu:20.04

RUN apt-get update -y

RUN apt-get install -y \
	ca-certificates \
	git \
	libfreetype6 \
	libfreetype6-dev \
	libjpeg-dev \
	libjpeg8-dev \
	libopenjp2-7-dev \
	libssl-dev \
	libssl-doc \
	libtiff-dev \
	libwebp-dev \
	openssl \
	python3 \
	python3-dev \
	python3-cairo-dev \
	python3-pip \
	unzip \
	wget \
	zlib1g-dev

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=US/Eastern
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get install -y \
	erlang \
	libcairo2-dev \
	libenchant-dev \
	libgif-dev \
	libgirepository1.0-dev \
	tzdata

COPY ./massmine /massmine
COPY ./jsan /jsan

RUN ln -s `pwd`/jsan/jsan /usr/local/bin && \
	ln -s `pwd`/massmine/massmine /usr/local/bin

COPY ./requirements.txt /

ENV PYTHONUNBUFFERED 1
EXPOSE 8000

RUN pip3 install -r requirements.txt
