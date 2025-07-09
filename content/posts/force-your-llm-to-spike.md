---
title: "Force Your LLM to Spike"
description: "How forcing LLMs to perform research spikes before implementation can induce engineering behavior instead of just coding."
date: 2025-07-09
categories: [development]
tags: [engineering, llm, claude-code, development-workflow, research-spikes, agile]
draft: false
---

I keep hearing that LLMs aren't good engineers. I think I figured out why, and possibly how to address it.

Here's what I was seeing in my Claude Code workflow. Even with comprehensive specs - detailed HLD, implementation specs, task breakdown - there's still ambiguity between knowing what to build and knowing the best approach to take when building it. When I'd run `/plan-task`, Claude would pick a viable path and run with it, without exploring alternatives, because it's not built to do otherwise.

Take a recent example - I'm writing a meta-tool that does "stuff" with shell history. A decision had to be made on how to read that history: do we query the sqlite database directly, or does atuin have search features good enough to use for that purpose? Multiple valid approaches, each with different trade-offs.

This exploration of solution space, weighing trade-offs, considering approaches - that's engineering. LLMs skip this phase and jump straight to implementation. They generate code but don't do the engineering thinking that comes before.

So I borrowed an approach we already use with humans and made Claude Code do it for me: research spikes.

Now Claude actually goes out and builds different approaches, tests them, and writes up the findings. Then we have review sessions where we discuss all the pros and cons, observations, and decide on a path forward. You need to try a few ways before you settle on THE way. The process takes a few more cycles, but I think it delivers a better end result. Claude does actual engineering work - prototyping, testing, documenting, collaborating on decisions - rather than just coding.

Maybe this is how we induce engineering behavior instead of just implementation behavior.
