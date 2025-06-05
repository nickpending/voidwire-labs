---
title: "The Curious Case of the Thinking Machine"
date: 2025-05-23
categories: [ai, security]
tags: ["ai", "claude", "prompt-engineering", "performance"]
draft: false
description: "When Smart Models Get Too Clever"
---

![Generated image](https://substack-post-media.s3.amazonaws.com/public/images/28736531-d31b-4ea5-91a4-1c2eeeef73ae_1536x1024.png)

## The Setup

We're building a multi-step reconnaissance workflow using [Nerve ADK](https://github.com/evilsocket/nerve) - a chain of AI agents working together. We built a few pieces to get started:

1. Discovery Planner: "What information do we need?"
2. Command Generator: "How do we get that information?"

Simple. Elegant. Each agent has one job, and they pass data between them like a relay race.

## The Tools

Both agents had access to a think() function - a way to explicitly show their reasoning process. Think of it as the difference between solving math in your head vs. showing your work on paper.

## The Task

Our goal was simple: the Discovery Planner would identify what information we needed to gather about a target website, and the Command Generator would translate those requirements into concrete command-line instructions using security tools.

We gave the Command Generator clear guidelines: consolidate requirements into the minimum number of commands, verify tool flags against documentation, and produce structured output. Each agent had access to help files for available security tools (httpx, tlsx, etc.) to ensure they could construct valid commands.

The key challenge was efficiency - could the agent parse technical requirements and generate the optimal commands to gather the information with minimal footprint? This mimics the real-world task of a security analyst translating reconnaissance requirements into concrete technical actions.

## The Experiment

We ran the same workflow with two models: Claude 3.5 and Claude 3.7.

The shocking results:

### Claude 3.5 (The Quiet Achiever)

- **Time**: 11 seconds
- **Steps**: 3
- **Cost**: $0.029
- **Behavior**: Never used think() unless told
- **Output**: ONE command (as instructed)
- **Accuracy**: Minor syntax issues but correct approach

### Claude 3.7 (The Overthinker)

- **Time**: 48 seconds (4.4x slower!)
- **Steps**: 7
- **Cost**: $0.106 (3.6x more expensive!)
- **Behavior**: Used think() without being asked, read 3 help files instead of 1
- **Output**: TWO commands (ignored consolidation instructions)
- **Accuracy**: MORE syntax errors despite all that "thinking"

Perhaps most surprising was that the "smarter" model actually made more syntax errors. This counterintuitive result suggests that excess reasoning can sometimes introduce more opportunities for mistakes rather than reducing them.

*(And yes, we ran this multiple times with similar results - whatever the reason, 3.7 consistently takes much longer to produce worse results.)*

### Claude 3.5 + Explicit Instructions (The Compliant Achiever)

When we added "You must explicitly document your reasoning!!!!!"

- **Time**: 17 seconds (still 2.8x faster than 3.7!)
- **Steps**: 4
- **Cost**: $0.042
- **Behavior**: Used think() exactly once as instructed
- **Output**: ONE command (followed instructions)
- **Accuracy**: Same as before

## The Plot Twist

When we tested Claude 3.7 directly (without Nerve ADK):

- It still required interaction to get the right answer
- Its initial response was incomplete, requiring correction
- Even with its advanced capabilities, it struggled with the same basic task

## The Context Awareness

- Claude 3.5 seemed to understand its role in the workflow pipeline
- Claude 3.7 acted more like a standalone problem solver, less aware of its specific function

It's like asking for directions: Claude 3.5 gives you the quickest route to your destination, while Claude 3.7 delivers a beautifully narrated but incomplete tour that leaves you lost halfway to where you needed to go.

## Pipeline Design Implications

This experience has reinforced our approach to AI agent design: clear, specific roles with narrowly defined tasks tend to work better than complex agents trying to solve everything at once. Claude 3.5 thrived with clear boundaries, while Claude 3.7 tried to expand its role.

## The Lessons

1. **More thinking ≠ better results** - 3.7 thought harder, took 4x longer, cost 3x more, and performed worse

2. **Following instructions matters** - 3.5 understood "consolidate into one command." 3.7 ignored it completely.

3. **Model personalities are real**
   - 3.5: Efficient introvert (thinks internally unless asked)
   - 3.7: Methodical academic (shows work without being asked)

4. **The cost of overthinking**
   - Time: 48s vs 11s
   - Money: $0.106 vs $0.029
   - Quality: Worse output with more thinking

5. **The illusion of intelligence** - More verbose reasoning created the impression of deeper thought, but actually produced inferior results

## The Takeaway

In AI workflows, sometimes the "smarter" model is like hiring a PhD to make coffee - they'll overthink it, take longer, cost more, and possibly mess it up because they're too busy considering the philosophical implications of bean origin.

The numbers don't lie: For straightforward workflows that need quick, efficient execution, the "dumber" model might be the smarter choice. Claude 3.5 delivered better results in 1/4 the time at 1/3 the cost.

Choose your model based on the task, not the version number.

## Technical Note

For the technically curious: These tests used Claude 3.5 Sonnet (claude-3-5-sonnet-20240620) and Claude 3.7 Sonnet (claude-3-7-sonnet-20250219) with identical prompts and Nerve ADK configurations.

## A Better Testing Approach

In retrospect, we should have used [PromptFoo](https://github.com/promptfoo/promptfoo) for more rigorous comparison. PromptFoo is an open-source tool that allows side-by-side comparison of multiple LLM outputs for the same prompt. It provides a clean interface to evaluate performance metrics, timing data, and response quality across different models simultaneously, making it ideal for empirical model selection experiments like this one.

## What's Next?

This experiment has led us to standardize on Claude 3.5 for our reconnaissance workflows. We're now exploring other tasks where "less powerful" models might actually outperform their more advanced counterparts. The key insight: model selection should be based on empirical results, not theoretical capabilities.
