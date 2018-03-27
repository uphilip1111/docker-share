FROM ubuntu:16.04

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
	apt-get update && \
	apt-get upgrade -y

RUN apt-get install -y -f supervisor && \
	mkdir -p /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
