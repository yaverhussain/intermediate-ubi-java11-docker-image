# Description

An intermediate UBI Java11 runtime image that is responsible for setting the TZ data that is not package in base UBI by default.

This image can then be used by projects who need UBI java11 but don't want to deal with tz data itself. 

Example of how Child project will use this 

```

FROM docker/ubi-java11:1.0.0-SNAPSHOT
ARG JAR_NAME
COPY target/$JAR_NAME app.jar
ENV JAVA_OPTS=" -Djavax.management.builder.initial= -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=3333 -Dcom.sun.management.jmxremote.rmi.port=3333 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.local.only=false -Djava.rmi.server.hostname=127.0.0.1  -XX:+UseContainerSupport"
ENV TZ=Pacific/Auckland
ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar app.jar

```



