#! /bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "${SCRIPT_DIR}/../.env"

echo "Creating resource group..." > ${SCRIPT_DIR}/resource-group.log

az group create --name $RESOURCE_GROUP --location $LOCATION

echo "Resource group created" >> ${SCRIPT_DIR}/resource-group.log
