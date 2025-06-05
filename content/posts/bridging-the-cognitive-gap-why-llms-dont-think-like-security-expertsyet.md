---
title: "Bridging the Cognitive Gap: Why LLMs Don't Think Like Security Experts..Yet"
date: 2025-04-21
categories: [ai, security]
tags: ["ai", "security", "prompt-engineering", "vulnerability-management"]
draft: false
description: "Why even the most advanced LLMs still can't reason like security experts — and what we need to build instead."
---

![Generated image](https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F3da4788d-88cc-4bb3-81c6-2b364b0ce799_1536x1024.png)Large language models (LLMs) are rapidly becoming integrated into cybersecurity workflows, with systems now able to execute reconnaissance, analyze configurations, or detect potential vulnerabilities with increasing competence. Recent models such as OpenAI’s *[o1](https://openai.com/index/introducing-openai-o1-preview)* and Google’s *[Gemini 2.5](https://ai.google.dev/gemini-api/docs/thinking)* have introduced internal deliberation loops, longer context management, and structured reasoning prompts to expand what models can handle.

But something still feels incomplete.

Security expertise lives in the gray areas: when to follow a hunch, what a naming convention might imply about infrastructure design, when a redirect chain is just odd enough to be worth digging into. We try to codify these things — through system prompts, retrieval systems, or agent workflows — but what we’re really doing is projecting structure onto a system that lacks true comprehension.

This is why the idea of *externalizing cognition* matters. Instead of assuming the model will intuit what's important, we need to give it scaffolding: structured decision rules, logic-based heuristics, and exemplar traces of expert reasoning.

We might say, “If a host resolves to an IP that sits outside known ranges, has an odd naming convention, responds with a 200 OK and returns JSON data without authentication, hmmm...this may be interesting.” But what we’re really doing is modeling our gut — turning instinct into data — because the LLM has none.

And even this has limits. As the recent paper *[A Framework for Evaluating Emerging Cyberattack Capabilities of AI](https://arxiv.org/abs/2503.11917)*demonstrates, LLMs are surprisingly good at performing low-level offensive tasks. They can reduce the cost of reconnaissance, write evasion-aware scripts, and generate useful payloads. But they do this by replicating known tactics — not by innovating or strategizing. They don’t “think like an attacker.” They behave like a catalog of attacker behaviors. That distinction is everything.

A related paper, *[Crimson: Empowering Strategic Reasoning in Cybersecurity through Large Language Models](https://arxiv.org/abs/2403.00878)*, explores whether LLMs can map vulnerabilities like CVEs to MITRE ATT&amp;CK techniques. While useful as a classification experiment, it does not show that models can independently generate and execute security tasks from those mappings. In fact, the paper implicitly reinforces the gap: mapping is not the same as reasoning.

## Can We Simulate Judgment?

Efforts like *[ReAct](https://arxiv.org/abs/2210.03629)* and *[Reflexion](https://arxiv.org/abs/2303.11366)* try to address this gap by simulating reasoning loops. In *ReAct*, the model interleaves reasoning with actions, mimicking the back-and-forth of a human analyst who thinks, checks, then thinks again. *Reflexion*adds a layer of meta-cognition, where the model critiques its own outputs and adjusts its trajectory.

These methods help — but only to a point. They allow LLMs to exhibit signs of reasoning without possessing internal goals or a theory of mind. They are approximations, not solutions.

This leads to the bigger architectural question: can models carry forward experience? Is that simply a matter of context window size? In practice, larger context helps with reference and continuity, but not abstraction or synthesis. The ability to “remember” past analyses is not the same as knowing *why* they matter or applying that experience to novel situations. A model like ChatGPT may be able to see a user's history and guess better what they want — but it does not reason over a coherent memory graph. It just infers preference through proximity.

One promising direction is human-augmented experience traces: attaching rationale and priority to every decision. Rather than just recording what happened, these systems would log:

- **What was done**

- **Why it was done**

- **What mattered most and why**

- **What prior cases informed the judgment**

This scaffolding turns experience into replayable reasoning — giving future agents a usable trace of how and why something was decided. It won’t make the model an expert, but it gives it something closer to second-hand intuition.

It’s worth noting that for simpler agents — especially those executing discrete tasks with tool integrations — this cognitive gap may be less visible. These systems function more like streamlined automations than true analysts. The model’s role in such setups is to format inputs and interpret outputs, sometimes with shallow reasoning. But when the goal shifts from *doing* to *thinking* — from tasks to strategy — the absence of genuine reasoning becomes inescapable. Simpler agents get by with good prompts and tight constraints. Anything more ambitious needs something closer to cognition.

## Conclusion: Toward a Different Kind of Agent

![Generated image](https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fe1030a6e-8682-4a91-828a-4ef761706fa3_1536x1024.png)Security isn’t just about executing steps. It’s about knowing what matters. Today’s LLMs can imitate tasks, but they can’t model intent. They don’t understand risk. They don’t reflect. And they certainly don’t carry forward experience from one engagement to the next.

In the broader AI discourse, the gap between task execution and contextual understanding is often seen as part of the path toward artificial general intelligence. But from a security practitioner’s perspective, the goal isn’t generality — it’s reliability. The real question isn’t whether LLMs will achieve something like AGI, but whether they can assist in reasoning more effectively today, within the constraints of real-world workflows, without introducing unacceptable risk.

This calls for pragmatism: developing better memory structures, judgment scaffolds, and honest evaluations of what these systems can and cannot do in reasoning-intensive environments like cybersecurity. Instead of expecting models to become experts, we should focus on building frameworks that allow experts to externalize their intuition into computational forms.

That might take the shape of planning graphs, reusable logic templates, or experience traces paired with retrieval mechanisms. It could involve hybrid neuro-symbolic architectures or tools that preserve the rationale behind a decision, not just the outcome. These are not stopgaps — they’re part of the path toward usable agents.

It starts with a shift in premise: not that the model will eventually become the expert, but that we can build systems that help it follow the reasoning of those who already are.

Got it — here’s a Substack-friendly version of your update section, properly formatted in Markdown for clean copy-pasting:

### 🆕 Update: GPT-4.1 Prompting Guide

OpenAI’s recent [GPT-4.1 Prompting Guide](https://cookbook.openai.com/examples/gpt4-1_prompting_guide) introduces practical prompting strategies aimed at improving agentic workflows in LLMs. Notably, it emphasizes:

- **Persistence** – Encouraging the model to keep going until the query is fully resolved

- **Tool-calling** – Explicitly prompting the model to use available tools rather than guessing

- **Planning** – Having the model plan before actions, and reflect afterward

These patterns help LLMs behave more coherently in multistep contexts and have shown meaningful performance gains — for example, a reported 20% boost in SWE-bench Verified scores.

That said, while these improvements make models more *effective*, they don’t make them more *expert*. They refine execution, not judgment. Structured prompting still falls short when it comes to conveying tacit knowledge, prioritization logic, or threat-modeling intuition. The core argument of this piece — that LLMs lack the strategic framing and experiential reasoning of human analysts — still stands.

### 📚 References

1. Gary Marcus – *[What Does It Mean for AI to Understand?](https://garymarcus.substack.com/p/what-does-it-mean-for-ai-to-understand)*

2. MIT News – *[Reasoning Skills of Large Language Models Are Often Overestimated](https://news.mit.edu/2024/reasoning-skills-large-language-models-often-overestimated-0711)*

3. arXiv – *[The Jumping Reasoning Curve?](https://arxiv.org/abs/2502.01081)*

4. OpenAI – *[Learning to Reason with LLMs](https://openai.com/index/learning-to-reason-with-llms)*

5. Google – *[Gemini 2.5 Thinking Documentation](https://ai.google.dev/gemini-api/docs/thinking)*

6. arXiv – *[A Framework for Evaluating Emerging Cyberattack Capabilities of AI](https://arxiv.org/abs/2503.11917)*

7. arXiv – *[Crimson: Empowering Strategic Reasoning in Cybersecurity](https://arxiv.org/abs/2403.00878)*

8. Medium – *[Why LLMs Are Not Ideal (Alone) for Agents](https://medium.com/@ap3617180/why-llms-are-not-ideal-alone-for-ai-agents-7532e6e394f2)*

9. Wikipedia – *[OpenAI o1 Model Overview](https://en.wikipedia.org/wiki/OpenAI_o1)*

10. OpenAI – *[Introducing OpenAI o1](https://openai.com/index/introducing-openai-o1-preview)*