FROM sonatype/nexus3

# User root user to install software
USER root

ARG NEXUS_CHANGE_PASSWORD_SCRIPT_URL="https://gist.github.com/making/34e71cb1a56e1280545ade7c9a5032f1/archive/bcedf90963ece53b40106da75666d7dbc1ccfc5a.zip"
ARG NEXUS_SCRIPTING_EXAMPLES_URL="https://github.com/sonatype-nexus-community/nexus-scripting-examples/archive/master.zip"

# Execute system update
RUN yum -y update --disableplugin=subscription-manager && yum clean all

# Install packages necessary to run EAP
RUN yum -y install unzip --disableplugin=subscription-manager \
    && curl -L ${NEXUS_CHANGE_PASSWORD_SCRIPT_URL} --output /tmp/change_password_script.zip \
    && curl -L ${NEXUS_SCRIPTING_EXAMPLES_URL} --output /tmp/master.zip \
    && yum clean all

USER nexus

RUN unzip /tmp/change_password_script.zip -d /tmp 
RUN mv /tmp/34e71cb1a56e1280545ade7c9a5032f1-bcedf90963ece53b40106da75666d7dbc1ccfc5a /tmp/change_password_script

RUN unzip /tmp/master.zip -d /tmp

USER root

RUN rm /tmp/master.zip && rm /tmp/change_password_script.zip

USER nexus

COPY start_nexus.sh /tmp
COPY configure_nexus.sh /tmp

CMD ["sh", "/tmp/start_nexus.sh"]