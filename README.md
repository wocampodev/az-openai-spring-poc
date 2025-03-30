# Azure Open AI with Spring POC

> **Note:** If your Azure subscription does not have PostgreSQL provider registered, you will need to execute the following command:

```bash
az provider register --namespace Microsoft.DbforPostgreSQL
az provider register --namespace Microsoft.CognitiveServices # Optional for Azure OpenAI
```

## API Endpoints

### RAG (Retrieval Augmented Generation) Endpoints

#### Query about pgvector

This endpoint queries the RAG system about pgvector, which is a PostgreSQL extension for vector similarity search.

```bash
curl -G "http://localhost:8080/api/rag" \
    --data-urlencode "query=What is pgvector?"
```

#### Query about Spring AI's QuestionAnswerAdvisor

This endpoint queries the RAG system about how the QuestionAnswerAdvisor works in Spring AI, which is a component that helps in processing and answering questions using AI.

```bash
    curl -G "http://localhost:8080/api/rag" \
        --data-urlencode "query=How does QuestionAnswerAdvisor work in Spring AI?"
```

### Blog Endpoint

#### Query Blog Posts by Topic

This endpoint retrieves blog posts related to a specific topic. In this example, it queries for posts about Java on Azure.

```bash
curl --request GET \
    --url 'http://localhost:8080/api/blog?topic=Java%2520on%2520Azure' | jq
```
