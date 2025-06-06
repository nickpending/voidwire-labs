---
title: "The Right Agent, Right Context, Right Time: Why Universal Context Doesn't Mean Universal Access"
date: 2025-06-06T11:00:00-08:00
draft: false
tags: ["ai", "agents", "context", "security", "development"]
categories: ["ai", "security"]
description: "Universal context doesn't mean the agent gets it all in one go. Here's what I learned building agentic systems that actually work."
---

Over the past ten years, I've spent considerable time and energy trying to shorten critical time gaps. The time it takes attackers (the good kind) to find bugs, defenders to mitigate, and responders to act when things go sideways. This has always been about data—getting the right people the right information at the right time.

I've built systems designed to reduce friction, perform the drudgery that bug hunters do at scale (before AI made this interesting), and tackle attack surface problems before ASM was a thing. In every case, success hinged on that fundamental principle: right people, right data, right time.

As we move into the AI age, this principle becomes more critical than ever. But there's a twist that changes everything about how we approach the problem.

> Now we need to give the right agent, the right task, at the right time. And crucially—we need to give that agent the right context at the right time.

## The Context Precision Problem

The industry conversation around "universal context" has created a dangerous misconception. When Daniel Miessler wrote about Unified Company Context (UCC), he captured something essential: "The more context you have about a problem, the less expertise you need to solve it." This insight represents one of AI's core promises for enterprise applications.

But here's the thing: **universal context doesn't mean the agent gets it all in one go**.

I've made dozens of POCs with what I call "dumb agents" and various agentic workflows—some successful, many not. I'm not talking about text processing, summarization, or marketing agents. Those seem fine for their domains. I'm trying to level up to more sophisticated security and development workflows, and the failures taught me more than the successes.

The POCs failed because I either:
- Couldn't give them the right context (the wrong prompt, wrong instructions or insufficient data)
- Gave them too much context (overwhelming volume)  
- Gave them problems too big to solve in one pass by one agent

But there's a crucial nuance here that took me a while to understand. Context precision isn't just about data volume or positioning—it's about matching the right **type** of context to the right agent. 

> Context encompasses multiple components: system prompts (how to behave), user prompts (what to do), data (information to work with) 

Task definition (scope of work) is an important element too but it's not, strictly speaking, context. My POCs failed when any of these components were mismatched.


Sometimes I gave a security scanner agent instructions meant for a vulnerability analyst. Sometimes I fed endpoint analysis data to a log correlation agent. Sometimes I wrote user prompts that assumed the agent had capabilities it doesn't have. And yes, sometimes the technical positioning mattered—Anthropic's Claude uses massive system prompts (24K+ tokens) successfully because static system prompts at the beginning of the context window get cached and processed optimally, while dynamic user data in the middle creates cognitive overload.

But the broader issue is **context component mismatch**. We have to think about agents as precisely what they are—specialized workers with cognitive limitations, not omniscient systems. Each component of context must align with the agent's specific function, capabilities, and cognitive constraints.

## The Research Behind the Intuition

This isn't just my experience. Current research validates what practitioners are discovering in production environments.

The foundational study "Lost in the Middle" by Liu et al. demonstrates that large language models suffer dramatic performance degradation when relevant information appears in the middle of long contexts. Even explicitly long-context models perform best when critical information occurs at the beginning or end of input sequences. When models must access information buried in the middle of extensive contexts, performance degrades significantly.

This research explains why massive static system prompts work fine while dynamic context causes problems. System prompts occupy the optimal beginning position and benefit from key-value caching techniques that avoid reprocessing the same instructions repeatedly. But when we dump variable user data and dynamic context into the middle of long sequences, we hit the cognitive limitations head-on.

Recent research reveals an even more troubling pattern: most open-source models demonstrate an effective context length less than 50% of their training length. This gap persists even in current 2025 models. Think of it like this: you train an AI to remember 100 things at once, but when you actually use it, it can only effectively work with 50 things. The root cause appears to be that during training, models see way more examples of short conversations than long ones—so when you give them really long text, they're working with "positions" they barely practiced.

The implications are clear. Longer context windows don't automatically improve performance—they often hurt it, especially when the content type and positioning don't align with how the model was actually trained.

## The Human Cognitive Parallel

This shouldn't surprise us. Human cognition research has documented similar limitations for decades.

Task switching in cognitive psychology reveals that performance degrades when people switch between different tasks. This disruption appears as slower performance and decreased accuracy when moving from Task A to Task B compared to repeating Task A. The phenomenon, known as "switch cost," persists even with advance warning of upcoming changes.

In practical terms, research shows it takes up to 9.5 minutes to return to productive workflow after switching between digital applications. Nearly half of workers report that context switching drains their productivity. René Marois's research at Vanderbilt University identified a "response selection bottleneck" in the brain when performing multiple tasks simultaneously—the brain must choose which activity takes priority, creating processing delays.

Ask me to juggle five complex, unrelated security or development tasks semi-simultaneously and you'll see the results. I can do it, but the context switching creates friction at best, confusion at worst. Even trying to hold a very large project entirely in mind becomes unwieldy. We break it up, work on chunks at a time, and maintain a minimal amount of overall context in our mental state machines while focusing on the immediate piece.

That's exactly what our AI systems need.

## Universal Context vs. Context Delivery

Universal context means the *potential* for an agent to access what it needs from the available information to do its job effectively. It doesn't mean dumping everything into the prompt window and hoping for the best.

This distinction matters because context windows remain a fundamental constraint, but the constraint isn't just about volume—it's about position, content type, processing patterns, and component alignment. A 24,000-token system prompt works fine at the beginning of the context window with proper caching, but the same volume of dynamic user data in the middle creates cognitive overload. More importantly, the right data with the wrong instructions, or the right instructions with the wrong agent, creates failures regardless of technical positioning.

Current 2025 research is tackling this head-on. Innovations like Infinite Retrieval and Cascading KV Cache are rethinking how LLMs process vast inputs, processing text in overlapping chunks while introducing novel strategies to retain critical information without storing everything. Q-Filters leverage Query-Key geometry to estimate attention scores and prune less critical key-value pairs, achieving 99% accuracy with 32x compression in needle-in-a-haystack tests.

Even with the latest models like Llama 4 Scout (claiming 10 million token context), Gemini 2.5 Pro (1-2 million tokens), and Claude 4 (200K tokens), the fundamental challenge remains: larger context windows don't automatically translate to better performance. Early reports from developers testing Llama 4's massive context suggest that effective utilization still falls short of theoretical capacity. These advances validate the core insight: the solution isn't bigger context windows, it's smarter context management that aligns all components properly.

## Lessons I Learned: Three Projects, Three Breakthroughs

### Jalapi: The Context Chunking Breakthrough

Working on Jalapi, I initially tried to feed entire JavaScript files into a single agent context for API endpoint discovery. The goal was analyzing client-side JavaScript code to find hardcoded backend API endpoints for security testing. Performance was terrible—the agent would get lost in irrelevant code sections, miss actual API calls, and flag static assets or tracking pixels as endpoints.

The breakthrough came from strategic context chunking. Instead of processing massive JavaScript files whole, I implemented a system that breaks code into 3000-character chunks with 1000-character overlap to avoid missing endpoints split across boundaries. The system extracts configuration blocks separately and includes them as targeted context with each chunk. This approach treats static configuration information differently from dynamic code analysis, positioning essential context optimally while keeping variable content focused and minimal.

**Key Implementation Principles:**
> - Extract configuration blocks separately from main content
> - Use strategic overlap between chunks, not comprehensive loading  
> - Match context granularity to agent function specificity
> - Position static context optimally, minimize dynamic context volume

### Honeycomb: Chain-of-Density Context Management

My log analysis agent initially tried to process entire log sets with full system context—user behavior patterns, system architecture, threat intelligence, and historical incidents all loaded simultaneously. The agent would get lost in irrelevant correlations and miss obvious patterns.

The refactored approach implemented what I call "chain-of-density context management," adapted from Anthropic's research but applied to security analysis. The first chain focuses purely on metrics collection with minimal context. The second chain takes those metrics and adds relevant pattern libraries. The third chain receives output from previous stages plus targeted threat intelligence. Finally, a synthesis chain combines all previous outputs with business context. Each processing stage builds on previous stages while maintaining focused context for its specific function.

The modular approach not only improved accuracy but enabled parallel processing and better error isolation. This pattern—progressive context building through specialized stages—is something you start seeing everywhere once you understand it. Each stage gets precisely what it needs without cognitive overload from irrelevant information.

**Key Implementation Principles:**
> - Progressive context building through specialized processing stages
> - Each stage receives minimal context needed for its specific function
> - Output from previous stages becomes input context for next stages
> - Final synthesis stage combines all outputs with business context

### Nerve: Orchestrated Context Coordination

Rather than a single agent trying to handle reconnaissance planning, tool execution, and result analysis simultaneously, Nerve changed the game by using an orchestrator pattern with simpler, more focused agents. The breakthrough insight: agents needed shared understanding of the overall objective while maintaining focused context for their specific responsibilities.

The orchestrator maintains the big picture and coordinates between specialists, while each agent operates within carefully defined context boundaries. The discovery planner receives target specifications and available tools but excludes previous results. The content analyzer gets tool outputs and analysis patterns but excludes target details. The orchestrator ensures information flows correctly between agents while preventing context contamination. This coordination pattern allowed each agent to excel at its specialty without cognitive overload, and debugging became much simpler because problems could be isolated to specific agents with known context boundaries.

**Key Implementation Principles:**
> - Central orchestrator maintains overall context and coordination
> - Individual agents operate within carefully defined context boundaries
> - Information flows through orchestrator to prevent context contamination
> - Agent failures can be isolated without cascading through entire workflow

## The ASMP Connection

This problem isn't entirely new. Before AI made it interesting, Application Security Posture Management (ASPM) vendors were attempting to solve a related challenge: creating unified context across security tools and processes for better decision-making.

ASPM approached this through data integration and correlation—bringing together code analysis, dependency management, runtime behavior, and configuration data into unified dashboards. The insight was correct: security decisions require context across multiple domains.

But ASPM faced the same fundamental challenge we're seeing with AI agents: how do you present the right slice of unified context for specific decision-making moments? Even with perfect data integration, human analysts still needed focused views tailored to their immediate tasks. AI agents face this same challenge, except they're even more sensitive to context overload than human analysts.

## Getting Started

If you're building agentic systems today, here's some thoughts:

**Start with Task Analysis**: Before designing context delivery, clearly define what each agent needs to accomplish and what information is essential versus supplementary for that function. This forces precision in thinking about the cognitive work being performed.

**Start with Smallest Unit of Work**: Begin by identifying the smallest reasonable unit of work your agent needs to perform. Keep decomposing the problem until you cannot break it down further without losing essential coherence.

**Define Precise Agent Functions**: Specify exactly what cognitive work each agent performs, not just what data it accesses. Each agent should have one clearly defined cognitive task with specific scope boundaries.

**Match Agent Type to Task**: Ensure your agent capabilities align with task requirements precisely. Don't try to make a security scanner do vulnerability analysis work, or feed log correlation data to an endpoint analysis agent.

**Align All Context Components**: Make sure system prompts (how to behave), user prompts (what to do), data (information to work with), and task definition (scope of work) all work together. Misalignment in any component creates failures regardless of technical positioning.

**Right-Size Context to Task**: Complex tasks often need minimal focused context while simple correlation tasks might need broader context. Position static context optimally at the beginning, minimize dynamic context volume in the middle.

**Design for Coordination and Debugging**: Set up orchestration patterns where central coordination maintains overall context while individual agents operate within carefully defined boundaries. Design for error isolation from the start.

**Test Context Scientifically**: Use evaluation tools like PromptFoo to systematically test different context combinations. Measure agent performance across varying context volumes, component combinations, and positioning strategies to validate your design decisions.

## Troubleshooting Common Context Issues

If your agents aren't performing as expected, here are a few practical things to check:

**Agent seems confused or asks for info it should have**: You're probably not giving it enough context. Double-check that essential information is actually included in the prompt, not just available somewhere in your system.

**Agent takes forever or mentions random irrelevant stuff**: Too much context is overwhelming it. Try trimming down to just what's needed for the specific task, or break the work into smaller pieces.

**Agent gives technically correct but useless responses**: Your context components are misaligned. Check if you're using the right system prompt for this agent type, or if you're feeding it data meant for a different kind of task.

**Agent focuses on the wrong timeframe or domain**: Your static and dynamic context boundaries are blurry. Make sure configuration stays separate from real-time data, and that you're clear about what information applies to which part of the task.

Most of these get caught when you test systematically, but if something feels off during development, these patterns can help you pinpoint where the context delivery is breaking down.

## Looking Forward

I think Daniel Miessler is right about UCC becoming the foundation of enterprise AI. The competitive advantage will belong to organizations that can build and maintain comprehensive context about their operations—from asset inventory to vulnerability management to threat intelligence to business processes.

But the companies that win won't just have the best universal context. They'll have the best universal context *precision*. They'll understand how to deliver exactly the right context components to each agent for each task—the right instructions, the right data, the right scope, all aligned with the agent's specific capabilities and cognitive constraints.

This creates two distinct but related problems:

1. **Building Universal Context**: Integrating data across traditionally siloed systems to create comprehensive organizational knowledge
2. **Context Delivery Optimization**: Determining what subset and type of universal context each agent needs for effective task completion

Solving only the first problem gets you a data lake. Solving both gets you effective AI agents.

Instead of assuming more information leads to better decisions, we're learning to optimize the relationship between information relevance, cognitive capacity, and task alignment.

The parallel to human cognition isn't coincidental. Effective knowledge work has always required the ability to focus on relevant information while maintaining awareness of broader context. The most productive professionals aren't those who try to hold everything in mind simultaneously—they're those who can quickly access the right information for immediate needs while maintaining situational awareness.

AI systems face the same fundamental challenge, except they're even more sensitive to context overload and have less intuitive filtering mechanisms. The time gap I spent ten years trying to shorten isn't going away—it's evolving and accelerating. The organizations that master context precision will have agents that can operate effectively within complex environments without becoming overwhelmed by information volume or confused by misaligned context components. This represents a significant competitive advantage as AI capabilities become commoditized.

---

## Appendix: Emerging Solutions and Research Directions

The 2025 research landscape is validating these approaches with concrete innovations:

**Memory-Efficient Attention**: Cascading KV Cache methods achieve 12.13% average improvement in LongBench benchmarks and 4.48% boost in book summarization while reducing prefill stage latency by a factor of 6.8 compared to Flash Attention 2.

**Intelligent Context Compression**: Advanced systems are moving beyond simple chunking to semantic understanding of which information matters for specific tasks. Research shows that even models with massive claimed context windows (like Llama 4 Scout's 10M tokens or Gemini 2.5 Pro's projected 2M tokens) still struggle with effective utilization across the full window.

**Position-Aware Training**: Researchers are addressing the left-skewed distribution problem through techniques like StRing (Strategic Training) that strategically overwrite position indices in the upper range of training length, achieving substantial performance enhancements across seven open-source LLMs with an average score increase of 18 points.

---

## References

Liu, N. F., Lin, K., Hewitt, J., Paranjape, A., Bevilacqua, M., Petroni, F., & Liang, P. (2024). Lost in the Middle: How Language Models Use Long Contexts. *Transactions of the Association for Computational Linguistics*, 12, 157–173.

BigGo News. (2025). Claude's Massive 24K Token System Prompt Leaked: Revealing How Anthropic's AI Assistant Works. Retrieved from https://biggo.com/news/202505070712_Claude_System_Prompt_Leaked

IBM Research. (2025). Why larger LLM context windows are all the rage. Retrieved from https://research.ibm.com/blog/larger-context-window

Hsieh, C. K., et al. (2024). Why Does the Effective Context Length of LLMs Fall Short? arXiv preprint arXiv:2410.18745.

Flow AI. (2025). Advancing Long-Context LLM Performance in 2025 – Peek Into Two Techniques. Retrieved from https://www.flow-ai.com/blog/advancing-long-context-llm-performance-in-2025

---

*This exploration of agent context management builds on themes from my previous work on AI-assisted development, systematic prompt engineering, and the evolving role of the hacker-strategist in cybersecurity.*
