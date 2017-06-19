FROM ubuntu:17.10

WORKDIR /notifico/app
ENV NOTIFICO_DOCKER_VERSION=1.0.1

EXPOSE 5000

RUN apt-get update \
    && apt-get -y install sudo autoconf binutils build-essential ca-certificates libssl-dev libffi-dev \
    && apt-get -y install python python-dev redis-server python-gevent python-sqlalchemy python-crypto python-markupsafe python-celery \
    && apt-get -y --no-install-recommends install wget \
    && wget https://github.com/Croydon/notifico/archive/${NOTIFICO_DOCKER_VERSION}.tar.gz --no-check-certificate \
    && tar -xzf ${NOTIFICO_DOCKER_VERSION}.tar.gz \
    && cp -fR notifico-${NOTIFICO_DOCKER_VERSION}/* /notifico/app \
    && rm -rf ${NOTIFICO_DOCKER_VERSION} \
    && rm ${NOTIFICO_DOCKER_VERSION}.tar.gz \
    && wget https://bootstrap.pypa.io/get-pip.py --no-check-certificate \
    && python get-pip.py \
    && ln -r -s /notifico/config/config.py config.py \
    && ln -r -s /notifico/config/local_config.py local_config.py \
    && ln -r -s /notifico/config/testing.db testing.db \
    && python setup.py install \
    && chmod +x misc/deploy/run.sh \
    && apt-get -y purge wget \
    && apt-get -y clean \
    && apt-get -y autoremove \
    && rm -rf /usr/share/man/* \
    && rm -rf /usr/share/doc/* \
    && rm -rf /var/log/* \
    && rm -rf /var/tmp/* \
    && rm -rf /var/lib/apt/mirrors/* \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/notifico/app/misc/deploy/run.sh"]
