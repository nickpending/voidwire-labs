---
title: "Beyond Prompting: Why LLMs Break Down on Well-Architected Code and How Composition Saves Development"
date: 2025-06-10
categories: [ai, development]
tags: ["ai", "development", "composition", "unix-philosophy", "claude-code", "architecture"]
draft: false
description: "How we discovered that LLM limitations reveal fundamental truths about software architecture in the AI era"
---

*How I discovered that LLM limitations reveal fundamental truths about software architecture in the AI era*

## The Breaking Point Isn't What You Think

After months of AI-assisted development, I hit a wall that had nothing to do with prompting skills or context limits. The problem was deeper and more fundamental: **LLMs lose their minds when applications exceed their cognitive capacity**.

I wasn't building monoliths. My applications had proper separation of concerns, clean data models, comprehensive tests, and type safety. The repository pattern, service layers, configuration management - all the architectural best practices were there. But as these well-structured applications grew in complexity, something strange happened.

Claude would start strong - confident, precise implementations. Then, as the codebase accumulated files, dependencies, and interconnections, the responses became hesitant. Code quality degraded. Simple changes would take multiple iterations. Eventually, Claude would give up mid-implementation with apologetic phrases like "this should cover the basic requirements" - the AI equivalent of cognitive exhaustion.

The solution wasn't better architecture or smarter prompting. It was recognizing that **when your development partner has cognitive constraints, you need to design around those constraints**.

## The Workflow Refinement Journey

Initially, I thought better prompting would solve everything. I spent months refining my development workflows, iterating through different approaches based on each failure mode I encountered. Each time Claude hit a wall, I'd revise my process:

- **First iteration**: Better context organization and prompt structure
- **Second iteration**: Systematic validation and quality checks ([detailed in my analysis of LLM development patterns](https://labs.voidwire.info/the-systematic-breakthrough/))
- **Third iteration**: Memory optimization and selective context loading ([explored in my work on context management](https://labs.voidwire.info/claude-code-memory-optimization/))
- **Fourth iteration**: Embedding security checks into the development flow ([covered in my ambient security approach](https://labs.voidwire.info/making-security-ambient-seamless-checks-in-the-age-of-vibe-coding/))

Each refinement helped, but the fundamental problem persisted: **well-architected systems were still overwhelming LLMs**. The issue wasn't process - it was cognitive architecture.

This pattern isn't unique to my experience. Cloudflare's recent open-source OAuth library, built almost entirely with Claude, shows the same phenomenon. As Mitchell documented in ["I Read All Of Cloudflare's Claude-Generated Commits"](https://www.maxemitchell.com/writings/i-read-all-of-cloudflares-claude-generated-commits/), even their successful AI collaboration required constant human intervention for complex interconnections, with Claude struggling on tasks like "moving class declarations" and "search-and-replace with duplicate code blocks" - exactly the kind of cognitive overload I was experiencing.

## The Monolithic Revelation

The breakthrough came during what should have been a straightforward security analysis project. I had a well-architected system with proper separation of concerns, comprehensive tests, and clean interfaces. Everything you'd want in production code. 

Claude spent **weeks** on what should have been manageable changes. Not because the code was bad, but because holding the mental model of this interconnected system exceeded its cognitive capacity.

**The Well-Architected Approach** (what was overwhelming Claude):
```
security-analyzer/
├── analysis/ (8 modules for intelligence extraction)
├── catalog/ (content generation and management)
├── cli/ (7 command modules + utilities)
├── enrichment/ (4 modules for vector processing)
├── models/ (5 shared data model files)
├── prompts/ (3 template engine modules)
├── testing/ (4 Docker testing modules)
└── workflow/ (5 orchestration modules)
```

Here's what Claude had to track simultaneously:
- CLI commands connecting to analysis services
- Intelligence extraction with LLM integration
- Docker testing with safety validation
- Vector enrichment and embedding generation
- Template engines for prompt generation
- Workflow orchestration across all components

Every change required understanding how modifications would ripple through this entire system. **The cognitive load was crushing**, even for well-structured code.

## The Unix Insight: Cognitive Architecture

The solution came from an unexpected place: Unix composition principles. Of course a 40-year-old paradigm would come to the rescue! But not for the traditional reasons of modularity or reusability. Unix tools work because each one is **cognitively manageable** - you can understand `grep` completely, reason about its behavior precisely, and compose it confidently without mental overload.

This insight aligns with recent research on LLM limitations. As documented in ["When Thinking Fails: The Pitfalls of Reasoning for Instruction-Following in LLMs"](https://arxiv.org/abs/2505.11423), explicit reasoning can actually degrade performance when it diverts attention from core requirements. The paper introduces "constraint attention" - how much models focus on actual requirements versus getting lost in complexity. In monolithic systems, LLMs literally pay less attention to specific tasks because they're overwhelmed by system-wide concerns.

This isn't about avoiding bad architecture. It's about **cognitive architecture** - designing systems that fit within the cognitive capacity of your development partner, whether that's a human or an LLM.

**The Cognitive Boundary Principle:**
- Each tool should be small enough to hold its complete mental model
- Data contracts create **cognitive firewalls** - clear boundaries where you can stop reasoning about external complexity
- Complex functionality emerges from tool composition, not internal complexity

## The Composition-First Transformation

I rebuilt my development methodology around cognitive boundaries:

### 1. Tool Boundaries as Mental Model Boundaries

Instead of asking "How do I build this system?", ask "What focused tools solve this problem?"

**After (Cognitive Clarity):**
```
security-prompt/     # Generate research prompts for Claude Desktop
security-test/       # Execute commands safely in Docker containers  
security-analyze/    # Extract security intelligence using LLMs
security-enrich/     # Create vector embeddings for semantic search
security-shared/     # Common utilities and configuration
```

The theory: each tool should be small enough to hold its complete mental model within cognitive capacity - focused enough that an LLM can understand the entire component without overwhelming complexity.

### 2. Data Contracts as Cognitive Firewalls

Tools communicate through documented JSON schemas, not internal coupling. This eliminates the need to understand implementation details of other components.

When implementing the analysis tool, an LLM doesn't need to understand:
- How prompt generation works with template engines
- Docker testing infrastructure details
- Vector embedding generation processes

It just needs to understand: **"Take ResearchOutput JSON + TestResults JSON, analyze with LLM, output IntelligenceAnalysis JSON."**

### 3. The Extract-Tools Bridge

The missing piece was bridging human ecosystem thinking with LLM implementation needs. When you design with Claude Desktop, you think in terms of overall capabilities and data flows. But LLMs need focused, self-contained documentation.

My `/extract-tools` command transforms ecosystem-level design into tool-specific implementation docs - taking a neighborhood blueprint and generating individual house construction plans.

## The Development Workflow Revolution

I built a systematic workflow operating at two cognitive levels:

### Phase 1: Ecosystem Design (Claude Desktop)
- **`/brainstorm [concept]`** - Think in tool boundaries and data flows
- **`/create-architecture`** - Design complete tool ecosystem
- **`/create-hld`** - High-level design focused on composition  
- **`/create-tasks`** - Break work into individual tools

### Phase 2: Tool Implementation (Claude Code)
- **`/extract-tools`** - Generate focused docs for each tool
- **`/plan-task`** - Implement one tool with complete cognitive focus
- Additional commands handle quality checks, decision tracking, and context management
- Each tool gets self-contained documentation an LLM can fully comprehend
- No cognitive overload from ecosystem complexity

This two-phase approach addresses the core insight from my systematic LLM development research: that [step-by-step reasoning often fails catastrophically](https://labs.voidwire.info/the-systematic-breakthrough/) when applied to complex, interconnected systems. By separating architectural thinking from implementation, we keep each phase within appropriate cognitive bounds.

## Testing the Theory: Early Results

The composition-first approach appears promising, though I'm still validating the approach:

- **Prompt generator** - Research prompt creation with security focus (early implementation suggests this is more manageable)
- **Test executor** - Docker-based command testing with safety validation (in development)
- **Intelligence analyzer** - LLM-powered intelligence extraction (planned)
- **Vector enricher** - Embeddings for semantic search (planned)

The hypothesis is that each tool, with complete and independent documentation, should be something an LLM can fully understand. Early signs suggest Claude remains more focused and confident when working within these bounded contexts, but the full validation is still in progress.

This mirrors Cloudflare's experience, where as Mitchell noted, "Almost every feature required multiple iterations and refinements" in their monolithic approach. The composition model eliminates much of this iteration overhead by keeping each component within manageable cognitive bounds.

## The Deeper Implications

This isn't just about LLM development - it's about **software architecture for the AI era**. I've discovered that composition-first architecture isn't just good engineering; it's **cognitive architecture** that matches how intelligence actually works.

### The Shipping Velocity Breakthrough

**Traditional Well-Architected System:**
- Weeks for complex refactors
- Constant context switching and cognitive overload
- Multiple iterations due to LLM uncertainty
- Difficult human code review due to system complexity

**Composition-First System (Theory):**
- Potentially much faster development for equivalent functionality
- LLMs should remain confident and productive within bounded contexts
- Human reviewers should be able to understand individual tools
- Independent deployment and testing of components

### The Review Revolution

When a security tool does one thing well in 300 lines, a human can:
- Understand the complete behavior
- Spot security implications
- Verify correctness end-to-end
- Approve with confidence

Compare that to reviewing changes in a system where understanding requires holding multiple service layers, template engines, and workflow orchestrators in your head simultaneously.

## The Paradigm Worth Exploring

This approach won't work for every solution. **Composition-first development** seems particularly powerful for:

**✅ Excellent fits:**
- Data processing and analysis pipelines
- Security tools and automation systems
- Command-line utilities and workflows
- Research and intelligence platforms
- Content management and processing

**❌ Challenging applications:**
- Real-time systems requiring tight coupling
- UI-heavy applications with complex interactive state
- Performance-critical systems where composition overhead matters
- Simple scripts that genuinely don't need decomposition

## The Meta-Innovation: Systematic AI Development

What emerged isn't just better composition - it's **development methodology as code**. The entire process from ideation to implementation is systematized through commands, templates, and cognitive boundaries.

This represents an evolution from the [memory optimization approaches](https://labs.voidwire.info/claude-code-memory-optimization/) I explored earlier. Rather than just managing context better, I'm designing systems that require less context to understand.

This enables:
- **Repeatable excellence** instead of hoping for good prompts
- **Architectural consistency** through template-driven design
- **LLM-optimized scope** keeping tools within cognitive capacity
- **Systematic quality** through built-in cognitive firewalls

## The Future of AI-Native Architecture

In the AI development era, successful applications will be those that AI can understand, reason about, and improve. Composition-first development achieves this not by dumbing down architecture, but by **matching system design to cognitive architecture**.

As I explored in ["The Indispensable Human in the Middle"](https://labs.voidwire.info/the-indispensable-human-in-the-middle/), the future isn't about AI replacing human developers, but about creating development processes where humans and AI can collaborate effectively. Composition-first architecture enables this collaboration by providing cognitive boundaries that both humans and AI can work within confidently.

The applications that win will be built from components that both humans and AI can fully comprehend. When your development partner has cognitive constraints, you don't fight those constraints - you design elegant systems that work within them.

**Start with cognitive boundaries:**
1. Take your next project idea
2. Ask: "What focused tools could solve this without cognitive overload?"
3. Design data contracts that create cognitive firewalls
4. Build one tool at a time within clear cognitive boundaries
5. Let composition create complexity while keeping implementation manageable

## Conclusion: Architecture for Intelligence

I've discovered something that seems profound: the future of software architecture isn't about building more sophisticated systems - it's about building systems from cognitively manageable components that create sophisticated behavior through intelligent composition.

Of course a 40-year-old paradigm would come to the rescue! The Unix philosophy succeeded not just because of technical elegance, but because it matched how intelligence actually works - whether human or artificial. When faced with complex problems, intelligence thrives by focusing on manageable pieces that compose into powerful solutions.

In the age of AI-assisted development, this insight becomes essential. The most effective developers won't be those who resist AI limitations or those who accept poor quality - they'll be those who architect systems that amplify AI capabilities while respecting AI constraints.

Your LLM partner isn't getting "tired" - it's experiencing cognitive overload. Design for cognitive capacity, and watch both code quality and development velocity transform.

---

## References

1. Max Mitchell - ["I Read All Of Cloudflare's Claude-Generated Commits"](https://www.maxemitchell.com/writings/i-read-all-of-cloudflares-claude-generated-commits/) - Real-world analysis of AI-assisted development challenges

2. Xiaomin Li et al. - ["When Thinking Fails: The Pitfalls of Reasoning for Instruction-Following in LLMs"](https://arxiv.org/abs/2505.11423) - Research on cognitive overload in language models

3. ["The Systematic Breakthrough"](https://labs.voidwire.info/the-systematic-breakthrough/) - Analysis of systematic vs intuitive LLM development approaches

4. ["Claude Code Memory Optimization"](https://labs.voidwire.info/claude-code-memory-optimization/) - Exploration of context management strategies in AI development

5. ["Making Security Ambient: Seamless Checks in the Age of Vibe-Coding"](https://labs.voidwire.info/making-security-ambient-seamless-checks-in-the-age-of-vibe-coding/) - Integration of quality checks into AI development workflows

6. ["The Indispensable Human in the Middle"](https://labs.voidwire.info/the-indispensable-human-in-the-middle/) - Human-AI collaboration patterns in development
