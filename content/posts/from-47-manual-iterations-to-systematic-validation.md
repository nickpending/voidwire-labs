---
title: "From 47 Manual Iterations to Systematic Validation"
date: 2025-05-30
categories: [ai, security]
tags: ["ai", "prompt-engineering"]
draft: false
description: "Part 1 - The Breaking Point"
---

![Generated image](https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F1f746170-fb85-485f-8429-8e17d2c2108a_1024x1024.png)*This begins a two-part exploration of evolving from intuition-based to evidence-based prompt engineering, revealing fundamental insights about AI system limitations and systematic evaluation.*

## The Problem That Nearly Broke Me..Not Really

I was building a multi-phase HTTP reconnaissance workflow using Nerve ADK - a sophisticated chain of AI agents working together to systematically probe web services. The architecture was elegant (if I do say so myself!): a Discovery Planner would identify what information we needed, a Command Generator would translate those requirements into concrete tool commands, and executors would run the actual reconnaissance.

As I documented in ["The Curious Case of the Thinking Machine](https://nickpending.substack.com/p/the-curious-case-of-the-thinking)”, this same workflow had already revealed counterintuitive performance differences between Claude models - with the "smarter" Claude 3.7 consistently taking longer, costing more, and producing worse results than Claude 3.5. But those findings raised more questions than answers: Was this a model-specific quirk, or evidence of something more fundamental about AI reasoning capabilities?

The Command Generator was the lynchpin of this investigation. It needed to take high-level probe descriptions like "GET request to main page" and "TLS certificate analysis" and produce precise httpx commands with all the right flags, proper path handling, and structured output formatting. Get it wrong, and the entire 5-step workflow would fail downstream.

But something was fundamentally broken - and it went deeper than just model selection.

I'd tweak the command-generator prompt, run it through the full Nerve ADK workflow, watch it produce garbage httpx commands, manually debug which step failed, then repeat. Again and again. The commands would be syntactically valid but semantically wrong - missing critical flags like `-td` for technology detection, using multiple `-path` flags instead of comma-separated paths, forgetting JSON output formatting.

After 47 manual iterations, I was genuinely questioning my life choices. To make matters worse, I was getting AI assistance to debug my AI-generated commands - having Claude analyze why its own outputs were failing, creating a recursive loop of AI troubleshooting AI problems.

We were rapidly approaching the space where we said "fuck it, let's just build a stupid agent that doesn't reason and just executes commands." Because if you need extensive scaffolding to get an AI to correctly interpret technical documentation and construct valid commands, maybe the 'intelligence' part isn't delivering on the autonomy everyone's promising.

## The Scaffolding Solution: Building Essential Infrastructure

By iteration 47, I had evolved from simple prompts to comprehensive scaffolding. My final prompt included:

- **901 lines of detailed instructions** covering every edge case I'd encountered

- **Complete httpx documentation** embedded in the prompt

- **23 explicit DO/DON'T rules** covering common httpx mistakes

- **Step-by-step reasoning guidelines** for flag verification

- **Output format requirements** and consolidation guidelines

- **Tool usage patterns** specific to reconnaissance workflows

The complexity felt overwhelming, but it seemed to be the only approach that worked. The scaffolding addressed systematic failure patterns I'd discovered through painful manual iteration:

## DO:
- Use comma-separated paths: `-path /,/robots.txt`
- Include `-json` for structured output, `-silent` to reduce noise
- Generate ABSOLUTE MINIMUM number of commands

## DO NOT:
- DO NOT use multiple `-path` flags: `-path / -path /robots.txt`
- DO NOT use `-body-preview` or `-bp` flags
- DO NOT use custom User-Agent headers
- DO NOT probe speculative paths like `/app.js`, `/config.js`
I began to wonder: was this necessary complexity, or had I over-engineered the solution? The recursive nature of the problem - using AI to debug AI-generated commands - made me question whether I was solving the right problem entirely.

## The Cost of Iterative Guesswork

What I didn't fully appreciate during those 47 iterations was the economic dimension of the problem. I was defaulting to whatever model seemed "best" without considering cost-performance trade-offs. When you're potentially generating hundreds of commands daily in a production reconnaissance workflow, model selection becomes an economic optimization problem, not just a capability question.

But first, I needed to understand which approaches actually worked reliably. That's where systematic evaluation became essential.

## Enter PromptFoo: From Anecdotal to Systematic

The Claude model performance differences I'd observed were puzzling, but they were still anecdotal. I needed to understand whether my prompting strategy was fundamentally flawed, whether certain models were inherently better at technical tasks, or whether there were systematic patterns I was missing.

PromptFoo bills itself as a tool for "test-driven LLM development," and while that sounds like Silicon Valley marketing speak, it turned out to be precisely what I needed. Instead of hoping my prompts worked, I could systematically validate them with assertions and test matrices across multiple models and providers.

This would let me move beyond the "Claude 3.5 vs 3.7" comparison and test fundamental assumptions about prompting strategies themselves.

I designed a comprehensive experiment to test four fundamentally different approaches:

**Test 1: Zero-shot with Extensive Guardrails (Original)**My complete 901-line system with 23 DO/DON'T rules, embedded documentation, and comprehensive guidelines.

**Test 2: Few-shot with Examples**5 concrete examples showing input→output patterns with reasoning explanations, plus complete tool documentation.

**Test 3: Step-by-step Reasoning**Explicit 5-step process (Documentation → Analysis → Selection → Construction → Validation) with structured thinking framework.

**Test 4: Zero-shot with Focused Guardrails (Optimized)**Streamlined to 367 lines (~60% reduction), keeping only essential constraints and direct specifications.

I tested all approaches across five major models: Claude 3.5 Sonnet (latest and older), Claude 3.7 Sonnet, GPT-4o, GPT-4-turbo, and GPT-4o-mini. Each prompt included complete httpx documentation to ensure fair comparison.

## The First Results: Suspiciously Claude-Specific

The initial PromptFoo results were shocking - and suspicious:

- **Claude 3.5 Sonnet (Oct 2024):** ✅ **SUCCESS** (only with full scaffolding)

- **Claude 3.7 Sonnet:** ❌ **FAILED**

- **All OpenAI models:** ❌ **FAILED**

- **Older Claude models:** ❌ **FAILED**

Only one specific model version could handle the task. This felt wrong - how could a single AI model be the only one capable of parsing httpx documentation correctly?

My instinct was right to be suspicious.

## The Debugging Revelation: Bias in "Systematic" Testing

I dug into the failing test cases and discovered a critical flaw in my "systematic" approach: **my assertions were biased toward Claude's output style**.

The issue was with flag format validation. httpx accepts both short and long forms:

- `-td` and `--tech-detect` (both valid)

- `-u` and `--target` (both valid)

- `-j` and `--json` (both valid)

My assertions only checked for short flags (`-td`), so models that used long flags (`--tech-detect`) were marked as failures even though their commands were perfectly correct.

**The meta-lesson:** Even systematic testing needs systematic debugging. I had unknowingly built Claude-specific bias into my "objective" evaluation criteria.

## What This Revealed About AI Evaluation

This experience highlighted a fundamental challenge in AI evaluation: **our assumptions about "correct" outputs can systematically favor certain approaches over others**. Even when we think we're being objective, we carry unconscious biases about what good output should look like.

The debugging process revealed several layers of bias:

1. **Format bias**: Preferring short flags over long flags

2. **Style bias**: Expecting specific command structures

3. **Model bias**: Designing tests around one model's output patterns

4. **Workflow bias**: Optimizing for my specific use case rather than general capability

This wasn't just a technical mistake - it was a methodological blind spot that could have led to completely wrong conclusions about model capabilities and optimal prompting strategies.

## The Cliffhanger: What Really Works?

After fixing the flag format bias and running the complete four-strategy comparison across all models, the results were definitive - and completely different from my expectations. But those findings, and their implications for how we should think about AI system design and evaluation, deserve their own dedicated exploration.

What I discovered challenged everything I thought I knew about prompt engineering, revealed fundamental limitations in how current AI systems handle reasoning tasks, and provided a research-backed explanation for why "more thinking" can actually make AI systems worse at following instructions.

*Continue to [Part 2: The Systematic Breakthrough](https://nickpending.substack.com/p/the-systematic-breakthrough) to discover the surprising results and their implications for AI-assisted development.*

### About This Series

This two-part series documents the evolution from intuition-based to evidence-based AI prompt engineering, revealing both the power and limitations of systematic evaluation approaches. Part 1 explores the problem space and methodology, while Part 2 examines the surprising results and their broader implications for AI system design.

*Next: Part 2 - The Systematic Breakthrough: Why "Smarter" Prompts Often Fail and What This Reveals About AI Limitations*