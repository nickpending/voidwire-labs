---
title: "Momentum: A Workflow That Helped Me Build"
date: 2025-08-07
categories: [ai, development, workflow]
tags: ["claude-code", "workflow", "development", "momentum", "shipping", "subagents"]
draft: false
description: "Packaging six months of workflow iteration into momentum - a Claude Code workflow that actually ships by treating AI as a compiler for operator expertise."
---

A month ago I wrote about making Claude Code actually ship software. The workflow has been through at least six revisions since I started, but this latest version has been stable.

Now it's [packaged as momentum](https://github.com/nickpending/momentum).

## What This Actually Is

Not another "make AI smarter" attempt. This is a workflow that assumes you know what you're doing and gives you tools to do it faster.

A recent post about [building Log Carver at C-speed](https://iamnor.com/2025/08/07/claude-c-and-carnage-building-log-carver-at-the-edge-of-performance/) nailed it: "AI is no longer just a productivity booster. It's a compiler for ideas. But like any compiler, it needs constraints, tests, and a damn good operator behind the keyboard."

That's what momentum is - constraints and structure for operators who know their craft.

## Micro-Tasks: The Difference Between Starting and Shipping

The key was recognizing that 1-2 file changes are the right size to complete before context overflow kills your progress.

`/decompose-iteration` breaks features down to this level. But here's what makes it work: `/plan-task` intelligently groups related micro-tasks when they need to happen together. Five database migrations that depend on each other? They group. An API endpoint and its frontend? Might be separate tasks - the API can work standalone.

I don't know if this is how all developers think, but it's what keeps tasks from dying at 80% completion.

## The Specialized Tools

**Architecture and Implementation Analysis**: Two subagents that create written artifacts when you need depth. Not every task needs architectural analysis - but when you're touching three systems and need to think through integration patterns, you invoke `architecture-analyst`. Get a written plan. Execute against it.

**The Skeptical Auditor**: Just wrote `architecture-auditor` - my personal skepticism about AI code quality in agent form. After completing an iteration, it audits what actually got built versus what was planned. Finds dead code, integration gaps, pattern violations. Basically all the shit AI leaves behind when it thinks it's "done."

**Context Recovery**: `/save-state` is for those moments when you're watching Claude work, ask a clarifying question, and suddenly your entire context is gone. It happens. Save state, reload, continue where you left off.

**Evidence Gates**: `/complete-iteration` synthesizes what was delivered, extracts lessons learned, updates feature statuses in IDEA.md, then archives everything. It won't complete without evidence that features are actually accessible to users - not just coded.

## Why This Works for More Than Code

The interview pattern in `/plan-iteration` - where the command asks you specific questions before generating plans - works because it surfaces assumptions early. This same pattern could drive any structured creation.

I'm already thinking about a writing-focused instance: loads style guides, maintains blog summaries for quick context, uses the interview pattern for ideation. The core insight isn't about code - it's about structured interaction between operator and AI.

## What Makes It Work

This workflow doesn't make AI autonomous. It makes good developers faster by:
- Enforcing the discipline you'd have on your best day
- Capturing context before it vanishes
- Grouping work in ways that actually ship
- Requiring evidence you'd check if you were being rigorous
- Auditing what actually got built versus what you thought got built

The developers winning with AI aren't trying to replace themselves. They're building workflows that work with how they already operate.

## Get It and Adapt It

```bash
git clone https://github.com/nickpending/momentum.git
cd momentum
./install.sh claude --name="Your Name" --git-email="your@email.com" --email="you@company.com" --timezone="America/Los_Angeles"
```

The install script is zsh. Don't complain about it not supporting bash or your custom shell - submit a PR.

The interesting part isn't using my workflow - it's understanding what yours would prevent. What patterns would it enforce? What failures has your experience taught you to check for?

---

*Build workflows that turn your expertise into velocity. The code is there. What you do with it is up to you.*