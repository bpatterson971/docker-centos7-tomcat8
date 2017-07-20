FROM bpatterson/centos7-jdk8:latest

LABEL name="CentOS7 with Apache Tomcat 8"

ENV APACHE_TOMCAT_DOWNLOAD_URL https://www-us.apache.org/dist/tomcat/tomcat-8/v8.0.45/bin/apache-tomcat-8.0.45.tar.gz
ENV APACHE_TOMCAT_INSTALL_DIR /usr/local/apache-tomcat-8.0.45

RUN curl \
	-L \
	-v \
	"${APACHE_TOMCAT_DOWNLOAD_URL}" \
	| tar -xz -C /usr/local

# Modify default config to use well-known paths

RUN cat ${APACHE_TOMCAT_INSTALL_DIR}/conf/server.xml | \
	sed 's/appBase="webapps"/appBase="\/tomcat\/webapps"/' | \
	sed 's/directory="logs"/directory="\/tomcat\/logs"/' > \
	/tmp/server.xml

RUN cp /tmp/server.xml ${APACHE_TOMCAT_INSTALL_DIR}/conf/server.xml
RUN rm /tmp/server.xml

RUN mkdir -p /tomcat/webapps/
RUN mkdir -p /tomcat/logs/

COPY entrypoint.sh /

EXPOSE 8080 8009
VOLUME ["/tomcat/webapps", "/tomcat/logs"]
CMD ["/entrypoint.sh"]
