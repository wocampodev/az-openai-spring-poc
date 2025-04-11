#!/usr/bin/env bash

set -eu

script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "${script_dir}/../../.env"

export PGHOST=$(az postgres flexible-server show \
    --resource-group $RESOURCE_GROUP \
    --name $DB_SERVER_NAME \
    --query fullyQualifiedDomainName \
    --output tsv \
    | tr -d '\r')

export PGPASSWORD="$(az account get-access-token \
    --resource https://ossrdbms-aad.database.windows.net \
    --query accessToken \
    --output tsv)"

psql "host=$PGHOST dbname=postgres user=azureuser sslmode=require"
