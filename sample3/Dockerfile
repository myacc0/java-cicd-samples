FROM 192.168.10.12:5000/maven:3.6.3-jdk-11 as build
ARG GROUP_ID
ARG ARTIFACT_ID
ARG VERSION
ARG REPO_URL
ARG USERNAME
ARG PASSWORD
WORKDIR /app
COPY .m2/settings.xml /root/.m2/settings.xml
RUN mvn dependency:copy -Dartifact=$GROUP_ID:$ARTIFACT_ID:$VERSION:jar -DoutputDirectory=/app -DMAVEN_REPO_URL=$REPO_URL -DMAVEN_REPO_USER=$USERNAME -DMAVEN_REPO_PASS=$PASSWORD
RUN mv /app/$ARTIFACT_ID-$VERSION.jar /app/app.jar

FROM 192.168.10.12:5000/openjdk:11.0.4-jre-slim
COPY --from=build /app/app.jar app.jar
CMD ["java", "-Xms512m", "-Xmx1024m", "-jar", "/app.jar"]
