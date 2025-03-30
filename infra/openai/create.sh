#! /bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "${SCRIPT_DIR}/../../.env"

echo "Creating OpenAI resource..." > ${SCRIPT_DIR}/create.log

az cognitiveservices account create \
    --resource-group $RESOURCE_GROUP \
    --name $OPENAI_RESOURCE_NAME \
    --kind OpenAI \
    --sku S0 \
    --location $LOCATION \
    --yes >> ${SCRIPT_DIR}/create.log

az cognitiveservices account deployment create \
    --resource-group $RESOURCE_GROUP \
    --name $OPENAI_RESOURCE_NAME \
    --deployment-name gpt-4o \
    --model-name gpt-4o \
    --model-version 2024-11-20 \
    --model-format OpenAI \
    --sku-capacity "15" \
    --sku-name GlobalStandard >> ${SCRIPT_DIR}/create.log

az cognitiveservices account deployment create \
    --resource-group $RESOURCE_GROUP \
    --name $OPENAI_RESOURCE_NAME \
    --deployment-name text-embedding-ada-002 \
    --model-name text-embedding-ada-002 \
    --model-version 2 \
    --model-format OpenAI \
    --sku-capacity 120 \
    --sku-name Standard >> ${SCRIPT_DIR}/create.log
