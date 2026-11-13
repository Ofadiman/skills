---
name: ofx-agentic-development
description: Use when starting a feature whose design needs settling in a Q&A before code, or resuming one under .agent-output/.
disable-model-invocation: true
---

# Agentic development

The work lives in two files under `.agent-output/<feature>/` in the current working directory: `questions.md` and `plan.md`. `<feature>` is a kebab-case slug you name yourself from the change and write under straight away. When `.agent-output/` already holds this feature's directory, read what is in it, tell me where the work stands (which decisions are still open, whether the plan is written, which boxes are checked), and resume once I confirm.

## 1. Questions

Interview me relentlessly until we reach a shared understanding. Map the change as a **design tree**: every decision branches into the decisions that hang off it.

Work the tree in **rounds**, each one the **frontier**: every decision whose prerequisites are already settled. A question whose answer depends on one still open belongs to a later round.

Finding _facts_ is your job; every _decision_ is mine, put to me as a question. When a frontier question needs a fact from the environment (the filesystem, a tool, a ticket), dispatch a subagent to find it. Dispatch all of the round's lookups at once so they run in parallel, and write the round only after every one has reported: a question that was only waiting on a fact belongs in this round.

`questions.md` holds rounds of questions and nothing else: every heading in it is a `## Round N`, or a question inside one. A fact appears only inside the question it bears on, in that question's framing or in the pro or con it decides. Append the whole frontier as one round, leaving every earlier round word for word, then report the file's path and wait for my written answers. Write the round to this template exactly, heading levels and all, with one lettered `####` option per choice:

```md
## Round N

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
```

Write every `#### Answer` empty, with three blank lines under the heading so I have room to type before the next question. Write in plain prose and plain markdown, words and ordinary punctuation only.

When I tell you I have answered, read the whole file back. An empty `#### Answer` is unanswered: name every one back to me and stop. A bare letter means that option exactly as written.

My answers reshape the tree: recompute the frontier, and append the next round while it still holds questions. The phase is done when the frontier is empty: every branch of the design tree visited, nothing silently assumed. Then ask me to confirm we have reached a shared understanding; my confirmation is the gate into phase 2.

## 2. Plan

Write `plan.md`: the **skeleton** of the change, every artifact named and no bodies written. Scope, behaviour, and edge cases come only from what `questions.md` settled, each edge case folded into the task that owns it. Naming, ordering, and structure are yours, settled from the repo's conventions and the neighbouring code.

Split the work into tasks, each a **vertical slice** of behaviour you can complete and verify on its own, ordered so every task depends only on tasks above it. Write each task as a checkbox; nest under it every file the task creates or changes with the purpose that file serves, and under each file the symbols the design turns on (components, hooks, functions, types, exported constants) with each one's purpose. Name the test files the same way, carrying the test names that prove the task:

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

`plan.md` is your working memory: write it silently and go straight on into phase 3. If I comment on the plan, route it by what it touches: naming, ordering, or structure you fix in place and carry on; a change to behaviour, to scope, or to a decision `questions.md` settled goes back to phase 1 as a new round and comes through the gate again.

## 3. Implementation

Work `plan.md` top to bottom, one task at a time: complete it, verify it with the tests it names, check its box.

When the code contradicts the plan (a name that no longer fits, a task that has to split, a dependency the plan missed), make the best call you can, correct `plan.md` to say what you actually did, and carry on.

Done when every box is checked and the checks are green. Discover the checks from the repo (its task runner, package scripts, CI config) and run every one that runs locally over the paths you touched. Then report every departure from the plan, and every check you cannot get green as work still open.
