#! /bin/bash

set -e

./infra/resource-group.sh
./infra/postgresql/create.sh
./infra/openai/create.sh
