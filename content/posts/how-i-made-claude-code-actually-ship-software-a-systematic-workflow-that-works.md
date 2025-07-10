---
title: "How I Made Claude Code Actually Ship Software: A Systematic Workflow That Works"
date: 2025-07-10
categories: [ai, development, workflow]
tags: ["claude-code", "workflow", "development", "systematic", "shipping", "hooks"]
draft: false
description: "Building a systematic Claude Code workflow with commands, quality gates, and evidence-based completion that consistently ships working software."
---

## TL;DR

- **Claude Code is powerful, like really.. but chaotic without *some* structure.** Many people probably use it an ad-hoc fashion and there's nothing wrong with that. I built a systematic workflow that turns it into a shipping machine.

- **The magic is in the command structure.** `/plan-iteration` → `/plan-task` → implement → `/complete-task` → `/complete-iteration`. Each command has specific responsibilities and quality gates.

- **Evidence-based completion prevents the "is it done?" problem.** `/complete-iteration` requires concrete proof that users can access working software. No more marking things "complete" when they're just coded.

- **Memory-driven context loading keeps sessions focused.** Load exactly what you need for the current task instead of dumping your entire project history into every conversation.

- **Hooks close the auto-accept gap.** Real-time quality checks run outside Claude's context but feed back decisions to block bad edits. Finally safe to enable auto-accept mode.

- **Current iteration files live in project root.** When iteration is complete, everything archives to `.claude/archives/iteration-N/` with evidence summary. Clean slate for next iteration.

## The Claude Code Focus

This post focuses specifically on the Claude Code implementation side of my workflow. There's an entire ideation and architecture design phase that happens in Claude Desktop - feature evolution, backlog integration, composition thinking - but that's a different topic I'll cover in another post. Here we're talking about what happens once you know what to build and need to systematically ship it.

## The Problem: Claude Code Without Structure

Many people I see using Claude Code treat it like, idk, a genie?  - "build me a REST API," "add authentication," "fix this bug." That works for small stuff, but it breaks down when you're trying to ship software with multiple iterations and evolving requirements.

The issues I kept hitting:

**Context Explosion**: Each conversation would start from scratch or I'd dump massive context files. Claude would lose track of what was important versus historical noise. I explored this problem in ["Claude Code Memory Optimization"](https://labs.voidwire.info/posts/claude-code-memory-optimization/) - how context boundaries matter for effective AI assistance.

**The "Is It Done?" Problem**: I'd build something, think it was finished, then realize users couldn't access it. Or worse, mark features complete when they were just coded but not deployed.

**Quality Randomness**: Sometimes Claude would write great code, sometimes garbage. No systematic way to catch problems before they accumulated.

**Monolithic Planning Bloat**: I used to start projects with massive HLD and SPEC documents that tried to plan everything upfront. After a few tasks, we'd need to pivot, but the approach was too bloated and rigid. The documents became anchors instead of guides.

I needed Claude Code to work like a systematic development process, not just an AI pair programmer.

## The Command Structure That Works

The change was building commands with specific responsibilities and quality gates. Here's the flow that consistently ships working software:

### `/load-app-context` - Smart Context Loading

**What it does**: Loads exactly the context needed for current work
**How it's different**: Reads from symlinked files, loads language-specific config, understands feature status

```bash
# Loads current iteration state
/load-app-context

# Result: Claude knows current HLD, SPEC, TASKS
# Plus project-specific context and language preferences
# Zero manual context dumping
```

**The difference**: Most context loading is noise. This command loads current iteration artifacts + project memory, skips historical junk. Related to ideas I explored in ["Claude Code Memory Optimization"](https://labs.voidwire.info/posts/claude-code-memory-optimization/) about structured context across three layers, though memory got much easier when I switched to hooks.

### `/plan-iteration` - Interview-Driven Planning

**What it does**: Takes planned features → creates HLD + IMPLEMENTATION_SPEC + TASK_LIST
**The magic**: Interview format with approval gates, not just "figure it out"

```bash
/plan-iteration

# Claude asks: "Looking at your planned features, which should we tackle this iteration?"
# You approve scope
# Claude generates: HLD.md, IMPLEMENTATION_SPEC.md, TASK_LIST.md
# Files go in project root, marked 🔄 In Progress
```

**Why this works**: Human-guided scope definition prevents feature creep. Approval gates mean you own the decisions. Generated artifacts become source of truth for implementation. This builds on patterns I wrote about in ["The Interview Pattern: Why AI Should Ask Before It Acts"](https://labs.voidwire.info/posts/the-interview-pattern-why-ai-should-ask-before-it-acts/) - structured interviews surface assumptions early instead of discovering problems after implementation.

### `/plan-task [description]` - Deep Implementation Planning

**What it does**: Takes a task from TASK_LIST → creates detailed implementation plan
**When to use**: Complex tasks that need architectural thinking

```bash
/plan-task "Build endpoint scanner with httpx integration"

# Claude analyzes: dependencies, patterns, testing approach
# Creates: step-by-step implementation plan with quality requirements
# You approve before implementation starts
```

**What makes this work**: Separate planning from coding. When Claude understands the approach before writing code, the code quality goes way up. This connects to ideas I explored in ["Force Your LLM to Spike"](https://labs.voidwire.info/posts/force-your-llm-to-spike/) about making LLMs do research spikes before implementation to induce engineering behavior instead of just coding.

### `/complete-task [description]` - Quality Gate Validation

**What it does**: Validates specific task completion with tests, coverage, quality standards
**Why essential**: Catches problems task-by-task instead of at iteration end

```bash
/complete-task "Build endpoint scanner with httpx integration"

# Claude checks: tests passing, coverage thresholds, code quality
# Validates: integration with existing code, error handling
# Updates: TASK_LIST.md with completion status
```

**The difference**: Quality built in during development, not bolted on later.

### `/complete-iteration` - Evidence-Based Completion

**What it does**: Validates all tasks complete → archives iteration → updates feature status
**The critical part**: Requires evidence that users can access working software

```bash
/complete-iteration

# Claude validates: all tasks marked complete
# Archives: HLD.md, SPEC.md, TASKS.md → .claude/archives/iteration-N/
# Creates: SUMMARY.md with evidence of user accessibility  
# Updates: IDEA.md feature status 🔄 → ✅
```

**Why this matters**: Prevents marking features "done" when they're just coded but not deployed. Forces shipping behavior. This approach emerged from lessons in ["The Systematic Breakthrough"](https://labs.voidwire.info/posts/the-systematic-breakthrough/) about outcome delivery versus task completion.

## The File Management System

Here's what makes the workflow clean:

### Current Iteration = Project Root

```
~/development/projects/security-analyzer/
├── [source code]
├── HLD.md                    # Current iteration design
├── IMPLEMENTATION_SPEC.md    # Current iteration spec  
├── TASK_LIST.md             # Current iteration tasks
└── .claude/
    ├── artifacts/
    │   └── IDEA.md → (symlinked)  # Live feature status
    └── archives/
        ├── iteration-1/       # Completed iterations
        ├── iteration-2/
        └── iteration-N/
```

**What this does**: Current work lives where you can see it. Completed work gets archived with evidence. Clean separation.

### When `/complete-iteration` Runs

1. **Validates** all tasks in TASK_LIST.md are marked complete
2. **Archives** HLD.md, SPEC.md, TASKS.md → `.claude/archives/iteration-N/`
3. **Creates** SUMMARY.md with evidence of working software
4. **Updates** IDEA.md feature status from 🔄 In Progress → ✅ Built
5. **Cleans** project root for next iteration

**Result**: Every iteration starts with clean slate, previous work preserved with evidence.

## Memory-Driven Context Loading

This was a game-changer. Instead of dumping massive context files, each workflow loads exactly what it needs:

### Language-Specific Memory

Located in `/ai/development-workflow/claude/memory/`:
- `python/CLAUDE.local.md` - Python preferences with critical setup warnings
- `golang/CLAUDE.local.md` - Go development patterns
- `web/python/CLAUDE.local.md` - Full-stack Python patterns

**Example critical warning from Python config**:
```
🚨 CRITICAL: Virtual Environment Hell - READ THIS FIRST 🚨

🛑 NEVER DO THIS:
- Run python or pip directly without checking environment

✅ ALWAYS DO THIS:
- Use uv run python instead of bare python commands

🔥 IF YOU FUCK THIS UP: You'll waste 30+ minutes debugging import errors
```

**The value**: Language-specific memory prevents time-wasting setup mistakes that kill momentum. I wrote about the evolution from ad-hoc context creation to systematic generation in ["Claudex: From Ad-Hoc Context Creation to Repeatable Generation"](https://labs.voidwire.info/posts/claudex-from-ad-hoc-context-creation-to-repeatable-generation/) - though these CLAUDE.local.md files are much lighter now since [claudex-guard](https://github.com/nickpending/claudex-guard) handles detailed enforcement.

### Project-Specific Context

Each project gets `CLAUDE.md` with project-specific patterns and `CLAUDE.local.md` symlinked to language config.

**What this shows**: Generic advice is useless. Specific context about your project's patterns and your language preferences is what helps.

## Hooks: Closing the Auto-Accept Gap

The biggest workflow change was adding real-time quality enforcement through hooks.

### The Problem

Even with systematic commands, there was still this gap: Claude writes code → you either manually review every edit (kills velocity) or enable auto-accept and hope problems get caught later.

### The Solution: claudex-guard

I built [claudex-guard](https://github.com/nickpending/claudex-guard) as a PostToolUse hook that runs after Claude writes code but before you see results:

```json
{
  "decision": "block",
  "reason": "Quality violations found (2 errors):\n• example.py:1 - Mutable default argument in function 'process_items'\n  Fix: Use None default, check inside function\n• example.py:4 - Use httpx instead of requests (async-first, HTTP/2 support)"
}
```

**What it catches**:
- Python gotchas (mutable defaults, old string formatting)
- Banned libraries (requests instead of httpx, pip instead of uv)
- Project-specific pattern violations
- Code quality issues specific to your development philosophy

**The workflow impact**: Can finally enable auto-accept mode safely. Real-time enforcement that understands your standards, not just generic linting. I wrote about this approach in ["Building My First Claude Code Hook: Closing the Hope and Pray Gap"](https://labs.voidwire.info/posts/building-my-first-claude-code-hook-closing-the-hope-and-pray-gap/).

## Quality Gate Commands

Beyond the core workflow, there's a specialized command for security-sensitive work:

### `/security-check` - Security Validation
- Vulnerability scanning before shipping security-sensitive features
- Dependency checking for known CVEs
- Code pattern analysis for common security mistakes

**When to use**: Call this before `/complete-task` when shipping security-sensitive features that need extra validation confidence.

## The Systematic Difference

### Before: Ad-Hoc Claude Code Usage

```
"Build a REST API"
→ Claude writes some code
→ "Now add authentication"  
→ More code
→ "Is this done? I guess?"
→ Deploy and hope
```

### After: Systematic Workflow

```
/load-app-context
→ /plan-iteration (interview + approval)
→ /plan-task "Build REST endpoints" (detailed planning)
→ implement according to plan
→ /complete-task "Build REST endpoints" (quality gates)
→ /plan-task "Add authentication" 
→ implement with hooks enforcing standards
→ /complete-task "Add authentication"
→ /complete-iteration (evidence-based completion)
→ ship with confidence
```

**The difference**: Every step has purpose, quality gates, and evidence requirements. No "hope and pray" moments.

## Results: What Ships

Since implementing this workflow:

**Iteration Velocity**: Projects move from idea → working software in days, not weeks
**Quality Consistency**: Real-time enforcement catches problems before they accumulate  
**Context Clarity**: Always know what's current vs historical
**Shipping Confidence**: Evidence-based completion means when it's marked done, it's accessible to users

**What this covers**: Claude Code is powerful when you give it systematic structure. Without structure, it's expensive autocomplete.

## The Uncomfortable Reality

Even with this systematic approach, I'm still very much in "human-guided AI development" territory. The workflow requires constant human decisions, approval gates, and quality validation. We're nowhere near "tell Claude to build an app and come back tomorrow."

But that's the point. This workflow amplifies human engineering judgment through systematic AI assistance. It's not about replacing human developers - it's about building reliable patterns for AI-assisted development that consistently ship working software.

This connects to themes I explored in ["The Indispensable Human in the Middle"](https://labs.voidwire.info/posts/the-indispensable-human-in-the-middle/) and ["Architecting Security's Future: Why Hacker-Strategists Will Lead the AI Evolution"](https://labs.voidwire.info/posts/architecting-securitys-future-why-hacker-strategists-will-lead-the-ai-evolution/) about systematic AI workflows requiring human expertise, not replacing it.

The future belongs to developers who can build these kinds of systematic workflows, not those hoping AI will become autonomous.

---

**Implementation details:** Stay tuned - I'm working on sanitizing and releasing the complete command structure, templates, and setup process.

**Hook enforcement:** [claudex-guard](https://github.com/nickpending/claudex-guard) for real-time quality checking outside Claude's context.
