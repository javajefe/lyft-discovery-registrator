# lyft-discovery-registrator
Simple service registrator for Lyft/discovery

Environment variables for Docker container:
* `ENVIRONMENT` - environment (AWS or DOCKER, last one for local run)
* `DISCOVERY_URL` - URL of [Lyft/discovery](https://github.com/lyft/discovery)
* `PROXY_NETWORK_ALIAS` - Docker network alias of container where Envoy is running. Only important for DOCKER environment, then registrator will try to find Envoy's IP
* `PROXY_HOST_PORT` - port of the proxy for ingress traffic
* `SERVICE_NAME` - name of the service
* `REFRESH_INTERVAL` - refresh interval in seconds, default is 10
* `METRICS_PORTS` - comma separated list of ports there metrics could be found, for example `8001,10000`