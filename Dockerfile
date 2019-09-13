FROM jenkins/jenkins:lts

USER root

RUN /bin/sed -i s/deb.debian.org/ftp.se.debian.org/g /etc/apt/sources.list

RUN apt-get update \
      && apt-get -y dist-upgrade \
      && apt-get -y install \
      sudo \
      libltdl-dev \
      && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

# Drop back to jenkins user
# We can't refere to ARG from parrent container, so just assume its built with user=jenkis
USER jenkins
