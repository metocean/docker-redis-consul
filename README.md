# Redis Consul
Redis with Consul

`docker pull metocean/redis-consul`

Overmount the following files and folders to customise:
- `/consul/redis.json` - The Redis [consul service definition file](https://www.consul.io/docs/agent/services.html). Mount an alternate to change the service registered with consul, e.g. change the service name or add tags.
- `/etc/redis.conf` - [Redis's configuration file](http://download.redis.io/redis-stable/redis.conf). Change how Redis runs.
- `/data` - Where Redis stores it's data. Mount this from host for persistence.
