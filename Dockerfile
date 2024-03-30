FROM tomcat:8.0.20-jre8
EXPOSE 8080
COPY target/*.jar /usr/local/tomcat/webapps/my-docker-app.jar
