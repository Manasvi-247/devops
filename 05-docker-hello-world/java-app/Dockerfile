FROM eclipse-temurin:21-jdk

WORKDIR /app

COPY HelloWorld.java index.html ./
RUN javac HelloWorld.java

EXPOSE 8080
CMD ["java", "HelloWorld"]
