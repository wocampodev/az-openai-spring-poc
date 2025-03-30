#! /bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "${SCRIPT_DIR}/../../.env"

echo "Creating database..." > ${SCRIPT_DIR}/create.log

export PUBLIC_IP=$(curl -s ipinfo.io/ip)
echo "Public IP: $PUBLIC_IP" >> ${SCRIPT_DIR}/create.log

az postgres flexible-server create \
    --resource-group $RESOURCE_GROUP \
    --name $DB_SERVER_NAME \
    --location $LOCATION \
    --tier Burstable \
    --sku-name standard_b1ms \
    --active-directory-auth enabled \
    --public-access $PUBLIC_IP \
    --version 16 >> ${SCRIPT_DIR}/create.log

az postgres flexible-server firewall-rule create \
    --resource-group $RESOURCE_GROUP \
    --name $DB_SERVER_NAME \
    --rule-name allowiprange \
    --start-ip-address 0.0.0.0 \
    --end-ip-address 255.255.255.255

export USER_OBJECT_ID=$(az ad signed-in-user show --query id --output tsv | tr -d '\r')

az postgres flexible-server ad-admin create \
    --resource-group $RESOURCE_GROUP \
    --server-name $DB_SERVER_NAME \
    --display-name azureuser \
    --object-id $USER_OBJECT_ID

az postgres flexible-server parameter set \
    --resource-group $RESOURCE_GROUP \
    --server-name $DB_SERVER_NAME \
    --name azure.extensions \
    --value vector,hstore,uuid-ossp

echo "Database created successfully" >> ${SCRIPT_DIR}/create.log
