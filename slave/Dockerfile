FROM alpine:edge
MAINTAINER For The Record

# Required for private npm packages.
ARG NPM_TOKEN

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# Create Jenkins User
RUN adduser -h /home/jenkins -s /bin/bash -D jenkins \
  && chown -R jenkins /home/jenkins \
  && chgrp -R jenkins /home/jenkins \
  && echo "jenkins    ALL=(ALL)    ALL" >> etc/sudoers

# System packages to install
ENV APK_PACKAGES="\
  musl \
  linux-headers \
  build-base \
  bash \
  git \
  ca-certificates \
  python2 \
  python2-dev \
  py-setuptools \
  nodejs \
  yarn \
  openjdk8=8.121.13-r2 \
  openssh \
  sudo \
"

# Python packages to install
ENV PYTHON_PACKAGES="\
  awscli \
"

# Java version installed
ENV JAVA_VERSION 8u121
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

# Install system packages and perform general setup
RUN apk add --no-cache $APK_PACKAGES \
  # make some useful symlinks that are expected to exist
  && if [[ ! -e /usr/bin/python ]];        then ln -sf /usr/bin/python2.7 /usr/bin/python; fi \
  && if [[ ! -e /usr/bin/python-config ]]; then ln -sf /usr/bin/python2.7-config /usr/bin/python-config; fi \
  && if [[ ! -e /usr/bin/easy_install ]];  then ln -sf /usr/bin/easy_install-2.7 /usr/bin/easy_install; fi \
  && echo \

  # Install and upgrade Pip
  && easy_install pip \
  && pip install --upgrade pip \
  && if [[ ! -e /usr/bin/pip ]]; then ln -sf /usr/bin/pip2.7 /usr/bin/pip; fi \
  && echo \

  # Install python packages
  && pip install $PYTHON_PACKAGES \
  && echo

# Install Java JCE
RUN apk add --no-cache curl unzip \
  && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/unlimited_jce_policy.zip "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip" \
  && unzip -jo -d ${JAVA_HOME}/jre/lib/security /tmp/unlimited_jce_policy.zip \
  && apk del curl unzip \
  && rm -rf /tmp/*

# Add npm authenetication
RUN echo "//registry.npmjs.org/:_authToken=${NPM_TOKEN}" > /home/jenkins/.npmrc

