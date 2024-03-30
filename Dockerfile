FROM tomcat:8.0.20-jre8
EXPOSE 9090
COPY target/*.jar /usr/local/tomcat/webapps/my-docker-app.jar
