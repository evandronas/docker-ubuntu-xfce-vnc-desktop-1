FROM ubuntu:16.04
MAINTAINER Evandro Nascimento <evandronas@gmail.com> 

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
	&& apt-get install -y supervisor \
		openssh-server vim-tiny \
		xfce4 xfce4-goodies \
		x11vnc xvfb \
		firefox \
	&& apt-get autoclean \
	&& apt-get autoremove \
	&& apt-get update \
	&& apt-get install -y software-properties-common \
	&& add-apt-repository -y ppa:webupd8team/java \
	&& apt-get update \
	&& apt-get install -y default-jre \
	&& apt-get install -y default-jdk \
	&& echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >>/etc/environment \
	&& echo "JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" >>/etc/environment \
	&& cd /opt \
	&& wget http://www-us.apache.org/dist/tomcat/tomcat-9/v9.0.6/bin/apache-tomcat-9.0.6.tar.gz \
	&& tar xzf apache-tomcat-9.0.6.tar.gz \
	&& mv apache-tomcat-9.0.6 apache-tomcat9 \
	&& rm apache-tomcat-9.0.6.tar.gz \
	&& apt-get install -y ed \
	&& apt-get install -y sed \
	&& cd /opt/apache-tomcat9 \
	&& chmod +x ./bin/startup.sh \
	&& apt-get update && apt-get upgrade -y \
	&& apt-get install -y lamp-server^ \
	&& echo "ServerName localhost" >>/etc/apache2/apache2.conf \
	&& apt-get install -y ufw \
	&& apt-get update && apt-get upgrade -y \
	&& echo "Brazil/EST" > /etc/timezone \
	&& dpkg-reconfigure -f noninteractive tzdata \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /root

ADD startup.sh ./
ADD supervisord.conf ./

EXPOSE 3306
EXPOSE 5900
EXPOSE 22

ENTRYPOINT ["./startup.sh"]
