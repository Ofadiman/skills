---
name: ofx-writing-for-agents
description: Use when writing or editing a document an agent reads, whether a skill, an AGENTS.md or CLAUDE.md, or a doc behind a pointer.
disable-model-invocation: true
---

# Writing for agents

A document you write or edit is done when every sentence in it survives [Pruning](#pruning). Run its tests on the first draft, before you hand the document over.

## Context pointers

A **context pointer** is a reference held in the agent's context that names some out-of-context material and encodes the condition for reaching it: a skill's description, or a line in `AGENTS.md` naming a doc. The pointer's _wording_, not its target, decides when the agent reaches the material, and how reliably. A must-have target behind a weakly worded pointer is a variance bug: sharpen the wording first, and inline the material only if sharpening fails.

A pointer does two jobs: state what the material is, and list the **branches** that should trigger reaching it (a branch is a distinct case the document handles, so different runs take different paths through it). A pointer the agent reaches in sequence, such as the file of the next step, has no branches: its position is the trigger, so its name is the whole pointer. An always-loaded pointer spends [context load](#the-two-loads) on every turn, so it earns even harder pruning than the body:

- **Front-load the [leading word](#leading-words)**, the one your prompts, docs, and codebase already use: the agent links that shared language to the material and reaches it more reliably.
- **One trigger per branch.** Synonyms that rename a single branch are one branch written twice; collapse them.
- **Cut identity the body already carries**, such as a title sentence ahead of the triggers.

## The two loads

Every document and pointer you add spends one of two budgets:

- **Context load** is the cost of always-loaded material on the agent's window: an `AGENTS.md` line, a skill description, anything sitting in context every turn, spending tokens and attention whether or not it fires.
- **Cognitive load** is the cost on the human: which documents exist and when to reach for each. The human is the index. It is the price of human agency, so spend it where human judgement matters and remove it where it does not.

Material reached only through a pointer escapes context load at the price of the pointer's own line; material with no pointer at all rides entirely on cognitive load.

## Information hierarchy

A document is built from **steps** (the ordered actions the agent performs) and **reference** (definitions, rules, facts consulted on demand), mixed in any proportion. The core decision is where each piece sits on the **information hierarchy**, a ladder ranked by how immediately the agent needs the material:

1. **In-file step** is the primary tier: what the agent does, in order.
2. **In-file reference** is often a legitimately flat peer-set (every rule of a review on one rung).
3. **Disclosed reference** sits in a separate file, anywhere from a sibling in the same folder to external material any document can point at, and loads only when its pointer fires.

Push too little down and the top bloats; push too much and you hide material the agent actually needs.

**Progressive disclosure** is the move down to the third rung so the top stays legible. Test it by branch: inline what every branch needs, and push behind a pointer what only some branches reach. When a document has steps, reference that should be disclosed buries them and turns attending to them into a coin-flip, which makes disclosure a variance lever more than a token saving.

**Co-location** decides what sits beside a piece once the ladder has placed it. Keep a concept's definition, rules, and caveats under one heading, so reading one part brings its neighbours with it. Scattering fragments one meaning across many places, where duplication repeats one meaning in two.

**Sprawl** is the failure mode here: a document simply too long, even when every line is live and unique. Attention thins across the excess. The cure is the ladder: disclose by branch and [split by sequence](#steps-and-completion-criteria), so each path carries only what it needs.

## Steps and completion criteria

Every step ends on a **completion criterion**, the condition that tells the agent the work is done. The strongest are exhaustive and checkable:

- **Exhaustive**: a criterion's demand drives **legwork**, the digging the agent does within the work, latent in the wording rather than written as its own step. "Every modified model accounted for" forces thorough work where "produce a change list" does not. Demand binds reference too: "every rule applied" binds a body of flat reference just as "every step done" binds a sequence.
- **Checkable**: can the agent tell done from not-done? A vague bound ("understanding reached") invites **premature completion**, attention slipping to _being done_. The visible steps still ahead (the **post-completion steps**) supply the pull; the criterion's clarity is the resistance. Sharpen the bound first: it is local and cheap.

Only when the bound is irreducibly fuzzy _and_ you observe the rush, **split by sequence**: move the post-completion steps out of view, and the step in front of them gets more legwork. Hiding works only across a real context boundary, a hand-off or a subagent dispatch; an inline call leaves the later steps in context and clears nothing. A split spends one of the two loads, so make it only when the cut earns it. Merging sequences runs the lever backwards: each step's later steps come into view, inviting premature completion.

## Leading words

A **leading word** is a compact concept already living in the model's pretraining that the agent thinks with while running the document (_lesson_, _fog of war_, _tracer bullets_). Repeated as a token, never as a sentence, it accumulates a distributed definition and anchors a whole region of behaviour in the fewest tokens: every appearance pulls the agent back to the same behaviour, and inside flat reference it focuses attention on a class of thing to look for. Reach for an existing word first; a coined word recruits no priors, so it works only once you pay in definition tokens for what a pretrained word gives free.

Hunt for restatements a leading word retires, and assume every document carries some: a triad spelled out at three sites, a pointer spending a sentence to gesture at one idea. Collapse each into a single token:

- "fast, deterministic, low-overhead" → _tight_ (a _tight_ loop).
- "a loop you believe in" → _red_, turning a fuzzy gate into a binary observable state (the loop goes _red_ on the bug, or it doesn't).

**Negation** is the failure mode beside this lever: a prohibition names the forbidden behaviour and makes it _more_ available. _Don't think of an elephant_, and the elephant is all there is: the weak "don't" loses to the strongly activated concept, so the ban half-reads as an instruction to do the thing. Prompt the **positive**: state the target behaviour ("write one-line comments") so the banned one is never spoken. A prohibition earns its place only as a hard guardrail you cannot phrase positively; even then, pair it with the positive target so attention lands on what to do.

## Pruning

- Keep each meaning in a **single source of truth**: one authoritative place, so changing the behaviour is a one-place edit. **Duplication** (the same meaning in more than one place) costs maintenance and tokens, and inflates a meaning's prominence on the ladder past its real rank. It creeps in most often beside pointers: a summary of the file a pointer names, a rule restated from the file that owns it, an index of files the steps already point to. Point at the owner and let it speak. A leading word is the deliberate inverse, repeating a token and never the meaning, so it stays.
- The **environment** is a source of truth too (`package.json` scripts, config files, the directory layout, `--help` output), and a document that restates it is a **cache**: a copy of a lookup, earning its load only when the lookup is expensive. Cache what the agent cannot find by looking: the unwritten convention, the reason behind a choice, the gotcha no config confesses. Leave the one-file, one-command lookups to the environment, where they cannot go stale.
- Check every line for **relevance**: does it still bear on what the document does? A line loses relevance by never bearing on the task (mere exposition, or a branch that should be disclosed) or by going stale as the behaviour or world it describes changes. Without a pruning discipline the default fate is **sediment**: stale layers that settle because adding feels safe and removing feels risky.
- Hunt **no-ops** sentence by sentence: a sentence whose deletion leaves the agent's behaviour unchanged pays load to say nothing. The test: name what the agent does differently because the sentence is there. It is model-relative, not reader-relative: a dispute over a no-op is a dispute about the default, settled by running the document rather than by debate. When a sentence fails, delete the whole sentence rather than trim words from it. First drafts reliably carry three shapes:
  - **Throat-clearing**: an opening that says what the document is or does, which the pointer that loaded it already said. Open on the first thing the agent does or needs.
  - **Defaults**: an instruction the model already obeys, such as asking the user for a missing argument.
  - **Inventory**: a fact no action depends on, such as a list of required tools. Move it into the action that uses it, a check in the step that needs the tool, or cut it.

  The test also grades leading words: a word too weak to beat the default (_be thorough_ when the agent is already thorough-ish) is a no-op, and the fix is a stronger word (_relentless_), not a different technique.
