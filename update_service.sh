#!/bin/sh

# Re-export plugin and secret variables
export service_name=$PLUGIN_SERVICE
export new_image=$PLUGIN_IMAGE
export portainer_user=$PORTAINER_USER
export portainer_password=$PORTAINER_PASSWORD

# Authorization
echo "Logging in to portainer API..."

portainer_token=$(envsubst < ./portainer_credentials.json | curl -q -sS -X POST -H 'Content-Type:application/json'\
	"$PORTAINER_HOST/api/auth" -d @- | jq '.jwt' | sed -e 's/\"//g')

[ "$portainer_token" = "null" ] && (echo "Could not login into portainer, check your credentials!"; exit 1)

echo "Getting service info..."

# Get the current service spec
container_info=$(curl -q -sS -X GET "$PORTAINER_HOST/api/endpoints/1/docker/services/$service_name" -H "Authorization:$portainer_token")

current_version=$(echo "$container_info" | jq '.Version.Index')

# Check if getting information was successful
[ "$current_version" = "null" ] && (echo "Could not get version information, is the service name correct?"; exit 1)

echo "Current service version is $current_version"

echo "Updating service..."

export new_image=$new_image
export service_name=$service_name

envsubst < ./container_update.json | curl -q -sS -X POST -H 'Content-Type:application/json' -H "Authorization:$portainer_token"\
	"$PORTAINER_HOST/api/endpoints/1/docker/services/$service_name/update?version=$current_version" -d @-

echo "Done!"
