FROM jenkins:alpine
MAINTAINER For The Record

# Jenkins plugins list
ENV JENKINS_PLUGINS="\
aws-credentials:1.19 \
build-timeout:1.18 \
cloud-stats:0.11 \
cloudbees-credentials:3.3 \
docker-plugin:0.16.2 \
github-oauth:0.25 \
github-organization-folder:1.6 \
greenballs:1.15 \
groovy:2.0 \
htmlpublisher:1.12 \
slack:2.2 \
workflow-aggregator:2.5 \
ssh-slaves:1.17 \
timestamper:1.8.8 \
windows-slaves:1.3.1 \
ws-cleanup:0.32 \
"

# Install plugins
RUN install-plugins.sh $JENKINS_PLUGINS

# Grant jenkins access to the local docker socker.
USER root
RUN addgroup -g 50 docker \
  && addgroup jenkins docker
USER jenkins

# Don't run the setup wizard, and disable JNLP checks for now.
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false -Djenkins.slaves.DefaultJnlpSlaveReceiver.disableStrictVerification=true"

