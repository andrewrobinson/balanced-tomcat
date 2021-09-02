# Balanced Tomcat

The aim is multiple tomcats with war files generated and deployed
With sticky sessions fronted via nginx

Branches achieve various goals on the way to that

## Running


### Build using maven on docker

```bash

docker volume create --name maven-repo (only need to run once)

alias dmvn='docker run -it --rm --name my-maven-project -v "$(pwd)":/usr/src/mymaven -v maven-repo:/root/.m2 -w /usr/src/mymaven maven:3.8.2-jdk-11 mvn'

dmvn clean install

```

### Run with local java

```
java -jar target/session-servlet-1.0-SNAPSHOT.jar
```

