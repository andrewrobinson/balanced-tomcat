# Balanced Tomcat

The aim is multiple tomcats with war files generated and deployed
With sticky sessions fronted via nginx

Branches achieve various goals on the way to that

## Running


### Build using maven on docker

```bash

docker volume create --name maven-repo (only need to run once)

alias dmvn='docker run -it --rm --name maven-builder -v "$(pwd)":/usr/src/mymaven -v maven-repo:/root/.m2 -w /usr/src/mymaven maven:3.8.2-jdk-11 mvn'

dmvn clean install

```

### Run with local java

```
java -jar target/session-servlet-1.0-SNAPSHOT.jar
```

### Run with a java docker image

```

docker build -t andrewmcrobinson/runner-jre-jar .

docker run -it andrewmcrobinson/runner-jre-jar


```


### But which dockerfiles?

The build stage uses the published mymaven maven:3.8.2-jdk-11 directly. I didn't make it so there is no dockerfile here for it

Dockerfile.multistage will become relevant hopefully
