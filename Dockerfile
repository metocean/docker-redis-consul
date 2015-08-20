FROM redis
MAINTAINER Thomas Coats <t.coats@metocean.co.nz>

ADD https://dl.bintray.com/mitchellh/consul/0.5.2_linux_amd64.zip /tmp/consul.zip
ADD . /install/
RUN /install/install.sh
ENV GOMAXPROCS=2
CMD ["/sbin/initsh"]