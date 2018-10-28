FROM tomcat:8
# Copy war file to webapps of tomcat 
COPY target/*.war /usr/local/tomcat/webapps/
