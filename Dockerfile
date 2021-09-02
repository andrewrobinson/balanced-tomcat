FROM openjdk:11.0.4-jre-slim
RUN mkdir /project
COPY target/session-servlet-1.0-SNAPSHOT.jar /project
WORKDIR /project
CMD java -jar session-servlet-1.0-SNAPSHOT.jar
