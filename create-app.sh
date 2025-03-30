#! /bin/bash

set -e

curl https://start.spring.io/starter.zip \
    -d groupId=dev.wocampo \
    -d artifactId=spring-ai-app \
    -d name=spring-ai-app \
    -d description="Spring AI Azure Integration" \
    -d version=0.0.1-SNAPSHOT \
    -d bootVersion=3.4.3 \
    -d javaVersion=21 \
    -d dependencies=web,jdbc,azure-support,spring-ai-azure-openai,spring-ai-vectordb-pgvector \
    -d type=maven-project \
    -d packageName=dev.wocampo.springaiapp \
    --output app.zip

unzip app.zip -d app
rm app.zip
