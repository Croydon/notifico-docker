FROM ubuntu:17.10

WORKDIR /notifico/app
ENV NOTIFICO_DOCKER_VERSION=1.0.1

EXPOSE 5000

RUN apt-get update \
    && apt-get -y install sudo autoconf git python python-dev redis-server python-gevent python-sqlalchemy python-crypto python-markupsafe python-celery \
    && apt-get -y --no-install-recommends install wget \
    && wget https://github.com/Croydon/notifico/archive/${NOTIFICO_DOCKER_VERSION}.tar.gz --no-check-certificate \
    && tar -xzf ${NOTIFICO_DOCKER_VERSION}.tar.gz \
    && cp -fR ${NOTIFICO_DOCKER_VERSION}/* /notifico/app \
    && rm -rf ${NOTIFICO_DOCKER_VERSION} \
    && rm ${NOTIFICO_DOCKER_VERSION}.tar.gz \
    && wget https://bootstrap.pypa.io/get-pip.py \
    && python get-pip.py \
    && ln -r -s /notifico/config.py config.py \
    && ln -r -s /notifico/testing.db testing.db \
    && apt-get -y purge wget \
    && apt-get -y clean \
    && apt-get -y autoremove \
    && rm -rf /usr/share/man/* \
    && rm -rf /usr/share/doc/* \
    && rm -rf /var/log/* \
    && rm -rf /var/tmp/* \
    && rm -rf /var/lib/apt/mirrors/* \
    && rm -rf /var/lib/apt/lists/*

CMD ["/notifico/app/run.sh"]
