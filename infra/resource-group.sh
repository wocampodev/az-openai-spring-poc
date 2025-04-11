#!/usr/bin/env bash

set -eu

az group create --name $RESOURCE_GROUP --location $LOCATION >> /dev/null

echo "Resource group $RESOURCE_GROUP created successfully."
