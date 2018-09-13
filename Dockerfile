FROM alpine
WORKDIR /kaeptn
ADD update_service.sh .
ADD portainer_credentials.json .
ADD container_update.json .
RUN chmod +x /kaeptn/update_service.sh
RUN apk add --no-progress --no-cache gettext curl jq sed

ENTRYPOINT /kaeptn/update_service.sh
