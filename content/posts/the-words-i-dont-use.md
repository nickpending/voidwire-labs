---
title: "The Words I Don't Use"
date: 2026-04-01T12:00:00-07:00
draft: false
tags: ["ai", "agents", "intent-decomposition", "prompt-engineering", "security", "development"]
categories: ["ai", "development"]
---

I've been trying to get large language models to do what I want. The problem is that what I want is encoded in the words I use, obviously, and more importantly in the words I don't use. I don't use them because I failed to understand the problem clearly enough, I don't have enough domain expertise, or a variety of other reasons: assumptions, blind spots, things I take for granted.

I've been thinking a lot about this gap — the distance between what I say and what I actually mean. There has to be a way to close it. Not by writing better prompts, but by having the model do the work of figuring out what I left unsaid.

And before anyone says it — yes, I know about prompt engineering. Give it the problem, the context, examples, a role, whatever framework you prefer. I do all of that. This isn't about writing better prompts. This is about what happens when you've written the best prompt you can and it's still missing things — because *you* didn't know they were missing.

A bit of backstory. In workflows I've created for development and other work, I would instruct the model to ask me clarifying questions. That always helped. The problem (and I'm sure most of you know this already) is scale. I can't answer and clarify every question when I've got multiple sessions running — that's too much context switching. Some of the questions were good ones, but they required a level of concentration and research I didn't have the time to invest in. They're important design decisions, not safety or security issues, just things that could go one way or the other. I didn't have the time budget so I had to figure out a better way.

During all this I started working on a meta skill for cyber security — helping security folks build reusable skills for their day-to-day engagements. It could build skills for simple tasks, large campaigns, all the way to multi-agent orchestration. There's more on that topic later; I have another article coming out about not staying too meta.

Testing this meta skill is where I really started to see a fracture zone. No matter how much I described what I was asking, the model would come back and ask a shit ton of questions. A lot of them were kind of silly, but it's because I told the model to do that. I had that aha moment where I realized maybe there's a better way. If agents can do all this other work, can they take a simple request and expand it into a full-featured one — ferret out all the ambiguities and assumptions, with a slant of also answering them or offering suggestions?

I already had an agent called ferret — as you can imagine, it ferrets out ambiguities and assumptions. I'd gone through probably ten trials with the meta skill at this point, and in every case I had to keep answering, keep correcting, keep fixing the model's assumptions because even with my prompt it just wasn't good enough. So I used that existing agent to bootstrap the process.

The first run produced amazing results. It short-circuited everything. I no longer had to spend time being interviewed because ferret did all that work for me. That's when I realized this idea of expansion is a very interesting one.

I turned it into a dedicated agent. The reason for that is the main model I'm using often has too much context — in disambiguating requests, a stateless agent with fresh context and no baggage performs better.

The results were good enough that I immediately tried a variant on my visual skills — things that help you build UIs, UXs, and other visual artifacts. I could now tell the visual skill, "Build me a dashboard for this project," and it goes off and reads all the relevant information — even if it's just a rough idea you sketched or there's existing code. It checks all of that, unpacks what it all means, and passes that off to a generator.

I can't take full credit; I don't think anyone can these days. There's a sprinkle of ideas from all over. The Anthropic blog did stuff with their visual agents that probably laid some seeds I wasn't aware of, and Miessler's PAI project is doing cool things with hill climbing that I eventually want to incorporate. But the idea worked.

And just so we're clear, the idea is this: I should be able to say — speaking security here — "Hey tool, build me a skill that can perform basic HTTP recon against a list of previously resolved FQDNs, with the ability to filter results by interesting headers, response codes, content length, etc." And it should take that and build a skill. But there's still a lot of assumptions in that request. I'm not encoding all of my knowledge, and I don't want to either. The model should be smart enough to take my request and expand it into a detailed plan that covers:

- ports and buckets
- scope boundaries
- tools that might need to be used
- questions with their answers
- problems and their proposed solutions

This idea of intent decomposition — that's what I'm calling it — does this work FOR you. Especially if there's pre-existing content or data, it takes some of the burden off you to articulate and encode all of your expertise at once. Its output is something you can review, revise, save, edit, and make yours. It's done a lot of the heavy lifting for you.

And to be clear, this isn't just gathering more context for the model to read. The agent produces something new — a synthesized, expanded version of my request that didn't exist before. An explore agent gives the model more information. This gives the model a clearer picture of what I'm actually asking for.

Some of you might be thinking, "Why didn't you just say 'build me a plan for how I would do this'?" You could. But you'd also have to encode all the aspects of my intent decomposition agent to get the same results, and you'd need to do that every time. If you're doing it in your main session, the existing context and memories are going to affect how it performs.

I don't think this is better prompting in the traditional sense. You could maybe call it context engineering — I am managing context a lot better and I'm not taking as many turns. But it's also about time management and context switching on the human level. You don't want to keep context switching, especially if you're multitasking, which I think most of us are now as we orchestrate multiple agents doing a variety of work. Even within the same domain, it might be different enough that you've got a context switch. You need the agent to be your force multiplier.

And going back to prompting: a lot of times you don't know what you don't know, as I said in the beginning. Even if you could write a better prompt, that presumes you know all your own blind spots. You don't.

I'm still early with this. There are open questions I haven't answered yet — can the same approach work for something like debugging, where the problem is buried in the code and the intent is more investigative? Does the agent need to be domain-specific or can a general-purpose decomposer learn to read different kinds of artifacts? I don't know yet.

What I do know is that the results are better than they've ever been. On the visual side, the decomposition step lets the agent speak visually in a way that I can't. I'm not a UI/UX person. I know what looks good — I think most people have that intuition — but encoding what I think looks good into a prompt for a generator would be impossible. It would take many iterations, and it did before. Now the decomposer handles that translation. Same with the security meta skill. The results are better because I'm doing fewer loops. I'm slowly getting out of the loop because this process encodes more in each request than I ever could in a prompt.

I'm sure someone will ask, "Why don't you just trust the model and have it refactor if it gets it wrong?" Maybe that works for some people. For me, I can't stomach redoing work when stuff could have been caught earlier. That's probably a personality thing more than a technical argument, but it's a real one.

I want people to walk away with this: intent decomposition — or prompt expansion, whatever you want to call it — is a step most of us are skipping. You can probably build your own version of this. Maybe you can even one-shot prompt a model to do it based on what I've described here. But the idea itself, the idea that there should be a dedicated step between what you ask for and what gets built, where the model does the work of figuring out what you actually meant — I think that's worth paying attention to.
