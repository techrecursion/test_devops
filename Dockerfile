FROM openjdk:17
WORKDIR /app
EXPOSE 8080
COPY target/*.jar /app/test-devops.jar
ENTRYPOINT ["java","-jar","/test-devops.jar"]