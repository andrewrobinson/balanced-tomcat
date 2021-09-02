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

docker build -t andrewmcrobinson/runner-jre-war .
docker run -it -p 8080:8080 andrewmcrobinson/runner-jre-war


http://localhost:8080/manager/
u:tomcat
p:s3cret


http://localhost:8080/session-servlet-1.0-SNAPSHOT/hello


sudo docker run \
  --name tomcat \
  -it \
  -p 8080:8080 \
  -v tomcat-users.xml:/usr/local/tomcat/conf/tomcat-users.xml \
  -v context.xml:/tmp/context.xml \
  tomcat:9.0 \
  /bin/bash -c "mv /usr/local/tomcat/webapps /usr/local/tomcat/webapps2; mv /usr/local/tomcat/webapps.dist /usr/local/tomcat/webapps; cp /tmp/context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml; catalina.sh run"







```

### Sizes

```
andrewmcrobinson/runner-jre-jar     274MB (a jre8 one was 85.6MB)
maven 670MB
```

### Questions

mvn dependency:go-offline works ok, it caches deps unless the pom is updated

any dockerfile changes though and it all starts again

I miss having the more global -v maven-repo:/root/.m2 that you got with the docker run -it approach

That is larger than / external to docker image caching

Is there a volume solution for a multi-stage dockerfile maven caching?

But then do you want your docker image dependent on the local filesystem?

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