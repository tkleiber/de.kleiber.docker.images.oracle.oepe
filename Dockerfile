FROM localhost:5000/oracle/serverjre:8
MAINTAINER torsten.kleiber@web.de
ARG SW_FILE
USER root
ADD $SW_FILE /tmp/
RUN yum -y install xterm xauth libXtst unzip
RUN unzip /tmp/$SW_FILE -d /opt/oepe
RUN rm -f /tmp/$SW_FILE
ENV JAVA_HOME=/usr/java/default
RUN ls -la /opt/oepe
USER oracle
CMD /opt/oepe/eclipse -clean -clearPersistedState
