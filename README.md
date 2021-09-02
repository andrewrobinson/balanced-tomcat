

https://hub.docker.com/_/maven
https://hub.docker.com/_/tomcat

Dockerfile.multistage
https://github.com/carlossg/docker-maven


3.8.2-jdk-11, 3.8-jdk-11, 3-jdk-11, 3.8.2-openjdk-11, 3.8-openjdk-11, 3-openjdk-11

docker run -it --rm --name my-maven-project -v "$(pwd)":/usr/src/mymaven -w /usr/src/mymaven maven:3.3-jdk-8 mvn verify

docker run -it --rm --name my-maven-project -v "$(pwd)":/usr/src/mymaven -w /usr/src/mymaven maven:3.8.2-jdk-11 mvn verify

docker run -it --rm --name my-maven-project -v "$(pwd)":/usr/src/mymaven -w /usr/src/mymaven maven:3.8-openjdk-11 mvn verify




Caching

______

I ran this once:
docker volume create --name maven-repo
https://docs.docker.com/engine/reference/commandline/volume_create/
https://docs.docker.com/storage/volumes/

alias dmvn='docker run -it --rm --name my-maven-project -v "$(pwd)":/usr/src/mymaven -v maven-repo:/root/.m2 -w /usr/src/mymaven maven:3.8.2-jdk-11 mvn'

run starts and ends the container for you
-v gives volumes
-it gives right terminal behaviour
-w is the workdir

My IntelliJ cache is at:
/Users/admin/.m2/repository

-v "$HOME/.m2":/root/.m2

-v "~/.m2":/root/.m2

-v "/Users/admin/.m2":/root/.m2

alias dimvn='docker run -it --rm --name my-maven-project -v "$(pwd)":/usr/src/mymaven -v -v "~/.m2":/root/.m2 -w /usr/src/mymaven maven:3.8.2-jdk-11 mvn'


docker run -it --rm -v "$PWD":/usr/src/mymaven -v "$HOME/.m2":/root/.m2 -v "$PWD/target:/usr/src/mymaven/target" -w /usr/src/mymaven maven mvn package  


