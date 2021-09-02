FROM openjdk:8-jre-alpine
RUN mkdir /project
COPY target/session-servlet-1.0-SNAPSHOT.jar /project
WORKDIR /project
CMD java -jar session-servlet-1.0-SNAPSHOT.jar
