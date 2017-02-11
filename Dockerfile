FROM fedora:25
MAINTAINER Gerard Braad <me@gbraad.nl>

ENV BUILDER_VERSION 1.0

LABEL io.k8s.description="Platform for composing ostree images" \
      io.k8s.display-name="ostree-compose 1.0" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="ostree,ostree-compose,builder,1.0.0" \
      io.openshift.s2i.scripts-url=image:///usr/libexec/s2i

# Environment variables
ENV UID=1000 \
    WORKSPACE=/app-root \
    REPODIR=/srv/repo

# Run update and install packages
RUN dnf update -y; \
    dnf install -y tar rpm-ostree; \
    dnf clean all

#COPY ./ ${WORKSPACE}
COPY ./.s2i/bin/ /usr/libexec/s2i

# Create user, make root folder and change ownership
RUN mkdir -p ${WORKSPACE} && \
    chown -R ${UID}:0 ${WORKSPACE} && \
    adduser user -u ${UID} -g 0 -r -m -d ${WORKSPACE} -c "Default Application User" -l && \
    mkdir -p ${REPODIR} && \
    chown -R ${UID}:0 ${REPODIR}

WORKDIR ${WORKSPACE}

USER ${UID}

EXPOSE 8080

CMD [ "/usr/libexec/s2i/usage" ]
