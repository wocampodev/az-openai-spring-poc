/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dev.wocampo.springaiapp.service;

import java.util.List;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.document.Document;
import org.springframework.ai.vectorstore.SearchRequest;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.stereotype.Service;

/**
 *
 * @author wocampodev
 */
@Service
public class RagService {

    private static final Logger logger = LoggerFactory.getLogger(RagService.class);

    private final ChatClient chatClient;
    private final VectorStore vectorStore;

    public RagService(ChatClient.Builder chatClientBuilder, VectorStore vectorStore) {
        this.chatClient = chatClientBuilder.build();
        this.vectorStore = vectorStore;
    }

    public String processQuery(String query) {
        List<Document> similarContexts = vectorStore.similaritySearch(
                SearchRequest.builder()
                        .query(query)
                        .similarityThreshold(0.8)
                        .topK(3)
                        .build()
        );

        String context = similarContexts.stream()
                .map(ch -> String.format("Q: %s\nA: %s", ch.getMetadata().get("prompt"), ch.getText()))
                .collect(Collectors.joining("\n\n"));

        logger.debug("Found {} similar contexts", similarContexts.size());

        String promptText = String.format("""
            Use these previous Q&A pairs as context for answering the new question:

            Previous interactions:
            %s

            New question: %s

            Please provide a clear and educational response.""",
                context,
                query
        );

        return this.chatClient.prompt()
                .user(promptText)
                .call()
                .content();
    }

}
