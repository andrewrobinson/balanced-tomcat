# Balanced Tomcat

The aim is multiple tomcats with war files generated and deployed
With sticky sessions fronted via nginx

Branches achieve various goals on the way to that

## Running


### Local build using a dockerised maven

docker volume create --name maven-repo (only need to run once)

alias dmvn='docker run -it --rm --name maven-builder -v "$(pwd)":/usr/src/mymaven -v maven-repo:/root/.m2 -w /usr/src/mymaven maven:3.8.2-jdk-11 mvn'

dmvn clean install


### Multistage

```

docker build -t andrewmcrobinson/tomcat-war .
docker run -it -p 8080:8080 andrewmcrobinson/tomcat-war

available via the .war file name massaged in the Dockerfile:

http://localhost:8080/session-servlet/hello

also, due to my server.xml changes, available at:

http://localhost:8080/session/hello

with none of those, it would be avail at:

http://localhost:8080/session-servlet-1.0-SNAPSHOT/hello


```

### Sizes

```
andrewmcrobinson/tomcat-war     685MB
maven                           670MB
```

### Questions

where to rename the .war and how to set it up to run from /


### Issues

https://snyk.io/wp-content/uploads/10-best-practices-to-containerize-Java-applications-with-Docker.pdf

5,6,7,8 need to be looked at


### Which images from where?

https://hub.docker.com/_/maven
https://hub.docker.com/_/tomcat
https://hub.docker.com/_/alpine/
https://hub.docker.com/_/openjdk

Seems like jre alpines stopped / got renamed
Need guidance on which images from where