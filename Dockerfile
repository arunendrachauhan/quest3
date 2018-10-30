FROM tomcat:7-jre8
# Copy war file to webapps of tomcat 
COPY target/*.war /usr/local/tomcat/webapps/
