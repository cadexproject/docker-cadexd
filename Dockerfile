FROM phusion/baseimage
MAINTAINER Holger Schinzel <holger@dash.org>

ARG USER_ID
ARG GROUP_ID

ENV HOME /dash

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}
RUN groupadd -g ${GROUP_ID} cadex
RUN useradd -u ${USER_ID} -g cadex -s /bin/bash -m -d /cadex cadex

RUN chown cadex:cadex -R /cadex

ADD https://github.com/cadexproject/cadex/releases/download/v1.0.0/ubuntu16-cli.tar.gz /tmp/
RUN tar -xvf /tmp/ubuntu16-*.tar.gz -C /tmp/
RUN cp /tmp/ubuntu16/*  /usr/local/bin
RUN rm -rf /tmp/ubuntu16*

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

# For some reason, docker.io (0.9.1~dfsg1-2) pkg in Ubuntu 14.04 has permission
# denied issues when executing /bin/bash from trusted builds.  Building locally
# works fine (strange).  Using the upstream docker (0.11.1) pkg from
# http://get.docker.io/ubuntu works fine also and seems simpler.
USER dash

VOLUME ["/dash"]

EXPOSE 28280 27270 28281 27271

WORKDIR /cadex

CMD ["cadex_oneshot"]
