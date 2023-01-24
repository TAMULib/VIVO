ARG BASE_PATH=vivo
ARG USER_ID=3001
ARG USER_NAME=vivo
ARG HOME_DIR=/$USER_NAME

FROM maven:3-eclipse-temurin-11 as maven
ARG BASE_PATH
ARG USER_ID
ARG USER_NAME
ARG HOME_DIR

ARG VITRO_BRANCH=i18n-redesign
ARG VIVO_BRANCH=i18n-redesign

ARG SETTINGS_PATH=installer/example-settings.xml

RUN \
  apt upgrade -y && \
  apt update -y && \
  apt install git -y

RUN \
  addgroup --gid $USER_ID $USER_NAME && \
  adduser --disabled-password --home $HOME_DIR --uid $USER_ID --gid $USER_ID $USER_NAME

USER $USER_NAME

WORKDIR $HOME_DIR

RUN \
  git clone --branch $VITRO_BRANCH https://github.com/vivo-project/Vitro.git && \
  git clone --branch $VIVO_BRANCH https://github.com/vivo-project/VIVO.git

WORKDIR $HOME_DIR/VIVO

RUN mvn clean package -s $SETTINGS_PATH


FROM tomcat:9-jdk11-temurin
ARG BASE_PATH
ARG USER_ID
ARG USER_NAME
ARG HOME_DIR

ARG SOLR_URL=http://localhost:8983/solr/vivocore
ARG VIVO_DIR=/usr/local/vivo/home
ARG TDB_FILE_MODE=direct

ENV JAVA_OPTS="${JAVA_OPTS} -Dtdb:fileMode=$TDB_FILE_MODE"
ENV SOLR_URL=${SOLR_URL}

RUN \
  apt-get update -y && \
  apt-get upgrade -y

RUN \
  addgroup --gid $USER_ID $USER_NAME && \
  adduser --disabled-password --home $HOME_DIR --uid $USER_ID --gid $USER_ID $USER_NAME

RUN \
  mkdir /usr/local/vivo && \
  mkdir /usr/local/vivo/home && \
  chown -R $USER_ID:$USER_ID /usr/local/vivo /usr/local/tomcat

USER $USER_NAME

COPY --from=maven $HOME_DIR/VIVO/installer/home/target/vivo /vivo-home
COPY --from=maven $HOME_DIR/VIVO/installer/webapp/target/vivo.war /usr/local/tomcat/webapps/$BASE_PATH.war

COPY start.sh /start.sh

EXPOSE 8080

CMD ["/bin/bash", "/start.sh"]
