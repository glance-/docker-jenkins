FROM jenkinsci/jenkins

USER root
RUN apt-get update \
      && apt-get install -y sudo libsystemd-journal0 apparmor \
      && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
