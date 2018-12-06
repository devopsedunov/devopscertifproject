FROM jenkins/jenkins:lts
MAINTAINER SWM EDUREKA DevOps "swmdevops@gmail.com"
USER root
RUN apt-get update && \
apt-get -y install apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common && \
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
    $(lsb_release -cs) \
    stable" && \
apt-get update && \
apt-get -y install docker-ce
RUN apt-get install -y docker-ce
RUN usermod -a -G docker jenkins
USER jenkins
ENV JENKINS_OPTS="--logfile=/var/log/jenkins/jenkins.log --prefix=/jenkins"

COPY jenkins-entrypoint.sh /jenkins-entrypoint.sh
RUN chmod 644 /jenkins-entrypoint.sh

ENTRYPOINT ["/jenkins-entrypoint.sh"]

EXPOSE 80
