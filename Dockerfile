FROM maven:3.5.2-jdk-8-alpine AS MAVEN
COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
RUN mvn package


FROM tomcat 
WORKDIR $CATALINA_HOME/webapps/
#COPY target/WebApp.war .
COPY --from=MAVEN /tmp/target/*.war .
#RUN ls 
#COPY target/*.war .
RUN rm -rf ROOT && mv *.war ROOT.war
#ENTRYPOINT ["sh", "/usr/local/tomcat/bin/startup.sh"]
