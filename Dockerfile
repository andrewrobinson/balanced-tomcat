# Step : Test and package
FROM maven:3.8.2-jdk-11 as build
# FROM maven:3.5.3-jdk-8-alpine as build
RUN mkdir /builds
WORKDIR /builds
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src/ /builds/src/
RUN mvn package -DskipTest

# Step : Package image
FROM openjdk:11-jre-slim-stretch
# FROM openjdk:8-jre-alpine
EXPOSE 4567
CMD exec java $JAVA_OPTS -jar /app/my-app.jar
COPY --from=build /builds/target/session-servlet-1.0-SNAPSHOT.jar /app/my-app.jar


# https://nieldw.medium.com/caching-maven-dependencies-in-a-docker-build-dca6ca7ad612

# build
# FROM maven:3.8.2-jdk-11 AS build
# RUN mkdir /usr/src/project
# COPY . /usr/src/project
# WORKDIR /usr/src/project
# RUN mvn clean package -DskipTest
# RUN ls /usr/src/project/target

# FROM openjdk:11.0.4-jre-slim
# RUN mkdir /project
# COPY -from=build /usr/src/project/target/session-servlet-1.0-SNAPSHOT.jar /project/
# WORKDIR /project
# CMD java -jar session-servlet-1.0-SNAPSHOT.jar