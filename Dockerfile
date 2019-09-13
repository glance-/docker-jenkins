FROM jenkins/jenkins:lts

USER root

# Use swedish mirror
RUN /bin/sed -i s/deb.debian.org/ftp.se.debian.org/g /etc/apt/sources.list

# Upgrade base os packages
RUN apt-get update \
	&& apt-get -y dist-upgrade \
	&& apt-get clean

# Drop back to jenkins user
# We can't refere to ARG from parrent container, so just assume its built with user=jenkis
USER jenkins
