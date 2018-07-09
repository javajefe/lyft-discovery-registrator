FROM alpine:3.7
ADD . /

RUN apk -U add gettext curl bash bind-tools; \
	chmod +x /register.sh

ENV ENVIRONMENT=AWS \
	DISCOVERY_URL= \
	PROXY_NETWORK_ALIAS= \
	PROXY_HOST_PORT= \
	SERVICE_NAME= \
	REFRESH_INTERVAL=10 \
	METRICS_PORTS=
CMD bash /register.sh