FROM ubuntu
ADD setup-ubuntu.sh /setup.sh
RUN /setup.sh

ADD cloner.sh /cloner.sh
RUN /cloner.sh

ADD profile /root/.profile
