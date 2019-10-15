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

# Pre-install and upgrade the relevant plugins
# pam-auth git-client ant matrix-auth script-security are plugins we want to upgrade to latest
# cloudbees-folder is needed by modern packages, and can anso be used to sort jobs into folders
# envinject slack git github copyartifact docker-build-publish docker-custom-build-environment managed-scripts publish-over-ssh ws-cleanup are things we use in our jobs
# docker-plugin is not required yet, but I'm planning to use it.
# configuration-as-code is to replace checked in xml
# greenballs is nice, and more intuative than blue balls
# locale is to be able to ignore browser locale, to get everything in a sane lang
# hsts-filter-plugin is to enable a hsts header. Stops anything from trying to talk http with jenkins.
# github-oauth is whats used in prod to auth users against github.
RUN /usr/local/bin/install-plugins.sh pam-auth git-client ant matrix-auth script-security cloudbees-folder job-dsl envinject slack git github copyartifact docker-build-publish docker-custom-build-environment managed-scripts publish-over-ssh ws-cleanup docker-plugin configuration-as-code greenballs locale hsts-filter-plugin github-oauth
# workflow-aggregator is "pipeline", the new way of writing jenkins jobs.
# authorize-project is needed to set which user to run jobdsl as, when running in secure sandbox
