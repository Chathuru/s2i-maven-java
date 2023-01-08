## Description

This container image includes Java 8, Mavan 3.6.3 and Tomcat 8.5.54 as a [S2I](https://github.com/openshift/source-to-image) base image for your Java 8 applications. This image is based on [centos/s2i-base-centos7](https://hub.docker.com/r/centos/s2i-base-centos7). This image can be used to build and run *.java and *.war

## Usage

To build a simple [maven-web-project](https://github.com/Chathuru/maven-web-project) webapp using standalone [S2I](https://github.com/openshift/source-to-image) and then run the resulting image with Docker execute:

```
$ s2i build https://github.com/Chathuru/maven-web-project.git chathuru/s2i-maven-java hellow-java
$ docker run -p 8080:8080 hellow-java
```

## Environment variables

| Name | Default | Description |
|------|---------|-------------|
| `MVN_GOALS` | `clean package` | Maven goals to execute |
| `MVN_SKIP_TESTS`     | `true`        | If tests should be skipped            |
| `MVN_OPTS`     | `None`        | Additional options handed to Maven            |

For Information about how those vars can be configured see the [official docs on Build Strategy Options](https://docs.openshift.com/container-platform/3.11/dev_guide/builds/build_environment.html)

