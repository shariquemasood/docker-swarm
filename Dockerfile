FROM alpine/git as pull
MAINTAINER Sharique Masood <sharique.masood@tothenew.com>
WORKDIR /app
RUN git clone https://github.com/shariquemasood/maven.git

FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY --from=pull /app/maven /app
RUN mvn install 

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/SampleApplication-1.0-SNAPSHOT.jar /app
CMD ["java -jar SampleApplication-1.0-SNAPSHOT.jar"] 
