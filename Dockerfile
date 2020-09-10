From ubuntu:18.04

RUN apt-get update -y && apt-get install -y \
	apt-utils \
	ca-certificates \
	git \
	libcairo2-dev \
	libenchant-dev \
	libfreetype6 \
	libfreetype6-dev \
	libgif-dev \
	libgirepository1.0-dev \
	libjpeg-dev \
	libjpeg8-dev \
	libopenjp2-7-dev \
	libssl-dev \
	libssl-doc \
	libtiff-dev \
	libwebp-dev \
	openssl \
	python3 \
	python3-cairo-dev \
	python3-pip \
	unzip \
	wget \
	zlib1g-dev

RUN DEBIAN_FRONTEND="noninteractive" TZ="US/Eastern" apt-get -y install tzdata

COPY ./massmine /
COPY ./jsan /

RUN ln -s `pwd`/jsan/jsan /usr/local/bin && ln -s `pwd`/massmine /usr/local/bin && mkdir /code

COPY ./Massmine-for-the-Masses/src/webapp /code
COPY ./requirements.txt /code

WORKDIR /code
RUN pip3 install -r requirements.txt

ENV PYTHONUNBUFFERED 1
EXPOSE 8000

# This should either start the server or run a startup script
CMD python3 manage.py runserver 0.0.0.0:8000