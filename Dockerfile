FROM python:3.7-buster
MAINTAINER Me <because.it.needs.atleast.1.arg>

VOLUME /config
VOLUME /code

ENV TERM=xterm
ENV PYMSSQL_BUILD_WITH_BUNDLED_FREETDS=1

RUN apt-get update && \ 
apt-get install -y \
cron \
nano

# Install from pip
RUN pip3 install --no-cache-dir --upgrade pymssql mysql-connector google-api-python-client requests arrow

# clean up
RUN apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD startup.sh /startup.sh
RUN chmod +x /startup.sh

CMD [ "./startup.sh"]
