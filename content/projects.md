---
title: "Projects"
date: 2025-01-08
draft: false
---

Breaking things to build better things. Here's what I'm working on:

## Prismis

![Prismis Interface](/images/prismis-screenshot.png)

Content aggregation system that extracts signal from noise. Takes RSS feeds and Reddit sources, runs full article extraction, then analyzes everything against personal context to rank what actually matters.

The system solves the problem of information overload - I was drowning in security blogs, research papers, and discussion threads. Instead of more filtering, Prismis uses AI to understand context and surface content based on what I'm actually working on.

Three components: ingest CLI for processing content, web UI for interaction, webhook service for real-time updates. Built to run continuously and learn from engagement patterns.

[→ prismis.io](https://www.prismis.io)

---

## Claudex-Guard

Automated code quality enforcement for AI-assisted development. Enforces coding standards in real-time during Claude Code sessions instead of repeatedly explaining preferences.

Integrates with Claude Code hooks to automatically check Python files for security issues, performance problems, and modern Python usage. When violations are found, it blocks the tool and teaches Claude your coding standards through detailed violation reports.

Features AST analysis, automatic fixes via ruff/mypy integration, and a global reminder system. Built with modular architecture ready for JavaScript/TypeScript/Rust support.

[→ claudex-guard](https://github.com/nickpending/claudex-guard)

---

## Arsenl

Security tool intelligence engine. Takes the chaos of command-line security tools and transforms them into validated, searchable command catalogs.

LLMs consistently generate wrong syntax for security tools. This isn't a model problem - it's a knowledge problem. Arsenl builds validated command references through automated testing pipelines, then makes them searchable through semantic matching.

Four-tool composition: prompt generation, validation pipeline, enrichment analysis, searchable storage. Each tool handles one concern, connects through JSON contracts.

[→ arsenl](https://github.com/nickpending/arsenl) (repo created - project data coming soon)

---

## ASH (Attack Surface Hunter)

Docker-based autonomous reconnaissance agent that uses Claude Code to orchestrate security tools for intelligent attack surface discovery and professional intelligence generation.

ASH operates in a container with pre-installed tools like dnsx, httpx, katana, naabu, and ffuf. Claude Code acts as the orchestrator, making contextual decisions about tool usage and generating executive-ready markdown dossiers rather than raw tool dumps.

Supports interactive mode for manual reconnaissance and automation mode for batch processing. Takes target lists from mounted feeds directory and outputs professional intelligence reports.

[→ ash](https://github.com/nickpending/ash) (repo created - project data coming soon)

---

I build these because they solve problems I actually have. Each one addresses specific friction points in security work and AI-assisted development. They're designed to work together when useful, but each handles its own thing.
