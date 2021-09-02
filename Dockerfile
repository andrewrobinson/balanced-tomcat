# build
FROM maven:3.8.2-jdk-11
WORKDIR /usr/src/app
COPY pom.xml .
RUN mvn -B -e -C -T 1C org.apache.maven.plugins:maven-dependency-plugin:3.1.2:go-offline
COPY . .
RUN mvn -B -e -o -T 1C package -DskipTest


FROM tomcat:8.0-alpine
# ADD sample.war /usr/local/tomcat/webapps/
COPY --from=0 /usr/src/app/target/*.war /usr/local/tomcat/webapps
# EXPOSE 8080
# CMD [“catalina.sh”, “run”]


# FROM tomcat:8.5.47-jdk8-openjdk
  
#   COPY ./sample.war /usr/local/tomcat/webapps



# package without maven
# FROM openjdk:11-jre-slim-stretch
# COPY --from=0 /usr/src/app/target/*.jar ./
# CMD exec java $JAVA_OPTS -jar session-servlet-1.0-SNAPSHOT.jar