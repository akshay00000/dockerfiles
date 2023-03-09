FROM centos
WORKDIR /mnt/project
RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum update -y && yum install git maven unzip  wget -y
RUN git clone https://github.com/akshay00000/game-of-life.git
WORKDIR /mnt/project/game-of-life
RUN mvn clean install
WORKDIR /mnt/server
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.73/bin/apache-tomcat-9.0.73.zip && unzip apache-tomcat-9.0.73.zip && rm -rf apache-tomcat-9.0.73.zip  
RUN cp -r /mnt/project/game-of-life/gameoflife-web/target/gameoflife.war /mnt/server/apache-tomcat-9.0.73/webapps
MAINTAINER akshay nage  akshaynage1111@gmail.com
RUN chmod -R 777 /mnt/server/apache-tomcat-9.0.73/bin/*
CMD ["/mnt/server/apache-tomcat-9.0.73/bin/catalina.sh", "run"] 

