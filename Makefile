ENV_FILE=.env

include $(ENV_FILE)
export $(shell sed 's/=.*//' $(ENV_FILE))

provision-infra:
	bash ./infra/resource-group.sh
	bash ./infra/postgresql/create.sh
	bash ./infra/openai/create.sh

start-app:
	cd ./app && bash start.sh

.PHONY: provision-infra start-app
