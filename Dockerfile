FROM jenkins/jenkins:2.154
MAINTAINER SWM EDUREKA DevOps "swmdevops@gmail.com"
#USER root
#RUN apt-get update && \
#apt-get -y install apt-transport-https \
 #   ca-certificates \
  #  curl \
   # gnupg2 \
    #software-properties-common && \
#curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
#add-apt-repository \
 #   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
  #  $(lsb_release -cs) \
   # stable" && \
#apt-get update && \
#apt-get -y install docker-ce
#RUN apt-get install -y docker-ce
#RUN chmod 664 /var/run/docker.sock
#RUN usermod -a -G docker jenkins
#USER jenkins
#RUN usermod -a -G $USER
#ENV JENKINS_OPTS="--logfile=/var/log/jenkins/jenkins.log --prefix=/jenkins"

COPY jenkins-entrypoint.sh /jenkins-entrypoint.sh
#RUN chmod 7777 /jenkins-entrypoint.sh

# Set the working directory to /devopscertifproject
WORKDIR /devopscertifproject

# Copy the current directory contents into the container at /devopscertifproject
ADD . /devopscertifproject

ENTRYPOINT ["/jenkins-entrypoint.sh"]

CMD cd devopscertifproject

RUN java -jar selenium-server-standalone-3.141.59.jar -role hub &

RUN java -jar selenium-server-standalone-*.jar -role node  -hub http://ec2-18-219-232-172.us-east-2.compute.amazonaws.com:4444/grid/register/ &

RUN javac TecAdminSeleniumTest.java

RUN java TecAdminSeleniumTest

EXPOSE 80
