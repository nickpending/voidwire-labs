---
title: "Projects"
date: 2026-10-28
draft: false
---

What I'm building, grouped by what it's for. Most of it is private; the entries say which. The retired list at the end is where the current work came from.

## Finding vulnerabilities

### Polyharness <small>private, built at work</small>

A pipeline that hunts for real vulnerabilities in production source code using AI: it maps a codebase's attack surface, runs dozens of AI agents in parallel against it, and validates every claimed finding in isolated containers so no agent ever grades its own work. Any vendor's model plugs into it in about a day, which is also what makes it the measuring instrument: it's how we test which AI models and vendor products actually find serious, confirmed vulnerabilities, at what cost.

### Surveyor <small>private, built at work</small>

The profiler that runs before anything else does. Given a repo, or a portfolio of them, it produces the structural ground truth every downstream consumer needs: the system map, the code graph, the decomposition into frozen focus areas, and packaged context. Extraction is bought; interpretation is agentic.

### Manifaces <small>private</small>

Read the policy the browser ships. Test whether the server agrees. Manifaces works from the outside with no source access: it downloads an application's browser-visible files, recovers the surface and behavior they expose, and hands that shared evidence to purpose-built hunters for enumeration, IDOR and information disclosure. It is deliberately not a signature scanner. A status code is not proof, a sensitive-looking string is not automatically a vulnerability, and a model's conclusion is not evidence; requests, stored bodies, controls, citations and independent triage are.

### Ward <small>private</small>

Turns a vulnerability advisory into a defensible outcome. Given a CVE, it proves whether the vulnerability is actually live in a given environment, builds a mitigation, and then attacks its own mitigation to find out whether it holds. Every claim is verified against a faithful environment, never against assumptions derived from the check itself. Agents are leaves; orchestration is code.

## Doctrine and documents

### Waystone <small>private</small>

The AI-engineering doctrine: a curated, wikilinked corpus of what has been built with AI, what happened, and the rules, patterns and architectures those outcomes earned. Authored for agents first. An agent arrives at design time asking what kind of problem it has, and the corpus answers with what has worked for that class of problem and what it rests on. A cairn marks something true where a traveler stood; a waystone is set deliberately to keep the next traveler on the path.

### Galley <small>private, for now</small>

Check the proof before it prints. Galley compiles plain markdown into claim-first technical documents, the kind where every figure states what it proves and every number carries provenance, and the same source produces a print-clean PDF and a dark-mode HTML page without anyone touching a stylesheet. The renderer makes zero content decisions.

## The assistant

### Ember <small>private</small>

The small, engine-neutral core that makes an AI coding harness into my assistant: one identity, one memory, one build lane, and a daemon that keeps working overnight. It runs under pi and under Claude Code through thin adapters. Around it: **workshop**, the component monorepo of skills, agents, commands and tools that kit distributes; **shipyard**, the live console that shows what ember reports right now; **voidwire**, the design system every document and app builds from; **parley**, a consultation service where any session can ask a question of a teammate's inbox session and the thread is kept forever; and **orchard**, which serves my Apple Reminders and Calendar to every agent on the home network over MCP, once.

## Local-first, for me

### Prismis <small>public</small>

Reads your RSS feeds, subreddits, YouTube channels and Hacker News, scores every item against a plain-markdown description of what you care about, and shows you the few that matter: in a terminal UI, a menu-bar app, or a CLI built for scripts and agents. It runs every day for its author and ships through Homebrew. [github.com/nickpending/prismis](https://github.com/nickpending/prismis)

### Earshot <small>public</small>

A Limitless pendant used with no cloud. A menu-bar app drains the pendant over Bluetooth into a local spool and uploads it to a server you run, which transcribes with faster-whisper, labels who spoke, and serves the result through a read API. Your audio and transcripts stay on machines you own. [github.com/nickpending/earshot](https://github.com/nickpending/earshot)

### Tarsagotchi <small>private</small>

A TARS voice companion with a Tamagotchi personality. Runs on a Raspberry Pi with an OLED display and wake-word detection, with a server that holds the brain.

### Reverie <small>private</small>

A web-based multiplayer cyberpunk MUD whose differentiator is AI-powered NPCs that remember players and whose attitude evolves over time. A clean rebuild of an earlier prototype that proved the concept and accumulated structural debt. Early; the memory loop comes first, in isolation.

## Retired

Each of these proved one thing and was put down once the thing was proved. The lessons live on in the work above, mostly in manifaces.

### Forge

The AI-native security practice framework the prototypes below lived under: a planner that decides the approach, an assembler that composes validated artifacts, a catalog of reusable components. An idea that didn't work. The factory-and-registry shape never carried real hunting; the harness did, and that became manifaces.

### ASH

Attack Surface Hunter. An agent harness in a container with security tools preinstalled, fed daily lists of new domains, writing intelligence dossiers in the voice of a senior researcher. Proved containerized autonomous tool execution works. Verdict after ten months: a sophisticated script runner with personality, which could execute but couldn't reason. The container model is now the ground floor of everything.

### Artemis

An adaptive investigation engine: hold a set of uncertainties about a target, form a hypothesis, run a test, record the result, reflect, update beliefs. Proved hypothesis-driven loops beat decision trees, and that the model needs to know where it is, not how it got there. Retired when public tools took the niche; the cycle survives as the reference pattern.

### Grindstone

A closed-loop fuzzing harness optimizer for C and C++ libraries: an agent reads the headers, writes a harness, and keeps or discards each change on measured coverage. Found that a coverage plateau means the wrong strategy, not a weak fuzzer. Archived when a vendor tool covered the domain with deeper tuning.

### Sigil

Turned a vulnerability advisory into a runnable detection check through a multi-agent runtime. Proved multi-agent composition works and that operator logs are first-class. Retired because a sequential job pipeline behind a service doesn't carry hunting velocity at hundreds of targets.

### Arsenl

Validated, searchable catalogs of security tool commands, because models invent flags. Named the grounding problem. Superseded when skill-embedded methodology came to carry the catalog's role.

### mcp-recon

Asked the right question at the wrong time: how to integrate recon tools with AI. MCP as the integration pattern was superseded by skills, hooks and helper scripts with JSON contracts.
