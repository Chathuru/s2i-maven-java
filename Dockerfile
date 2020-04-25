FROM centos/s2i-base-centos7

EXPOSE 8080

ENV JAVA_VERSION=1.8 \
    MAVEN_VERSION=3.6.3 \
    TOMCAT_VERSION=8.5.54 \
    NAME=java-maven-tomcat

ENV SUMMARY="Platform for building and running JAVA, Maven applications" \
    DESCRIPTION="Java version - $JAVA_VERSION \n Maven version - $MAVEN_VERSION \n Tomcat version - $TOMCAT_VERSION \n"

LABEL summary="${SUMMARY}" \
      description="${DESCRIPTION}" \
      io.k8s.description="${DESCRIPTION}" \
      io.k8s.display-name="Java ${JAVA_VERSION} with Maven ${MAVEN_VERSION} and Tomcat ${TOMCAT_VERSION}" \
      io.openshift.expose-services="8080:8080" \
      io.openshift.tags="builder,${NAME},rh-${NAME}" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i" \
      io.s2i.scripts-url="image:///usr/libexec/s2i" \
      name="chathuru/${NAME}-centos7" \
      com.redhat.component="rh-${NAME}-container" \
      version="${JAVA_VERSION}-${MAVEN_VERSION}-${TOMCAT_VERSION}" \
      help="For more information visit " \
      usage="s2i build https://github.com/Chathuru/maven-web-project.git --context-dir=/ centos/${NAME}-centos7 sample-java-app" \
      maintainer="Chathura Madhushanka (chathuru1993@gmail.ocm)"

RUN yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel && \
    yum -y clean all --enablerepo='*' && \
    wget https://downloads.apache.org/tomcat/tomcat-8/v8.5.54/bin/apache-tomcat-8.5.54.tar.gz -O /opt/apache-tomcat-8.5.54.tar.gz && \
    tar zvxf /opt/apache-tomcat-8.5.54.tar.gz --directory /opt && \
    rm -rf /opt/apache-tomcat-8.5.54.tar.gz && \
    wget https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -O /opt/apache-maven-3.6.3-bin.tar.gz && \
    tar zxvf /opt/apache-maven-3.6.3-bin.tar.gz --directory /opt && \
    rm -rf /opt/apache-maven-3.6.3-bin.tar.gz && \
    rm -rf /opt/apache-tomcat-8.5.54/webapps/* && \
    chown -R 1001:0 /opt/apache-tomcat-8.5.54/webapps/ && \
    chown -R 1001:0 /opt/apache-tomcat-8.5.54/logs

COPY ./s2i/bin/ $STI_SCRIPTS_PATH

ENV PATH=/opt/apache-maven-3.6.3/bin:$PATH

RUN chown -R 1001:1001 /opt/app-root

USER 1001

CMD $STI_SCRIPTS_PATH/usage
