---
title: "Don't Let LLMs Run the Show"
date: 2025-07-18
categories: [ai, development]
tags: ["ai", "development", "llm-limitations", "claude-code", "determinism"]
draft: false
description: "Why LLMs excel at building software but struggle when put in control of runtime decisions and execution flow."
---

There's a pattern I keep observing with LLMs. They can help you write Python scripts, React components, automation tools, even complex codebases like my [Prismis](https://www.prismis.io) project. They can be embedded in that final software when you design for their nature—tolerance for variability, rigorous structural constraints, interactive oversight.

But put them in control of runtime decisions, execution flow, or consistent orchestration, and you'll often watch them vary in ways that can seem almost willful. This isn't a limitation to overcome. It's the fundamental nature of these systems, and understanding it changes how we should think about building with AI.

## The Force Multiplier

LLMs can dominate at building software. I'm building multiple projects concurrently with [Claude Code](https://labs.voidwire.info/posts/how-i-made-claude-code-actually-ship-software-a-systematic-workflow-that-works/). They make mistakes sometimes, but this represents a force multiplier unlike anything we've seen—when you do it right. LLMs can help you build, configure, and create whatever you need to get there.

But here's the deal: LLMs are just not good at running software that requires predictable outcomes. Much of what we're trying to do with LLMs can be done with existing tools that already work well. Those tools can be augmented with LLMs where it makes sense—but don't let the LLM run the show.

## Why Determinism Breaks Everything

I've seen this pattern repeated endlessly. You can prompt engineer all you want—you will often get different results across runs. It's how LLMs work. They're probabilistic systems at their core, generating outputs based on learned patterns and statistical distributions.

This is why they struggle when put in control of anything that needs reliable execution. When you build a system that depends on an LLM making the same choices repeatedly, you're building on sand. The variation isn't a bug; it's the architecture.

## Where They Shine, Where They Don't

LLMs are great at synthesis, analysis, editing, grunt work. Content work where variability is valuable. You want different responses when summarizing content or generating dialogue. They do solve medical and research problems that humans haven't or couldn't—that's genuinely impressive.

Tool use is convenient for ad hoc queries where you're in the loop to catch mistakes. But trying to build reliable automation expecting predictable execution without guardrails? As I explored in ["The Architecture of Laziness"](https://labs.voidwire.info/posts/the-architecture-of-laziness-why-llms-are-fundamentally-designed-to-cut-corners/), the research suggests real-world agents can miss-fire closer to 20% of the time.

Consider MCP: it can fail when you wire it into automated workflows because you can't always predict which server or tool the LLM will choose. But for interactive use—where you're actively guiding the process—it works fine. The difference is having someone there to catch the variations.

## The Architectural Mismatch

LLMs can and should be embedded in regular software, but in the right places. They work when you need intelligence applied to specific problems—pattern recognition, content generation, analysis. They can work in production systems when you design for their nature: tolerance for variability or very rigorous structural constraints.

The pattern I've observed: you can have an LLM perform analysis work and place the results in a template. The template structure remains consistent—LLMs are remarkably good at following formatting patterns. But the analysis itself will vary. The structural execution stays deterministic while the creative work introduces variability.

This isn't about tool use specifically. It's about understanding where LLMs can be reliable and where they can't. When you need them to make consistent choices across runs, you're working against their fundamental nature.

## What I've Done

I use them to build tools, games, automations, editing scripts for Obsidian, blog processing, large codebases. They still go astray often. I've refactored my own workflow at least 10 times, building projects like [claudex](https://github.com/nickpending/claudex) and [claudex-guard](https://github.com/nickpending/claudex-guard) to deal with improving output quality. Each refactor taught me more about where they break down, but the combination of LLM intelligence with deterministic execution works when you understand the boundaries.

What I've learned: they're great at understanding what you want and translating that into working code. The variability comes in the creative/analytical parts, not the structural execution.

## The Way Forward

The innovation isn't making LLMs deterministic. It's using them where they dominate—ideation, planning, and code generation—while letting traditional deterministic systems handle execution.

They excel at helping you think through problems, explore solutions, and translate ideas into working implementations. Once you have that code, let reliable systems run it. Don't hand over control of workflows, orchestration, or runtime decisions. Use them as brilliant collaborators in the creative and analytical work, then step back when it's time for consistent execution.

This isn't a limitation to work around. It's the nature of these systems, and once you understand it, you can build things that actually work.
