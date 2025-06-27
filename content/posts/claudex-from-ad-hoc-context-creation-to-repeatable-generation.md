---
title: "Claudex: From Ad-Hoc Context Creation to Repeatable Generation"
date: 2025-06-27
categories: [ai, development]
tags: ["ai", "development", "claude", "workflow", "context"]
draft: false
description: "Building on the three-layer memory system to eliminate the constant re-explaining of development preferences."
---

## TL;DR

- **Context creation was still ad-hoc** even with the three-layer memory system in place. Every new language meant manually crafting another CLAUDE.local.md file and repeating the same research process.

- **The research process was repeatable.** Looking at what made my Python context effective, I noticed the same pattern: current tools, common mistakes, workflow problems. The structure was consistent across languages.

- **Prompt template generates research-backed contexts.** Feed it "python" or "golang" and get comprehensive development contexts through 12-15 targeted searches of authoritative sources.

- **Claudex repository demonstrates the approach.** Contains the prompt template plus generated examples for multiple languages. It's the process and outputs, not automation.

- **Process over automation.** The template guides research and ensures quality standards rather than just generating content. Repeatable thinking, not mindless generation.

## Beyond Memory Optimization

In my previous piece on [Claude Code memory optimization](https://labs.voidwire.info/posts/claude-code-memory-optimization/), I explored how to structure AI context across three layers: global principles, language-specific preferences, and project context. The system works - it eliminates token waste and creates consistent AI interactions. But implementing it revealed a remaining friction point: creating those language-specific context files was still ad-hoc.

Every time I worked in a new language or framework, I'd find myself manually crafting another CLAUDE.local.md file. The constant re-explaining of tool preferences, deprecated libraries, and workflow patterns. Even with the memory system in place, building quality context for each new domain meant starting from scratch.

That's when I realized the real problem wasn't just context management - it was context generation.

## What I Figured Out

Looking at what made my Python CLAUDE.local.md work, I noticed it wasn't just personal preferences - it was research into current tools, common mistakes, and workflow problems. The file worked because it addressed real friction with specific solutions.

But that research process was repeatable. The structure was consistent. The types of problems were similar across languages - just with different tools and patterns.

What if I could make the context generation itself repeatable?

## A Research Template

The solution became a prompt template that transforms "python" or "golang" into comprehensive, research-backed development contexts. Not automation - just a repeatable process that keeps the research quality while making it consistent.

The template guides Claude through 12-15 targeted searches covering:
- Current official versions and release status
- Production failures and common setup mistakes  
- Daily workflow problems and debugging time-wasters
- Professional toolchain standards and expert patterns
- Security vulnerabilities and banned practices

Each search targets authoritative sources - official docs, engineering blogs, real debugging experiences. The output follows a consistent structure with critical sections, tool recommendations, and specific workflow guidance.

## What This Produces

Rather than generic advice, the method generates opinionated, workflow-focused contexts. Here's what emerges from feeding "python" through the template:

Critical sections that prevent time-wasting mistakes. Current tool recommendations with version numbers. Specific command patterns and workflow integration. Banned legacy libraries with migration paths.

The key thing: this isn't documentation generation - it's compressed expertise creation. Each generated context captures the patterns an experienced developer carries as intuitive knowledge, formatted for AI consumption.

## The Claudex Repository

I'm putting this approach into practice with [claudex](https://github.com/nickpending/claudex). The repository contains the prompt template and generated examples for multiple languages - showing the process and what it produces, not how to automate it.

A couple of friends have pointed out that I probably spend more time building guardrails than actually building apps. They're not wrong. But in this case, the investment seems worth it. The constant re-explaining was genuine friction, and having a repeatable way to generate quality contexts feels like building a well-oiled machine rather than just more overhead.

The repo contains:
- The prompt template  
- Generated examples for different languages
- Basic documentation on using the template

Think of it as both a practical tool and an experiment in AI context design. The template becomes a process others can use, while the generated examples show the quality and structure possible.

## Process Over Automation

What I find interesting about this approach is that it prioritizes thoughtful process over automation. The template doesn't just generate content - it guides research, ensures current information, and applies consistent quality standards.

This connects to broader questions about how we structure knowledge for AI systems. Rather than feeding them everything we know, we're learning to compress expertise into focused, actionable guidance that survives across conversations.

## Where This Goes

The claudex approach opens up some interesting possibilities. Generate contexts for specialized domains - security testing, data science workflows, embedded development. Team-specific variants that encode organizational patterns and standards.

But the real value might be in the process itself. Moving from ad-hoc context creation to repeatable research patterns that produce consistently useful results.

The constant re-explaining never fully goes away - technology evolves, tools change, new patterns emerge. But having a repeatable approach to capturing and structuring that knowledge makes the process more intentional and the results more valuable.

The template becomes a way to think more deliberately about what makes AI context effective, not just for individual workflows but for the broader challenge of human-AI collaboration in technical domains.

*This builds on the memory optimization work by making the creation of the language-specific layer repeatable. Next: exploring how teams can adapt this approach for organizational knowledge sharing.*