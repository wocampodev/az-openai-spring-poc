#!/usr/bin/env bash

set -eu

export PUBLIC_IP=$(curl -s ipinfo.io/ip)

az postgres flexible-server create \
    --resource-group $RESOURCE_GROUP \
    --name $DB_SERVER_NAME \
    --location $LOCATION \
    --tier Burstable \
    --sku-name standard_b1ms \
    --active-directory-auth enabled \
    --public-access $PUBLIC_IP \
    --version 16 >> /dev/null

az postgres flexible-server firewall-rule create \
    --resource-group $RESOURCE_GROUP \
    --name $DB_SERVER_NAME \
    --rule-name allowiprange \
    --start-ip-address 0.0.0.0 \
    --end-ip-address 255.255.255.255 >> /dev/null

export USER_OBJECT_ID=$(az ad signed-in-user show --query id --output tsv | tr -d '\r')

az postgres flexible-server ad-admin create \
    --resource-group $RESOURCE_GROUP \
    --server-name $DB_SERVER_NAME \
    --display-name azureuser \
    --object-id $USER_OBJECT_ID >> /dev/null

az postgres flexible-server parameter set \
    --resource-group $RESOURCE_GROUP \
    --server-name $DB_SERVER_NAME \
    --name azure.extensions \
    --value vector,hstore,uuid-ossp >> /dev/null

echo "PostgreSQL server $DB_SERVER_NAME created successfully."
echo "PostgreSQL server public IP: $PUBLIC_IP"
