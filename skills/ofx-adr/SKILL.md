---
name: ofx-adr
description: Use when a technical decision needs its options weighed and written up as an ADR, or an ADR already under adr/ needs its outcome recorded.
---

# Architecture decision record

One markdown file per decision, under `adr/` at the git root — find the root with `git rev-parse --show-toplevel`. When `adr/` already holds this decision's record, read the whole file and carry on from where it stops instead of starting a new one, leaving every section already written word for word.

Two things in the record are mine and nothing else is: which options get compared, and the outcome. Finding _facts_ is your job, never mine — when the record needs one from the environment, the filesystem, a tool, a ticket, or a library's docs, dispatch a subagent to find it rather than asking me for something you could look up yourself.

## 1. Options

Read enough of the code to see what the decision actually turns on, then name back to me every option you would put in the record, one line each, along with any option I named that you would drop and why. Wait for my go-ahead. Two options is the floor, and it binds both sets: the candidates you bring me, and the ones I approve. When either falls short of two, tell me so and stop there — a record with nothing to compare is not a decision.

## 2. Research

Dispatch everything the record needs in one go so the lookups run in parallel: the current implementation each option would change, the libraries or services each one pulls in, the prior art in neighbouring code, the benchmark or migration facts an option's cost turns on. Have each one report the sources behind its findings alongside the findings themselves. Let them all report before you write a section.

## 3. The record

Create `adr/` when it is missing, and name the file `NNNN-<kebab-slug>.md`: the number is one past the highest already in `adr/`, zero-padded to four digits, starting at `0001` in an empty directory, and the slug is yours to name out of the decision itself, never a question you put to me.

Inside it, an `#` title naming the decision in the terms someone would search for it by later, then the sections below, in this order. Plain prose and plain markdown throughout: no icons, no decorative symbols, nothing outside ordinary punctuation.

The record weighs options by their consequences and never by the effort any of them would take, whether to build, to migrate, or to maintain: estimates and planning measures stay out of every section, in every unit and every sizing scheme.

### Background

`## Background`: the situation as it stands and what forces a decision now — the constraint that appeared, the limit the current design hit, the thing that broke. Written for someone who has never opened this repo.

### Considered options

`## Considered options`, holding one `### Option N: <title>` per option, numbered from 1. Each body is **how**, never **whether**: the concrete shape of the implementation — the files it touches, the symbols it adds, the dependencies it takes on, the behaviour it changes — in enough detail to build from. Judgement of every kind (a pro, a con, a trade-off, a comparison against another option, a preference) belongs in Summary, so each body reads as if that option were the one being built.

### Additional sections

Zero or more `##` sections of your own naming, sitting between Considered options and Summary, and only where the decision turns on them: a benchmark, a migration path, the breaking changes, the security surface, a compatibility matrix. Write none at all when nothing here would change the decision.

### Summary

`## Summary` over one table: one column per option, one row per decision factor:

```md
| Decision factor | Option 1                | Option 2                |
| --------------- | ----------------------- | ----------------------- |
| <factor>        | <how this option fares> | <how this option fares> |
```

Every row is one factor measured across every option — execution speed, whether components render in a real browser, the blast radius of a breaking change. The table is done when every factor the record itself raises, in Background, in what your research turned up, or in an additional section, has exactly one row, and every option answers every row. Each cell carries what the option does to the running system and to the people who keep it running: to the code, to behaviour at the boundary, to what maintaining it will oblige them to do.

### Resources

`## Resources`: every source the record rests on, whether you read it or a subagent did — docs, tickets, merge requests, benchmarks, earlier records under `adr/` — as a link where one exists and a repository path where none does.

### Outcome

`## Outcome`, left as a bare heading. The decision under it is mine.

## 4. Outcome

Report the record's path, tell me in chat which option you would pick and why, and stop. My answer is the gate. Write the outcome under its heading only then, naming the option by number and title. Reasoning I give you is the justification, carried as I gave it — except for an estimate anywhere in it, which the guardrail still catches: ask me which consequence the number stands for and write what I answer, rather than transcribing the number or dropping it yourself. A bare pick of the option you recommended affirms the reasoning you already stated, so write the outcome up from that. A bare pick of any other option leaves you no rationale to write from: ask me for mine before you write anything. A recommendation of yours never becomes the outcome on its own.
