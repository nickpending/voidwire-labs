---
title: "The Real Cost of Claude Code Subagents"
date: 2025-07-30T10:00:00-07:00
categories: [ai, development]
tags: ["ai", "claude-code", "subagents", "development-workflow", "tokens", "observability"]
draft: false
description: "After burning through tokens with subagents, I learned when they're worth it and when custom commands work better."
---

For those dabbling with Claude Code subagents: they consume a TON of tokens. 

Which is fine—if you're burning them for the right reasons. A blog writer subagent? Maybe that works. You see the final output, judge quality, iterate. But when subagents touch multiple files across your codebase? That's where things can get problematic.

## TL;DR

- **Subagents burn 10x more tokens than custom commands.** ~50-100K tokens for implementation work vs ~5-10K for the same task with `/plan-task`. Your mileage may vary, but the difference is substantial.

- **You lose observability when it matters most.** Custom commands show every decision in your terminal history. Subagents? You're reverse-engineering what happened from outputs.

- **Heavy scaffolding doesn't fix the core issue.** I built mandatory file reads, forced outputs, strict templates. Still paying the token tax without gaining visibility.

- **They're perfect for deep architectural analysis.** When you need comprehensive exploration of complex problems, the 50K tokens become worth it. That websocket issue? Exactly when to call in a subagent.

- **Match the tool to the type of work.** Subagents for exploration and analysis. Custom commands for implementation and iteration. Simple tasks? Custom commands win on economics alone.

- **"Never trust, always verify" only works when you can see.** My workflow depends on catching problems as they happen. Hard to do when the work happens in a black box.

## The Token Reality

Subagents just launched, and after a few iterations with a single project, I saw each subagent using around 50K tokens and thought damn, that's a lot of tokens:

- `/plan-task` implementing a feature: ~5-10K tokens, full visibility
- code-implementer subagent doing the same work: 50-100K tokens, outputs only

That's roughly a 10x difference (your mileage may vary). Not just in cost—in opportunity to iterate, course-correct, and improve the approach over time.

## The Observability Problem

My custom commands came together through many iterations. Each failure was visible, debuggable, improvable. The `/plan-iteration` command alone went through dozens of refinements based on observed failure patterns:

- Started as a basic template filler
- Added the interview pattern when I realized assumptions were killing me
- Incorporated smart tech detection to avoid manual stack specification  
- Embedded standards directly to prevent context lookups
- Added approval gates because things started going off the rails before I could review

`/plan-task` has been through similar refinement. Most recently, I caught it selecting meaningless "create empty folder" tasks for quick completion rewards. But that's just the latest improvement—all possible because I could see the decision-making happen. This observability is what enabled the [systematic validation approach](https://labs.voidwire.info/posts/from-47-manual-iterations-to-systematic-validation/) that actually ships working software.

With subagents? They run in their own context, make decisions you can't see, and by the time you review outputs, you're reverse-engineering what happened. 

Someone might say "But I have auto-accept edits on, so it's practically the same." Except in my workflow, the main thread runs in a terminal with infinite history. I can scroll back if I want. I can see every decision point, every correction, every iteration. That visibility has been crucial for improving my workflow over time. Trust but verify? More like "never trust, always verify"—and that's only possible when you can see what happened.

And here's the thing about quality: are subagents producing better code? Maybe. Sometimes. It depends entirely on what kind of work you're asking them to do.

## The Scaffolding Attempts

Sure, you can ctrl-r to see what the subagent is doing, but that's different from having everything in your main terminal history where you naturally work. I hacked around this by heavily customizing my subagents. My custom agents are nothing like the default ones.

Where the default agents focus on expertise and philosophy, mine enforce structure:
- Mandatory file reads in specific order
- Forced output artifacts to `.agent/` directory  
- Strict operating rules with "CRITICAL" warnings
- Prescriptive templates they must follow

The goal? Make agents "see" each other's outputs. Give myself something to review without having to ctrl-r into each subagent run. It's the same philosophy behind [building guardrails with hooks](https://labs.voidwire.info/posts/building-my-first-claude-code-hook-closing-the-hope-and-pray-gap/)—catching problems where they happen, not hoping they surface later.

But you build ALL that scaffolding and still pay the token tax. Plus, how do you KNOW your subagent is working well for your use case? This becomes particularly acute when implementing something non-trivial. 

Even with perfect scaffolding:
- 50K+ tokens for complex work  
- Machinery that might be working (or might not)
- Output artifacts you still have to reverse-engineer
- Expensive trial-and-error to validate it's working right

## When It Actually Works

While writing this article, I hit exactly the right scenario for a subagent. A websocket/eventing issue emerged during development—something we hadn't fully planned for. Now I need to explore architectural options:

- Should I pivot to a sustainable solution now?
- Keep acquiring technical debt?
- What are the trade-offs?

This calls for comprehensive analysis of an unexpected decision point. The thorough exploration a subagent provides justifies the token cost. I'm not trying to implement something iteratively—I need deep analysis of a complex problem.

That's when the 50K tokens make sense. That's when losing direct observability becomes acceptable. Because the work itself is exploratory, not execution.

## The Pattern

What I've noticed: `/plan-task` can get bogged down when a task requires heavy architectural thinking. That's exactly when you want to phone a friend. Call in an architecture-analyst subagent to handle the complex analysis without overloading your main implementation thread.

But the reverse is also true. When you need to implement something with many moving parts across multiple files, the observability of custom commands becomes crucial. You need to see each decision, catch each mistake, refine each approach.

**Subagents work well for:**
- Comprehensive analysis requiring thorough exploration
- Research tasks where you want multiple perspectives
- Architectural decisions with many considerations
- One-off investigations where the depth justifies the cost

**Custom commands work well for:**
- Implementation with visible decision points
- Workflows that need iterative refinement
- Predictable token consumption
- Building institutional knowledge through repeated use

But wait—what about simple tasks? Could a blog writer subagent save time? Maybe, but why burn 50K tokens when a custom command handles it for a fraction of the cost? The economics rarely make sense for straightforward work.

## The F.O.C.U.S. Connection

This aligns with my [F.O.C.U.S. philosophy](https://labs.voidwire.info/posts/focus-philosophy/)—**F**ocused context, **O**ne mission, **C**onstraints, **U**nambiguous objectives, **S**pecific outputs.

Subagents are comprehensive explorers by nature. That thoroughness makes them excellent analysts. For focused implementation work though, custom commands provide the visibility and iteration cycles that actually ship working software. It's why I developed [the systematic breakthrough](https://labs.voidwire.info/posts/the-systematic-breakthrough/) approach—validation through visibility.

## What This Means Practically

Through trial and error with different approaches, patterns started emerging:

**Analysis tasks:** Subagents can be worth the token tax when comprehensive exploration adds value. The depth of analysis sometimes justifies the cost.

**Implementation tasks:** Custom commands often work better where visibility enables iteration. Workflows improve through observed failures.

The pattern seems to be matching the tool to the type of work being performed. A comprehensive analyst might not be ideal for focused implementation, just as a focused implementor might miss important considerations in broad analysis.

Is this the right approach? I don't know. It's just what I've observed in my projects. The token consumption is real, the observability challenges are real, but maybe I'm missing something.

If you're building with Claude Code subagents:

- **For architecture decisions:** Subagents can explore options you hadn't considered
- **For research tasks:** Their thoroughness finds patterns and approaches
- **For implementation:** Custom commands let you see and fix what breaks
- **For workflows:** Commands build institutional knowledge through repeated use
- **For simple tasks:** Consider if custom commands might be more efficient

The innovation isn't making subagents cheaper or more transparent. It's understanding when their comprehensive analysis justifies the cost and complexity.

## Early Days

These patterns will change as the tooling matures. But right now, if you're watching your token count explode while losing visibility into your development process, you're not alone. 

Both approaches have their place. What matters is figuring out where each works best, not forcing one approach to handle everything.

---

*Note: This is early days. Subagents just launched. These patterns might change as tools mature. But matching tools to type of work seems likely to remain relevant.*

## Related Reading

- [**How I Made Claude Code Actually Ship Software**](https://labs.voidwire.info/posts/how-i-made-claude-code-actually-ship-software-a-systematic-workflow-that-works/) - The systematic workflow that led to these insights about subagents vs custom commands
- [**The Architecture of Laziness**](https://labs.voidwire.info/posts/the-architecture-of-laziness-why-llms-are-fundamentally-designed-to-cut-corners/) - Why LLMs cut corners and how observability helps catch it happening
- [**Beyond Comprehensive Context**](https://labs.voidwire.info/posts/beyond-comprehensive-context/) - Why loading massive context isn't always the answer, and how token budgets shape development workflows
- [**Claude Code Memory Optimization**](https://labs.voidwire.info/posts/claude-code-memory-optimization/) - The layered memory approach that influenced my custom command development
- [**The Interview Pattern**](https://labs.voidwire.info/posts/the-interview-pattern-why-ai-should-ask-before-it-acts/) - How surfacing assumptions early (like `/plan-iteration` does) prevents costly mistakes