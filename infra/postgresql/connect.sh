#! /bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "${SCRIPT_DIR}/../../.env"

echo "Connecting to database..." > ${SCRIPT_DIR}/connect.log

export PGHOST=$(az postgres flexible-server show \
    --resource-group $RESOURCE_GROUP \
    --name $DB_SERVER_NAME \
    --query fullyQualifiedDomainName \
    --output tsv \
    | tr -d '\r')

echo "PGHOST: $PGHOST" >> ${SCRIPT_DIR}/connect.log

export PGPASSWORD="$(az account get-access-token \
    --resource https://ossrdbms-aad.database.windows.net \
    --query accessToken \
    --output tsv)"

echo "PGPASSWORD: $PGPASSWORD" >> ${SCRIPT_DIR}/connect.log

psql "host=$PGHOST dbname=postgres user=azureuser sslmode=require"
