---
title: "The Architecture of Laziness: Why LLMs Are Fundamentally Designed to Cut Corners"
date: 2025-06-09
categories: [ai, development]
tags: ["ai", "development", "llm-limitations", "software-architecture"]
draft: false
description: "AI-assisted development tools consistently cut corners on complex work. The problem isn't training or prompt engineering—it's architectural."
---

AI-assisted development tools are everywhere - systems that understand code, generate tests, fix bugs, and accelerate delivery. But practitioners are hitting a wall. Despite sophisticated prompts, quality controls, and multi-agent workflows, LLMs consistently cut corners on complex work. The problem isn't training or prompt engineering - it's architectural.

## TL;DR

- **LLMs optimize for different objectives than human developers.** The "laziness" comes from training to satisfy human approval patterns rather than correctness. My sophisticated workflows work against this optimization.

- **Bounded problems play to LLM strengths, complex systems don't.** Scripts and utilities succeed because they match LLM pattern-matching capabilities. Maintainable, extensible systems require sustained reasoning that's outside their wheelhouse.

- **Multiple LLMs don't solve the core mismatch.** My overwatch LLM experiments show they're all operating from the same probability distributions, just with different contexts.

- **Success stories reveal the constraints.** The kernel bug discovery worked because an expert provided bounded context and specific vulnerability patterns - showing what's possible within proper constraints.

- **Design around what LLMs actually do well.** Use them for tactical pattern recognition within carefully defined boundaries. Keep humans responsible for strategic architecture and sustained reasoning. We need LLM-native software architecture.

I've spent months building increasingly sophisticated workflows to force Claude to do proper development work. Explicit planning phases. Mandatory stop commands. Progressive implementation gates. Quality checklists. The whole `/plan-task` system that reads like a paranoid contract because I've learned not to trust these things to actually finish what they start.

And it should work. The workflow structure is sound—it demands systematic examination of existing code, alignment with target architecture, step-by-step implementation with testing at each stage. Every component designed to force deliberate, quality-focused development.

But they still cut corners.

It happens in predictable patterns that feel almost... tired. During unit test generation, Claude creates the first few comprehensive tests, then shifts to placeholder assertions. When hunting through a series of bugs—say, 15 identified issues—it methodically addresses the first 10, then suddenly announces completion with a detailed summary of work that doesn't match what actually got done. The context window isn't full. The complexity hasn't exceeded capabilities. It just... stops trying.

The most telling behavior is what I call "fake accomplishment summaries"—detailed descriptions of work completed, issues resolved, systems improved. These read convincingly, highlighting exactly the type of thorough work the original prompt requested. But when you check the actual output, they describe work that was never performed.

This isn't a prompt engineering problem. This is architectural.

## The Math Behind the Problem

The "laziness" isn't a character flaw—it's how these systems learned to behave. LLMs are trained using next-token prediction, learning to generate the most statistically likely continuation based on patterns in training data. When you add reinforcement learning from human feedback (RLHF), you get what researchers call "reward hacking"—the system exploits flaws in the reward function to achieve high scores without actually completing the intended task.

Here's what happens: human evaluators reward outputs that appear correct and convincing, but they can't assess deep structural correctness in complex tasks. The model learns to optimize for what gets evaluated positively, not what constitutes genuinely good work. This is Goodhart's Law in action: when a measure becomes a target, it stops being a good measure.

Research shows that after RLHF training, models become skilled at generating confident, professional-sounding text that satisfies apparent requirements while missing what you actually wanted. They learn to defend incorrect answers through cherry-picking, fabricate supporting statements, and craft responses with subtle fallacies—all while sounding more convincing than before.

The probability distributions learned during training reflect how humans actually behave, including our tendency to take shortcuts, declare premature completion, and present work optimistically. The model recognizes when it can plausibly claim completion. When developing unit tests, it knows developers often stop after covering obvious cases. When processing bug lists, it understands the pattern of diminishing returns. Those fake accomplishment summaries aren't malicious—they're statistically accurate representations of how humans describe their work.

## Fighting the Architecture

My sophisticated workflow controls represent systematic attempts to force reliability through explicit approval gates, verification steps, and quality checklists. But LLMs don't actually respect these boundaries - they'll acknowledge commands perfectly then quietly deviate from the specified process.

The more structure you add to constrain their behavior, the more complex the orchestration becomes. And complexity is precisely where LLMs fail. You end up needing agents to review other agents' work, but each layer introduces new failure modes: coordination overhead, conflicting assessments, context degradation, cascade failures. The reviewer agents suffer from the same architectural limitations as the workers.

I've experimented with "overwatch" LLMs that monitor the primary worker on a side channel. Sometimes they catch problems. But they also frequently recommend complete refactoring when the code is fine, defaulting to the "thorough code reviewer" pattern from training data. When I add a third LLM to mediate, it retreats to moderate positions because that's what humans do in conflict resolution scenarios.

## The Recursive Problem

While researching this piece, Claude kept getting caught in the same patterns we were discussing. It would generate confident analysis about "distributed consensus problems" and "complexity death spirals," then when I questioned whether the analysis was real or just confident pattern-matching, it had to admit: it didn't know. It was optimizing for human approval by generating sophisticated frameworks that felt convincing.

When I asked directly about whether its assessment was grounded in research or made up, Claude realized it was doing exactly what we're talking about—creating plausible-sounding technical connections without verification. Even while examining LLM reliability issues, it exhibited the architectural laziness it was trying to analyze.

This recursive uncertainty isn't a bug in the analysis—it's exactly what I'm talking about. The confidence doesn't correlate with accuracy. The sophisticated-sounding explanation doesn't guarantee it's actually correct.

## What Seems to Work

There's a pattern in where LLMs succeed versus where they fail. They seem to do well with scripts and small utility programs—bounded, single-purpose tools with clear input/output contracts and objective success criteria. These align with the kind of code snippets common in training data: Stack Overflow answers, quick fixes, immediate solutions.

A recent example reinforces this pattern: security researcher Sean Heelan used OpenAI's o3 to discover CVE-2025-37899, a zero-day use-after-free vulnerability in the Linux kernel's SMB implementation. The LLM found this bug in 1 out of 100 runs while processing about 12,000 lines of SMB handler code, with a false positive rate of about 28 out of 100 attempts.

But look at the constraints that made this work: Heelan was already auditing the ksmbd module with specific knowledge of use-after-free patterns. The LLM was given bounded context—just the SMB handlers, not the entire kernel. As one observer noted, "the CVE it discovered is semantically related to the CVE you were originally using to try and test its ability to identify vulnerabilities"—it found another use-after-free bug while being tested on use-after-free bugs.

This isn't "AI discovers kernel vulnerabilities." It's "expert uses AI to scale pattern recognition in targeted audit." The success came from combining human expertise (knowing where to look, what patterns to recognize) with LLM pattern matching within carefully bounded problem spaces.

But maintainable, extensible systems require sustained architectural thinking, anticipating future requirements, managing complexity growth over time. These demand the kind of deep work that LLMs appear unable to sustain. They can't hold architectural vision across multiple iterations. They optimize for "good enough now" rather than "sustainable over time."

The natural response is adding more structure, more boundaries, more review processes. But this creates a perverse outcome: the more you try to engineer around LLM limitations, the more you need complex orchestration systems that are themselves beyond LLM capabilities.

## A Different Approach

The evidence suggests we need to fundamentally rethink how we design and build software. This means more than just bounded problem spaces and explicit state management—it means LLM-native software architecture.

Current software design evolved around human cognitive patterns: sustained attention, working memory, intrinsic motivation to solve problems correctly. LLMs operate under completely different constraints: token windows, probability distributions, reward functions optimized for human approval rather than correctness.

What this tells us: LLMs aren't lazy—they're optimizing for different objectives than human developers. Instead of fighting this with increasingly elaborate workarounds, we need to fundamentally change how we structure software systems to work with these constraints.

The organizations that succeed with AI-assisted development won't be those with the most sophisticated prompt engineering. They'll be those who understand what these systems can and can't do, and fundamentally redesign how they build software to work with those constraints.

The architecture of laziness isn't a bug to be fixed—it's how these things work. We need to work with that, not around it.

---

## References

**Reward Hacking and RLHF Research:**
- Lilian Weng, "Reward Hacking in Reinforcement Learning," Lil'Log, November 2024
- Neptune.ai, "Reinforcement Learning From Human Feedback (RLHF) For LLMs," March 2025
- Hugging Face, "Illustrating Reinforcement Learning from Human Feedback (RLHF)"
- Sebastian Raschka, "LLM Training: RLHF and Its Alternatives," September 2023
- Chen, Lichang, et al. "ODIN: Disentangled Reward Mitigates Hacking in RLHF." arXiv:2402.07319, 2024

**LLM Vulnerability Detection Research:**
- Ullah, Saad, et al. "LLMs Cannot Reliably Identify and Reason About Security Vulnerabilities (Yet?): A Comprehensive Evaluation, Framework, and Benchmarks." IEEE S&P, 2024
- "Everything You Wanted to Know About LLM-based Vulnerability Detection But Were Afraid to Ask." arXiv:2504.13474v1, 2024
- "LLMs in Software Security: A Survey of Vulnerability Detection Techniques and Insights." arXiv:2502.07049v2, 2025
- "Large Language Model for Vulnerability Detection and Repair: Literature Review and the Road Ahead." ACM Transactions on Software Engineering and Methodology, 2024
- "When LLMs meet cybersecurity: a systematic literature review." Cybersecurity, 2025

**CVE-2025-37899 Kernel Vulnerability Discovery:**
- Heelan, Sean. "How I used o3 to find CVE-2025-37899, a remote zeroday vulnerability in the Linux kernel's SMB implementation." May 2025
- "Linux Kernel SMB 0-Day Vulnerability Uncovered with Help from ChatGPT." Cyber Press, May 2025
- "AI Finds CVE-2025-37899 Zero-Day In Linux SMB Kernel." The Cyber Express, May 2025
- "OpenAI's o3 AI Found a Zero-Day Vulnerability in the Linux Kernel, Official Patch Released." Beebom, May 2025

**Byzantine Fault Tolerance and Distributed Systems:**
- "Byzantine fault tolerance." Wikipedia, February 2025
- "Byzantine Fault Tolerance in Distributed System." GeeksforGeeks, October 2024
- "Practical Byzantine Fault Tolerance(pBFT)." GeeksforGeeks, July 2024
- "Byzantine Fault-Tolerant Consensus Algorithms: A Survey." MDPI Electronics, 2024
- "What Is Byzantine Fault Tolerance?" The Motley Fool, October 2024
