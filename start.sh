#!/bin/bash

set -e

# allow easier debugging with `docker run -e VERBOSE=yes`
if [[ "$VERBOSE" = "yes" ]]; then
  set -x
fi

# allow easier reset home with `docker run -e RESET_HOME=true`
if [[ "$RESET_HOME" = "true" ]]; then
  echo 'Clearing VIVO HOME /usr/local/vivo/home'
  rm -rf /usr/local/vivo/home/*
fi

# copy home bin if not exists
if [ ! -d /usr/local/vivo/home/bin ]; then
  echo "Copying home bin directory to /usr/local/vivo/home/bin"
  cp -r /vivo-home/bin /usr/local/vivo/home/bin
fi

# copy home config if not exists
if [ ! -d /usr/local/vivo/home/config ]; then
  echo "Copying home config directory to /usr/local/vivo/home/config"
  cp -r /vivo-home/config /usr/local/vivo/home/config
fi

# copy home rdf if not exists
if [ ! -d /usr/local/vivo/home/rdf ]; then
  echo "Copying home rdf directory to /usr/local/vivo/home/rdf"
  cp -r /vivo-home/rdf /usr/local/vivo/home/rdf
fi

# copy runtime.properties if it does not already exist in target home directory
if [ -f /usr/local/vivo/home/config/example.runtime.properties ]; then
  if [ ! -f /usr/local/vivo/home/config/runtime.properties ]
  then
    echo "Copying example.runtime.properties to /usr/local/vivo/home/config/runtime.properties"
    cp /usr/local/vivo/home/config/example.runtime.properties /usr/local/vivo/home/config/runtime.properties

    # template runtime.properties

    echo "Templating runtime.properties vitro.local.solr.url = $SOLR_URL"
    sed -i "s,vitro.local.solr.url = http://localhost:8983/solr/vivocore,vitro.local.solr.url = $SOLR_URL,g" /usr/local/vivo/home/config/runtime.properties

    echo "Templating runtime.properties rootUser.emailAddress = $INITIAL_ROOT_USER_EMAIL"
    sed -i "s,rootUser.emailAddress = vivo_root@mydomain.edu,rootUser.emailAddress = $INITIAL_ROOT_USER_EMAIL,g" /usr/local/vivo/home/config/runtime.properties

    echo "Templating runtime.properties Vitro.defaultNamespace = $DEFAULT_NAMESPACE"
    sed -i "s,Vitro.defaultNamespace = http://vivo.mydomain.edu/individual/,Vitro.defaultNamespace = $DEFAULT_NAMESPACE,g" /usr/local/vivo/home/config/runtime.properties

    echo "Templating runtime.properties selfEditing.idMatchingProperty = $SELF_ID_MATCHING_PROPERTY"
    sed -i "s,selfEditing.idMatchingProperty = http://vivo.mydomain.edu/ns#networkId,selfEditing.idMatchingProperty = $SELF_ID_MATCHING_PROPERTY,g" /usr/local/vivo/home/config/runtime.properties

    if [[ ! -z "${EMAIL_SMTP_HOST}" ]]; then
      echo "Templating runtime.properties email.smtpHost = $EMAIL_SMTP_HOST"
      sed -i "s,  # email.smtpHost = smtp.mydomain.edu,email.smtpHost = $EMAIL_SMTP_HOST,q" /usr/local/vivo/home/config/runtime.properties
    fi
    if [[ ! -z "${EMAIL_PORT}" ]]; then
      echo "Templating runtime.properties email.port = $EMAIL_PORT"
      sed -i "s,  # email.port = 25 or 587,email.port = $EMAIL_PORT,q" /usr/local/vivo/home/config/runtime.properties
    fi
    if [[ ! -z "${EMAIL_USERNAME}" ]]; then
      echo "Templating runtime.properties email.username = $EMAIL_USERNAME"
      sed -i "s,  # email.username = vivtroAdmin@mydomain.edu,email.username = $EMAIL_USERNAME,q" /usr/local/vivo/home/config/runtime.properties
    fi
    if [[ ! -z "${EMAIL_PASSWORD}" ]]; then
      echo "Templating runtime.properties email.password = ***"
      sed -i "s,  # email.password = secret,email.password = $EMAIL_PASSWORD,q" /usr/local/vivo/home/config/runtime.properties
    fi
    if [[ ! -z "${EMAIL_REPLY_TO}" ]]; then
      echo "Templating runtime.properties email.replyTo = $EMAIL_REPLY_TO"
      sed -i "s,  # email.replyTo = vitroAdmin@mydomain.edu,email.replyTo = $EMAIL_REPLY_TO,q" /usr/local/vivo/home/config/runtime.properties
    fi

    if [[ ! -z "${LANGUAGE_FILTER_ENABLED}" ]]; then
      echo "Templating runtime.properties email.replyTo = $LANGUAGE_FILTER_ENABLED"
      sed -i "s,# RDFService.languageFilter = false,RDFService.languageFilter = $LANGUAGE_FILTER_ENABLED,q" /usr/local/vivo/home/config/runtime.properties
    fi
    if [[ ! -z "${FORCE_LOCALE}" ]]; then
      echo "Templating runtime.properties email.replyTo = $FORCE_LOCALE"
      sed -i "s,# languages.forceLocale = en_US,languages.forceLocale = $FORCE_LOCALE,q" /usr/local/vivo/home/config/runtime.properties
    fi
    if [[ ! -z "${SELECTABLE_LOCALES}" ]]; then
      echo "Templating runtime.properties email.replyTo = $SELECTABLE_LOCALES"
      sed -i "s,# languages.selectableLocales = en_US, es_GO,languages.selectableLocales = $SELECTABLE_LOCALES,q" /usr/local/vivo/home/config/runtime.properties
    fi

  else
    # TODO: convert example.runtime.properties into a template file to reconfigure on restart
    # This will only be applicable if not desired to manually edit configuration file. In this case a flag will be required to override.
    echo "Using existing /usr/local/vivo/home/config/runtime.properties"
  fi
fi

# copy applicationSetup.n3 if it does not already exist in target home directory
if [ -f /usr/local/vivo/home/config/example.applicationSetup.n3 ]; then
  if [ ! -f /usr/local/vivo/home/config/applicationSetup.n3 ]
  then
    echo "Copying example.applicationSetup.n3 to /usr/local/vivo/home/config/applicationSetup.n3"
    cp /usr/local/vivo/home/config/example.applicationSetup.n3 /usr/local/vivo/home/config/applicationSetup.n3
  else
    echo "Using existing /usr/local/vivo/home/config/applicationSetup.n3"
  fi
fi

catalina.sh run
