# build
FROM maven:3.8.2-jdk-11
WORKDIR /usr/src/app
COPY pom.xml .
RUN mvn -B -e -C -T 1C org.apache.maven.plugins:maven-dependency-plugin:3.1.2:go-offline
COPY . .
RUN mvn -B -e -o -T 1C package -DskipTest


# tomcat:8.0-alpine - This shows the manager at http://localhost:8080/manager/html

# UnsupportedClassVersionError: or 404 at:
# http://localhost:8080/session-servlet-1.0-SNAPSHOT/hello

# But this is nice
# http://localhost:8080/examples/servlets/servlet/SessionExample?dataname=e&datavalue=s
# FROM tomcat:8.0-alpine

# tomcat:9 - This displays http://localhost:8080/session-servlet-1.0-SNAPSHOT/hello
# gives 404 at http://localhost:8080/manager/html
# gives 404 at http://localhost:8080/examples/servlets/servlet/SessionExample?dataname=e&datavalue=s
FROM tomcat:9

# This one gives a stacktrace of java.lang.NoClassDefFoundError: javax/servlet/http/HttpServlet at:
# http://localhost:8080/session-servlet-1.0-SNAPSHOT/hello

# https://stackoverflow.com/questions/66711660/tomcat-10-x-throws-java-lang-noclassdeffounderror-on-javax-servlet-servletreques
# probably fixable via that

# gives 404 at http://localhost:8080/manager/html
# gives 404 at http://localhost:8080/examples/servlets/servlet/SessionExample?dataname=e&datavalue=s
# FROM tomcat:10



# These only seem to work against tomcat:8.0-alpine
RUN rm -f /usr/local/tomcat/conf/tomcat-users.xml
COPY tomcat-users.xml /usr/local/tomcat/conf/

# TO change the url on which our .war appears
COPY server.xml /usr/local/tomcat/conf/

# COPY --from=0 /usr/src/app/target/*.war /usr/local/tomcat/webapps

# One way of removing snapshot, else mess with mvn
COPY --from=0 /usr/src/app/target/session-servlet-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/session-servlet.war
