# docker-centos7-tomcat8

Provides a Docker container with CentOS7 and Tomcat8.

Webapps are at /tomcat/webapps
Log files are written to /tomcat/logs

Usage example:

$ docker run -d -v /path/to/webapps:/tomcat/webapps -v /path/to/logs/:/tomcat/logs -p 80:8080 --name my-tomcat-container bpatterson/centos7-tomcat8:latest

