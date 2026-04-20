# agents-observability-tt202

- **URL:** https://github.com/dsanchor/agents-observability-tt202
- **Owner:** dsanchor
- **Language:** Python
- **Stars:** —
- **Date Added:** 2026-04-20
- **Category:** Agent Frameworks & Design

## Summary

agents-observability-tt202 is the companion repository for a TechTalk session delivered at Tech Connect 2026, covering end-to-end observability for multi-agent systems built with the Microsoft Agent Framework (MAF) and OpenTelemetry. It walks through a real-world fraud detection scenario in which three specialized agents (CustomerDataAgent, RiskAnalyserAgent, FraudAlertAgent) are orchestrated sequentially, instrumented with a 3-tier telemetry framework (spans, business metrics, custom events), and monitored through Azure Application Insights, Grafana, and Power BI dashboards. The repo is structured as a two-track workshop: "From Zero to Hero" for building and publishing Foundry Agents v2, and "Production-Ready Observability" for deploying containerized agents with full tracing.

## Key Features

- Step-by-step workshop covering MAF Agents v2 creation, local orchestration via the Microsoft Foundry VS Code extension playground, and hosted deployment on Azure Foundry
- 3-tier OpenTelemetry instrumentation framework: distributed spans/traces, business metrics, and custom events that work identically locally and in Azure Container Apps
- Pre-built Azure Application Insights workbooks and Power BI dashboard templates for real-time technical and business-level monitoring
- Devcontainer / GitHub Codespaces support for a zero-friction setup alongside infrastructure-as-code scripts for Azure AI Services, Cosmos DB, AI Search, and App Insights

## Relevance to AI-Driven Development

This repository provides a concrete, production-grade blueprint for making multi-agent AI systems observable and auditable, an essential requirement before shipping agentic workflows to production. It bridges the gap between developer-facing distributed tracing and executive-level KPI dashboards, making it directly applicable to any team running MAF-based agents on Azure.
