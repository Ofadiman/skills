---
name: ofx-sdd
description: Use when starting a feature, or resuming one that has a Q&A or plan under .agent-output — settles the design in a Q&A file and a skeleton plan before any code.
disable-model-invocation: true
---

# Spec-driven development

Three phases — **questions**, **plan**, **implementation** — and one gate, which is mine: settled questions open the plan, and the plan runs straight on into implementation without stopping.

Both artifacts live in `.agent-output/<feature>/` in the current working directory: `questions.md` and `plan.md`. `questions.md` is ours and every decision in it is mine; `plan.md` is yours alone, and I am not involved in writing or revising it. `<feature>` is a kebab-case slug you name yourself, slugged out of the change itself from the context I gave you, and you write the file under it. The slug is yours, never a question you put to me. When that directory already exists, read whichever artifacts are in it and tell me where the work stands — which decisions are still open, whether the plan is written, which boxes are checked — and resume once I confirm it.

## 1. Questions

Interview me relentlessly until we reach a shared understanding. Map the change as a **design tree**: every decision branches into the decisions that hang off it.

Work the tree in **rounds**. The **frontier** is every decision whose prerequisites are already settled — the questions you can ask now without guessing at answers you have not heard yet. A question whose answer depends on another question still open in this round belongs to a later round.

Finding _facts_ is your job, never mine. When a frontier question needs a fact from the environment — the filesystem, a tool, a ticket — dispatch a subagent to find it rather than asking me for something you could look up yourself. Dispatch everything the round needs in one go so the lookups run in parallel, and let them all report before you write the round: a question that was only waiting on a fact belongs in this round, not the next one. The _decisions_ are mine: put each one to me and wait.

A fact earns its place in the file only inside the question it bears on — in that question's framing, or in the pro or con it decides. A fact that changes no decision is one you keep to yourself.

`questions.md` is rounds of questions and nothing else: every heading in it is a `## Round N`, or a question inside one. Append the whole frontier as one round under its own `## Round N` heading, leaving every earlier round in the file word for word — then report that path and wait for my written answers. Write each question in that round to this template exactly, heading levels and all, one `####` option per choice, lettered so I can answer with the letter alone:

```md
### Q1 — <question title>

<the decision at stake and why it matters>

#### A — <option>

<what it does>

- Pro: <what it buys>
- Con: <what it costs>

#### B — <option>

<what it does>

- Pro: <what it buys>
- Con: <what it costs>

#### Recommendation

<letter> — <why this one beats the others>

#### Answer

<letter>

### Q2 — <question title>

<the decision at stake and why it matters>

#### A — <option>

<what it does>

- Pro: <what it buys>
- Con: <what it costs>

#### B — <option>

<what it does>

- Pro: <what it buys>
- Con: <what it costs>

#### Recommendation

<letter> — <why this one beats the others>

#### Answer

<letter>

### Q3 — <question title>

<the decision at stake and why it matters>

#### A — <option>

<what it does>

- Pro: <what it buys>
- Con: <what it costs>

#### B — <option>

<what it does>

- Pro: <what it buys>
- Con: <what it costs>

#### Recommendation

<letter> — <why this one beats the others>

#### Answer

<letter>
```

The `<letter>` under each `#### Answer` marks where my answer lands, typed after you hand the file over — never something you fill in. You write every `#### Answer` empty, with three blank lines under the heading so I have room to type between it and the question that follows.

Write it in plain prose and plain markdown: no icons, no decorative symbols, nothing outside ordinary punctuation.

When I tell you I have answered, read the whole file back. An empty `#### Answer` section is unanswered: name every one of them back to me and stop, rather than reading an answer into the silence. A bare letter under `#### Answer` means that option exactly as written.

My answers reshape the tree: each settled decision pushes the frontier outward and unblocks the questions that hung off it. Recompute the frontier, and append the next round while it still holds questions.

The phase is done when the frontier is empty — every branch of the design tree visited, nothing left silently assumed. Ask me to confirm we have reached a shared understanding; my confirmation is the gate into phase 2.

## 2. Plan

Write `plan.md`: the **skeleton** of the change — every artifact named, no bodies written. Scope, behaviour, and edge cases come only from what `questions.md` settled, each edge case folded into the task that owns it. Concrete names come from the repo's own conventions, so read the neighbouring code for them.

Split the work into tasks, each one a slice of behaviour that can be completed and verified on its own, ordered so every task depends only on tasks above it. Write each task as a checkbox; nest under it every file the task creates or changes with the purpose that file serves; and nest under each file the symbols the design turns on — components, hooks, functions, types, exported constants — with each one's purpose. Name the test files the same way, carrying the test names that prove the task:

```md
# Plan

## Tasks

- [ ] Active filters survive a page reload through the URL
  - `src/filters/filterQuery.ts` — makes the URL the single source of truth for the active filter set
    - `serializeFilters(filters: Filter[]): string` — encodes a filter set into a query string
    - `parseFilters(query: string): Filter[]` — decodes a query string back into a filter set, dropping fields the schema does not know
  - `src/filters/useFilterState.ts` — holds the working filter set and keeps it in sync with the URL
    - `useFilterState()` — returns the current filter set plus `setFilter` and `clearFilters`, writing each change through `serializeFilters` and debouncing before the table query sees it
  - `src/filters/filterQuery.test.ts` — `serializeFilters encodes an empty set as an empty string`, `parseFilters round-trips serializeFilters output`, `parseFilters drops fields the schema does not know`
  - `src/filters/useFilterState.test.ts` — `useFilterState seeds itself from the URL on mount`, `useFilterState debounces rapid changes into one query update`
```

Go straight on into phase 3 without announcing any of this: `plan.md` is your working memory, so do not report its path, do not tell me you wrote it, and do not summarise it for me. Never ask me to approve the plan, and never bring me a question about naming, ordering, or structure — those you settle yourself from the repo's conventions and the neighbouring code. If I comment on the plan unprompted, route it by what it touches: naming, ordering, or structure you fix in place and carry on; a change to behaviour, to scope, or to a decision `questions.md` already settled goes back to phase 1 as a new round and comes through the gate again.

## 3. Implementation

Work `plan.md` from top to bottom. Complete one task, verify it with the tests that task names, check its box, then take the next one.

When the code contradicts the plan — a name that no longer fits, a task that has to split, a dependency the plan missed — take the best call available to you, correct `plan.md` to say what you actually did, and carry on. Collect every one of those departures and report them when the work is done.

Done when every box is checked and the checks are green. Discover the checks from the repo — its task runner, package scripts, or CI config — and run every one that runs locally over the paths you touched. Report a check you cannot get to green rather than counting the work done.
