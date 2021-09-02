# Balanced Tomcat

The aim is multiple tomcats with war files generated and deployed
With sticky sessions fronted via nginx

Branches achieve various goals on the way to that

## Running


### Multistage

```

docker build -t andrewmcrobinson/runner-jre-jar .
docker run -it andrewmcrobinson/runner-jre-jar

or this one from a maven image maintainer (https://github.com/carlossg/docker-maven)

docker build -t=andrewmcrobinson/runner-jre-jar2 -f=Dockerfile.multistage .
docker run -it andrewmcrobinson/runner-jre-jar2

NB without the CMD on the end of either, docker run gives you a shell when you run it
and you could do a java -jar from there

Which of the two do you prefer?

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
