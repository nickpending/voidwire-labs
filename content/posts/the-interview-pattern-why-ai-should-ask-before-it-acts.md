---
title: "The Interview Pattern: Why AI Should Ask Before It Acts"
date: 2025-06-18
categories: [ai, development]
tags: ["ai", "development", "patterns", "workflow"]
draft: false
description: "You ask AI to implement something seemingly straightforward. It builds exactly what you asked for. Then you realize it's not what you actually needed. There's a pattern emerging to address this: let the AI interview you first."
---

# The Interview Pattern: Why AI Should Ask Before It Acts

*A short exploration of why letting AI interview you leads to better outcomes*

You ask AI to implement something seemingly straightforward. It builds exactly what you asked for. Then you realize it's not what you actually needed - wrong UX behavior, missing security considerations, breaks existing functionality. There's a pattern emerging to address this: let the AI interview you first.

## TL;DR

- **Assumptions hide in seemingly straightforward requests.** Even simple tasks like "add email validation" contain multiple implementation decisions that aren't obvious until you start building.

- **The interview pattern surfaces these assumptions early.** Let AI ask clarifying questions before implementation - it's faster than discovering problems after the fact.

- **Four key areas benefit most:** Requirements with implicit assumptions, requests touching existing systems, UX decisions that aren't obvious from technical specs, and anything involving security or backward compatibility.

- **Make questions contextual, not templated.** The best interviews focus on the specific decisions and trade-offs your request requires, not generic requirement gathering.

- **Know when to skip it.** Pure analysis tasks work fine as one-shots. The interview pattern shines when there are implementation choices to be made.

## The Pattern

Creative writers use ChatGPT to probe character motivations before writing scenes. Researchers have Claude question their data analysis assumptions before building models. Developers let AI clarify implementation details before writing code.

The insight: assumptions hide in places you don't expect, even in well-crafted requests.

## A Real Example

Consider this straightforward development request:

> "Add validation to the email field in our user registration form"

Seems clear enough. But watch what happens when the AI interviews first:

```
AI: What type of validation - just format checking or should I verify the domain exists?
Developer: Just format checking for now.

AI: Should this block submission or just show a warning?
Developer: Block submission, but show the error inline, not in a popup.

AI: Any security considerations - should I prevent injection attacks via email fields or block disposable email services?
Developer: Good catch. Block common disposable domains, and sanitize the input for logging.

AI: What about existing users with invalid emails in the database?
Developer: Oh, right. Just validate new registrations, don't break existing logins.
```

Four questions surfaced four assumptions that would have led to the wrong implementation:
1. Domain verification wasn't needed (could have added unnecessary complexity)
2. UX behavior wasn't obvious (inline vs popup errors)  
3. Security implications weren't considered (vulnerability to attacks)
4. Backward compatibility wasn't thought through (could have broken existing users)

Without the interview, the AI might have implemented domain verification (too complex), used popup errors (wrong UX), or broken existing users (unacceptable side effect). Development doom avoided.

## Why This Works

The interview pattern works because it forces both human and AI to confront ambiguity before committing to implementation. It's not that one-shot prompting is bad - for truly unambiguous tasks, it's often faster. But ambiguity hides in places you don't expect.

Even seemingly simple requests like "add a user_role field to the JWT payload" can surface important questions: String enum or integer? What are the possible roles? How do existing tokens handle missing fields?

The interview captures these decisions as documented context rather than leaving them implicit. Future changes can reference why choices were made instead of re-litigating the same assumptions.

## How to Make This Work

The key is getting AI to ask natural, contextual questions rather than following rigid templates. Based on what actually works in practice:

**For planning/design tasks:**
Structure the conversation around decision points rather than information gathering. Instead of "ask me about requirements," try "conduct focused interview" with questions that surface the specific assumptions that typically cause problems - scope creep, integration conflicts, backward compatibility issues.

**For validation:**
Use a fresh AI session with no context from the original work. Ask it to review what was built and identify gaps between stated goals and actual implementation. The unbiased perspective catches things the original implementer missed.

**For implementation tasks:**
Let the AI identify what it needs to know before building, rather than prescribing what to ask about. The questions that matter depend on the specific request and existing system constraints.

The pattern works because it moves the conversation from "here's what I want" to "let's figure out what I actually need" - then records those discoveries as context for the work.

## Where It Applies

This pattern seems most valuable when you're asking AI to create or modify something, where there are implementation choices to be made. Analysis and explanation tasks are naturally unambiguous - requests like "tell me about this function" or "explain what this code does" work perfectly as one-shots because they're purely analytical with no decisions to make.

The interview pattern really shines when:
- Requirements have implicit assumptions
- Multiple implementation approaches are possible
- The request touches existing systems or user workflows
- Backward compatibility matters
- UX decisions aren't obvious from the technical requirement
- Security implications need consideration

For truly unambiguous tasks, the interview overhead might not be worth it. But the boundary between "simple" and "complex" is often much blurrier than we think.

The question isn't whether to use one-shot prompting or interviews. It's recognizing when assumptions need to be surfaced, and having AI help surface them systematically rather than discovering them through failed implementations.