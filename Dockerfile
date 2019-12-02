FROM python:3.8-buster
MAINTAINER Me <because.it.needs.atleast.1.arg>

VOLUME /config
VOLUME /code

ENV TERM=xterm

RUN apt update && \ 
apt install -y \
cron \
nano \
unixodbc-dev

RUN sudo su && \
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
exit && \
sudo apt update && \
sudo ACCEPT_EULA=Y apt -y install msodbcsql17

# Install from pip
RUN pip3 install --no-cache-dir --upgrade mysql-connector google-api-python-client requests arrow pyodbc

# clean up
RUN apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD startup.sh /startup.sh
RUN chmod +x /startup.sh

CMD [ "./startup.sh"]
