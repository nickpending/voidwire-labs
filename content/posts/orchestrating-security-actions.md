---
title: "Orchestrating Security Actions"
date: 2025-05-02
categories: [ai, security]
tags: ["ai", "security", "prompt-engineering", "tools", "vulnerability-management"]
draft: false
description: "The Pragmatic Value of LLM Agents"
---

#

[](https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fcd025f22-28e7-4078-be04-c957f1c1deda_1536x1024.png)*This is Part 2 in a two-part series. [Read Part 1: Bridging the Cognitive Gap](https://claude.ai/chat/bd9b5023-613d-4598-8788-6fc7039efec3#)*

## Introduction

LLMs don't reason. They don't intuit. They don't understand risk or strategy. But they are changing how work gets done — fast. From summarizing alerts, drafting recon reports, or reverse engineering malware with tools like [GhidraMCP](https://github.com/LaurieWired/GhidraMCP), these agents are delivering value in surprising places.

## Connected Workflows: Beyond Single-Tool Interaction

The most promising developments come from connecting these tools into seamless workflows. Projects like [NERVE](https://github.com/evilsocket/nerve)demonstrate the power of LLM-coordinated security tools, where a natural language request triggers multiple tools in sequence without requiring manual intervention at each step.

This isn't just about convenience—it fundamentally changes how security professionals approach problems:

1. **Natural language orchestration** - Express your intent in plain English, and let the LLM figure out which tools to use and how to chain them together.

2. **Between-step analysis** - The LLM doesn't just pass data between tools; it analyzes outputs to determine next steps, highlighting anomalies and suggesting pivots.

3. **Consolidated outputs** - Instead of managing multiple terminal windows and log files, receive a single, coherent analysis that integrates findings across tools.

The efficiency gains are striking. What once required writing custom scripts and manually correlating outputs now becomes a conversation: "Find all exposed services for this domain and identify potential vulnerabilities." The LLM handles the tool selection, execution, and initial analysis, allowing you to focus on strategic decisions.

## Where to Build Next

If you're experimenting with agents, start with bounded problems:

- Toolchain bridges: DNS → IP → ASN → enrich → format

- Evidence collectors: extract headers, fingerprint tech stacks, format

- Reporting assistants: summarize vendor advisories or CVE disclosures

- Agent wrappers: give `nuclei`, `curl`, or `dig` a natural language shell

These are narrow, fast, and safe enough to scale — while revealing exactly where reasoning fails.

For those ready to explore more advanced implementations, consider:

- **Cross-tool orchestration** - Build MCP integrations that work together, allowing LLMs to coordinate multiple security tools for comprehensive analysis

- **Analysts-in-the-loop designs** - Develop workflows where the LLM handles routine processing but explicitly requests human guidance for strategic decisions

- **Specialized security agents** - Create purpose-built agents for specific security domains like web application testing or threat hunting, with tailored prompts and tool integrations

## The Evolving Landscape

Looking ahead, we'll see these tools evolve in several key directions:

1. **Idea to implementation acceleration** - The time between conceiving a security solution and deploying it will shrink dramatically. What once took weeks of coding and debugging can now happen in hours as LLMs help transform concepts directly into working code and MCP implementations.

2. **Shortened decision cycles** - As automation handles more routine analysis, human experts will make faster decisions based on better-contextualized information. This won't just save time—it will fundamentally change how security teams operate.

3. **Hacker-strategist evolution** - As I've written previously, security professionals will increasingly combine deep technical knowledge with strategic thinking. These hybrid practitioners will orchestrate AI systems while maintaining the adversarial creativity that remains uniquely human. They won't just use AI tools—they'll design workflows where these tools amplify security expertise.

4. **Dynamic knowledge management** - Security knowledge systems will rely on adaptive, AI-enhanced methods like Retrieval-Augmented Generation (RAG) to maintain up-to-date, contextual understanding of threats and defenses, redefining traditional threat intelligence practices.

The organizations that thrive won't be those with the most advanced AI—they'll be those who best integrate these tools into workflows that amplify human judgment rather than replacing it.

## Unifying Company Context: Breaking Down Silos

For these AI-driven approaches to reach their full potential, organizations must break down the data silos that currently plague security operations. As I've noted elsewhere, "data trapped in silos hurts us" and limits our ability to outmaneuver adversaries.

Developing what Daniel Miessler has termed Unified Company Context (UCC) ensures that AI models operate with comprehensive, real-time context across traditionally isolated domains—from asset inventory to vulnerability management to threat intelligence. This democratized access to integrated organizational data empowers rapid, accurate decisions that wouldn't be possible with fragmented information.

*(Hat tip to Daniel Miessler for inspiring the UCC concept.)*

## Conclusion: Useful Doesn't Mean Smart

LLMs don't understand. They don't judge. They don't reflect. But they can still make real work easier. They offload repetition. They surface signal. They compress time.

And that's why they win.

In security, this won't replace strategy. But it can free up attention. It can let experts focus on risk and design while the machine handles the drudge work. That's not cognition — but it's leverage.

The future isn't about smarter models. It's about better systems — ones that scaffold expert reasoning around simple agents.

Because pragmatic agents can't think — but with the right structure, they can still follow those who do.

### Further Reading

- [Bridging the Cognitive Gap: Why LLMs Still Don't Think Like Security Experts](https://claude.ai/chat/bd9b5023-613d-4598-8788-6fc7039efec3#)

- [A Framework for Evaluating Emerging Cyberattack Capabilities of AI (arXiv:2503.11917)](https://arxiv.org/abs/2503.11917)

- [Crimson: Empowering Strategic Reasoning in Cybersecurity through Large Language Models (arXiv:2403.00878)](https://arxiv.org/abs/2403.00878)

- [What Does It Mean for AI to 'Understand'? – Gary Marcus](https://garymarcus.substack.com/p/what-does-it-mean-for-ai-to-understand)

- [Why LLMs Are Not Ideal (Alone) for Agents](https://medium.com/@ap3617180/why-llms-are-not-ideal-alone-for-ai-agents-7532e6e394f2)

- [Architecting Security's Future: Why Hacker-Strategists Will Lead the AI Evolution](https://claude.ai/chat/bd9b5023-613d-4598-8788-6fc7039efec3#)

- [Prompt Engineering in Cybersecurity](https://claude.ai/chat/bd9b5023-613d-4598-8788-6fc7039efec3#)

- [GhidraMCP: Reverse Engineering with Claude](https://github.com/LaurieWired/GhidraMCP)