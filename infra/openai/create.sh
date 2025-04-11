#!/usr/bin/env bash

set -eu

az cognitiveservices account create \
    --resource-group $RESOURCE_GROUP \
    --name $OPENAI_RESOURCE_NAME \
    --kind OpenAI \
    --sku S0 \
    --location $LOCATION \
    --yes >> /dev/null

az cognitiveservices account deployment create \
    --resource-group $RESOURCE_GROUP \
    --name $OPENAI_RESOURCE_NAME \
    --deployment-name gpt-4o \
    --model-name gpt-4o \
    --model-version 2024-11-20 \
    --model-format OpenAI \
    --sku-capacity "15" \
    --sku-name GlobalStandard >> /dev/null

az cognitiveservices account deployment create \
    --resource-group $RESOURCE_GROUP \
    --name $OPENAI_RESOURCE_NAME \
    --deployment-name text-embedding-ada-002 \
    --model-name text-embedding-ada-002 \
    --model-version 2 \
    --model-format OpenAI \
    --sku-capacity 120 \
    --sku-name Standard >> /dev/null

echo "OpenAI resource $OPENAI_RESOURCE_NAME created successfully."
