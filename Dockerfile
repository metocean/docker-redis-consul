FROM redis as builder

RUN apt-get update
RUN apt-get install -y curl unzip make gcc

# install consul agent
ENV CONSUL_VERSION=1.0.7
RUN cd /tmp &&\
    curl -o consul.zip -L https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip &&\
    unzip consul.zip &&\
    chmod +x consul &&\
    mv consul /usr/bin

# install consul-init
ENV CONSUL_INIT_VERSION=0.0.8
RUN echo "----------------- install consul-init -----------------" &&\
    cd /tmp &&\
    curl -o consul-init.tar.gz -L https://github.com/metocean/docker-consul-init/archive/v${CONSUL_INIT_VERSION}.tar.gz &&\
    tar -vxf consul-init.tar.gz &&\
    cd /tmp/docker-consul-init-${CONSUL_INIT_VERSION}/consul-init &&\
    make &&\
    cp consul-init /usr/bin/

FROM redis
COPY --from=builder /usr/bin/consul /usr/bin/
COPY --from=builder /usr/bin/consul-init /usr/bin/
RUN mkdir -p /consul/data

ENTRYPOINT ["consul-init", "--program", "redis-server"]
