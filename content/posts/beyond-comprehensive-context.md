---
title: "Beyond Comprehensive Context"
date: 2025-05-23
categories: [ai, security]
tags: ["ai", "security", "prompt-engineering", "claude-code"]
draft: false
description: "How Daily Claude Code Usage Taught Me Token Efficiency"
---

[](https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F54574ba6-3031-4aa4-9121-1c56063ecdb7_1024x1024.png)*This continues my exploration of AI-assisted development workflows, building on insights from [Making Security Ambient](https://nickpending.substack.com/p/making-security-ambient-seamless) and the practical lessons learned from daily Claude Code usage.*

## The Evolution of AI-Assisted Development

The progression has been fascinating to observe—and participate in. We started with simple one-shot prompts: "Generate this function." Then we got smarter about light planning, adding some structure to our requests. From there, we developed systematic AI-assisted workflows like the `/plan-task` approach I've written about, where architectural guardrails transform unpredictable AI assistance into something more craftsperson-like.

But each step in this evolution revealed new constraints. The more sophisticated our workflows became, the more context they required. And that's where I started hitting a wall that I hadn't fully appreciated: the token budget and friction reality.

## The Comprehensive Context Experiment

Just a few weeks ago, my approach was quite different. I had developed what seemed like a logical solution: comprehensive context loading through custom commands. My `/load-app-context` command would systematically load multiple large documents—DESIGN_PRINCIPLES.md, IMPLEMENTATION_GUIDELINES.md, TARGET_ARCHITECTURE.md, and detailed APP_CONTEXT.md files.

The `/create-app-context` command I built would generate exhaustive documentation covering everything: project overview, architecture diagrams, data models, API endpoints, database schemas, security configurations, development workflows, troubleshooting guides, deployment procedures, and performance considerations. We're talking about documents that could easily run 10,000+ tokens each.

The theory was sound: give Claude Code comprehensive understanding of the project so it could make informed decisions about any task. Load everything upfront, then work within that rich context throughout the session. It felt thorough and systematic.

But I was learning the hard way—and missing something important about the evolution from simple to complex AI interactions.

## The Friction Trade-off

There's something genuinely amazing about asking Claude to write a Python script or function in a single shot and getting it right. That immediate, frictionless interaction has real value. The magic of "write me a function that parses JSON and extracts email addresses" and getting clean, working code is hard to overstate.

But once the asks got larger—building entire applications, implementing complex workflows, integrating multiple systems—one-shot prompts weren't enough. You need structure, planning, architectural consistency. The challenge is that structure comes at a cost: friction and context budget.

My comprehensive context loading approach addressed the capability gap but introduced significant friction. Every session began with loading massive documents, waiting for processing, and working within context that was 90% irrelevant to the immediate task. The cognitive overhead affected both the AI's focus and my own workflow rhythm.

I found myself caught between two unsatisfying extremes: the immediate gratification of simple one-shot prompts that couldn't handle complexity, and the comprehensive context approach that could handle complexity but felt cumbersome for routine tasks.

## The Structured Workflow Evolution

The solution I developed was a systematic command-based workflow that I shared as a teaser:

**Claude Code with Custom Commands - Vibe-coding Edition!**

- `/load-app-context` - retrieves all the required project/app state/next-task

- `/plan-task` - generates an implementation plan using guardrails

- `/plan-check` - checks the plan!

- `/task-check` - not shown but will verify the implementation

This represented a middle path: structured commands that could handle complexity while maintaining workflow efficiency. The guardrails approach I wrote about earlier—where AI systems review architecture and principles before implementation—was working. I was seeing major improvements in code quality and architectural consistency.

But the `/load-app-context` command, while implemented and functional, was the source of the inefficiency. It was loading those comprehensive documents—DESIGN_PRINCIPLES.md, IMPLEMENTATION_GUIDELINES.md, TARGET_ARCHITECTURE.md, detailed APP_CONTEXT.md files—every single time, regardless of whether I was fixing a simple bug or architecting a major feature.

The practical consequence became clear through daily usage: I would regularly run out of context mid-session. Claude Code would either trigger an auto-compact context event or I'd need to start a brand new session. Each option had trade-offs. Auto-compacting risked losing important context and nuance from earlier in the conversation. Starting fresh meant losing the conversational flow and having to rebuild working context, plus re-running `/load-app-context` and burning through tokens again.

This cycle of context exhaustion and recovery highlighted the core inefficiency: I was front-loading comprehensive documentation that might be 90% irrelevant to the immediate task, then losing conversational context that was 100% relevant to maintaining productive flow.

## The Token Budget and Friction Reality

What I didn't fully appreciate was Claude Code's dual constraint: token consumption and workflow friction. While Claude Code's exact system prompt size isn't publicly documented, it's clearly substantial—the tool includes complex system instructions, tool definitions, and parsing capabilities that enable it to understand codebases, execute commands, and maintain context across development sessions. This creates both a practical token constraint and a cognitive friction problem.

The token budget issue is straightforward: within the remaining capacity after Claude Code's system overhead, we need to provide context for an enormous variety of tasks. But the friction issue is more subtle and equally important. Loading comprehensive documentation every session creates delay, cognitive overhead, and breaks the flow that makes AI-assisted coding feel magical.

The cycle I found myself in was telling: load comprehensive context, work for a while, run out of tokens, auto-compact (lose nuance) or start fresh (lose flow plus reload context), repeat. This wasn't just inefficient—it was cognitively disruptive. The overhead of context management was interfering with the actual work.

## The Memory Optimization Breakthrough

Claude Code's automatic memory loading revealed an elegant solution to both problems. These memory files—CLAUDE.md (project-specific), CLAUDE.local.md (local preferences), and ~/.claude/CLAUDE.md (global across all projects)—load at every session startup without consuming task-specific token budget. Instead of viewing this as a limitation, I began seeing it as an opportunity for embedding the essential knowledge that should persist across all development sessions.

What we optimized was how to use these memory layers strategically. Rather than treating them as simple documentation storage, we restructured them as compressed expertise delivery systems. The global memory became our universal principles that apply everywhere. The local memory became our language and workflow-specific preferences that prevent common mistakes like suggesting deprecated libraries. The project memory became our current system overview rather than comprehensive documentation.

The distinction became clearer through practice. Memory functions like compressed expertise—the patterns and principles that expert developers carry as intuitive knowledge. Documentation serves as detailed reference material consulted when warranted by task complexity.

This mirrors how human expertise actually operates. An experienced developer doesn't consciously review architectural principles before fixing a simple bug; those principles are internalized. But they do consult detailed specifications when implementing complex integrations or making significant design decisions.

## Task-Driven Context Loading

The more sophisticated challenge involved determining when to load comprehensive documentation. Rather than front-loading everything, I developed an approach where task identification precedes context loading.

The system first examines the task list to identify the next piece of work, then selectively loads only the documentation sections relevant to that specific task. API development triggers loading of API specifications. Security reviews access threat models. UI work pulls in user experience guidelines.

This creates surgical context management. Instead of processing comprehensive documentation to extract relevant details, the AI works with focused context tailored to immediate needs. The token budget goes toward task-relevant information rather than comprehensive coverage.

## The Legacy Library Solution

One unexpected benefit addressed a recurring frustration: AI systems suggesting outdated approaches. Without persistent context, I found myself repeatedly correcting suggestions to use `requests` instead of `httpx`, SQLAlchemy 1.x patterns instead of 2.0+ syntax, or `argparse` instead of modern frameworks like Click.

By documenting preferred and deprecated libraries in persistent memory, these preferences survive across sessions without consuming task-specific tokens. The AI system learns not just what to use, but what to actively avoid. This represents institutional memory that prevents regression to outdated patterns.

The effectiveness surprised me. Rather than repeatedly making the same corrections, the system began proactively choosing modern alternatives. It's institutional knowledge that persists without ongoing token overhead.

## Beyond Token Efficiency

What I've learned extends beyond simple resource optimization. The constraints imposed by Claude Code's token budget forced thinking more carefully about knowledge representation and transfer. Not all information serves the same function, and systems that treat it identically sacrifice efficiency for comprehensiveness.

This connects to broader questions about human-AI collaboration in development contexts. The most effective partnerships may not involve documenting everything we know, but rather identifying the compressed patterns that expert practitioners carry as intuitive knowledge and making those patterns persistently available while organizing detailed references for selective access.

## The Optimization Paradox (I know, I don’t like the word either)

There's an interesting paradox in this evolution. As AI systems become more capable, the temptation increases to provide them with comprehensive context under the assumption that they can handle complexity better. But working within real constraints—like Claude Code's token budget—forces more thoughtful approaches that often produce better results.

The limitation becomes a design constraint that encourages better solutions. Rather than overwhelming AI systems with comprehensive information, we learn to structure knowledge in ways that align with both human expertise patterns and artificial reasoning capabilities.

This represents maturation in how we approach AI-assisted development. Instead of assuming more context always produces better results, we're learning to optimize the relationship between context efficiency and task effectiveness.

## What Comes Next

Working within Claude Code's token constraints has taught me that effective AI assistance depends as much on what we don't provide as what we do. The goal isn't maximum context—it's appropriate context delivered efficiently within real limitations.

This optimization challenge will likely intensify as these systems become more integrated into development workflows. The organizations and individuals who learn to structure knowledge effectively will have advantages over those who treat AI systems as unlimited processors for unstructured information.

The future of AI-assisted development may depend as much as how we organize and prioritize what we know as on the capabilities of the systems themselves. The token budget constraint is just one example of how real-world limitations force better solutions than unlimited resources might permit.