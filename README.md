# Azure Open AI with Spring POC

> [!NOTE]
> If your Azure subscription does not have PostgreSQL provider and Azure Cognitive AI Services registered, you will need to execute the following command:

```bash
az provider register --namespace Microsoft.DbforPostgreSQL
az provider register --namespace Microsoft.CognitiveServices
```

## Environment Configuration

To set up the environment variables for the project, rename the `.env.local` file to `.env` and populate the required values. The `.env` file is used to configure the application with necessary resource details such as resource group, location, database server name, and others.

## Using the Makefile

The Makefile provides commands to provision infrastructure and start the application. Below are the available commands:

- **Provision Infrastructure**: This command sets up the required Azure resources, including PostgreSQL and OpenAI services.

  ```bash
  make provision-infra
  ```

- **Start the Application**: This command starts the Spring Boot application.

  ```bash
  make start-app
  ```

## API Endpoints

### Query about pgvector

This endpoint queries the RAG system about pgvector, which is a PostgreSQL extension for vector similarity search.

```bash
curl -G "http://localhost:8080/api/rag" \
    --data-urlencode "query=What is pgvector?"
```

![rag-example](./examples/rag.png)

### Query about Spring AI's QuestionAnswerAdvisor

This endpoint queries the RAG system about how the QuestionAnswerAdvisor works in Spring AI, which is a component that helps in processing and answering questions using AI.

```bash
curl -G "http://localhost:8080/api/rag" \
    --data-urlencode "query=How does QuestionAnswerAdvisor work in Spring AI?"
```

### Query Blog Posts by Topic

This endpoint retrieves blog posts related to a specific topic. In this example, it queries for posts about Java on Azure.

```bash
curl --request GET \
    --url 'http://localhost:8080/api/blog?topic=Java%2520on%2520Azure' | jq
```
