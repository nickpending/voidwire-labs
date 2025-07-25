---
title: "F.O.C.U.S."
date: 2025-07-24T10:00:00-07:00
categories: [ai, development]
tags: ["ai", "llm", "claude-code", "development-workflow", "philosophy"]
draft: false
description: "A meditation on constraint as capability"
---

I was watching Miessler [demo OpenCode](https://www.youtube.com/watch?v=yTylDxgyJZ8&t=901s) against Claude Code. He fed it a video transcript with 900 lines of custom rules - formatting, content generation, image creation. Complex orchestration.

It just... worked.

Not because it was simple. The rules weren't trivial. But because it was focused. One clear task with defined inputs, explicit constraints, specific outputs.

It clicked. This is what I'd been building toward with my newly refactored development workflow - breaking work into focused units. Ideation separate from planning. Planning separate from implementation. Implementation separate from testing. Even my shortcut commands in CLAUDE.md follow the pattern: `qtest` writes ONE test. `qfix` debugs ONE error. `qcom` makes ONE commit.

**F**ocused context  
**O**ne mission  
**C**onstraints (do this, never that)  
**U**nambiguous objectives  
**S**pecific outputs

Take my [`/plan-task` command](https://labs.voidwire.info/posts/how-i-made-claude-code-actually-ship-software-a-systematic-workflow-that-works/). It doesn't try to architect the whole system. It takes a single numbered task from ITERATION.md, loads only the relevant tech standards, plans the implementation approach, then executes. One task. One context. One result.

The constraints make it work. "Never mock internal services" isn't a limitation - it prevents architectural disasters. "Real tests first" isn't dogma - it ensures what ships actually works. Every rule in the workflow exists because its absence caused failure.

You CAN give LLMs comprehensive context and hope for the best. You might even get what you want. Sometimes. But focused units of work deliver consistently. 

The efficiency isn't in doing more at once. It's in doing one thing completely before moving to the next.

Strange how often the answer is less, not more.

It's not perfect. They still hallucinate, still abandon tasks, still confidently assert nonsense. But with F.O.C.U.S., it happens less. And in this game, less failure is victory.