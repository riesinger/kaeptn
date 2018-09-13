# kaeptn

Drone plugin for updating a service's image via the Portainer API

## Usage

Execute from the working directory:

```
	docker run --rm \
		-e PLUGIN_SERVICE=<full name of the service> \
		-e PLUGIN_IMAGENAME=<new image with tag> \
		-e PORTAINER_USER=<portainer API username> \
		-e PORTAINER_PASSWORD=<hopefullyNot123456> \
		-e PORTAINER_HOST=<URL to your portainer instance> \
		riesinger/kaeptn
```

This plugin is tailored for a very specific use-case and therefore probably isn't of much use to you.
