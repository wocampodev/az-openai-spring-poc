#! /bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "${SCRIPT_DIR}/../.env"

export PGHOST=$(az postgres flexible-server show \
    --resource-group $RESOURCE_GROUP \
    --name $DB_SERVER_NAME \
    --query fullyQualifiedDomainName \
    --output tsv \
    | tr -d '\r')

export AZURE_OPENAI_ENDPOINT=$(az cognitiveservices account show \
    --resource-group $RESOURCE_GROUP \
    --name $OPENAI_RESOURCE_NAME \
    --query "properties.endpoint" \
    --output tsv \
    | tr -d '\r')

export AZURE_OPENAI_API_KEY=$(az cognitiveservices account keys list \
    --resource-group $RESOURCE_GROUP \
    --name $OPENAI_RESOURCE_NAME \
    --query "key1" \
    --output tsv \
    | tr -d '\r')

mvn spring-boot:run
