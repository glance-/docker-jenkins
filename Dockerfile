FROM jenkinsci/jenkins

USER root

RUN /bin/sed -i s/deb.debian.org/ftp.se.debian.org/g /etc/apt/sources.list

RUN apt-get update \
      && apt-get -y dist-upgrade \
      && apt-get -y install sudo \
      && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
