---
name: ofx-architecture-decision-record
description: Use when weighing a technical decision's options in an ADR, or finishing an ADR under adr/.
disable-model-invocation: true
---

# Architecture decision record

One markdown file per decision, under `adr/` at the git root. When `adr/` already holds this decision's record, carry on from where it stops, leaving every section already written word for word.

Two things in the record are mine: which options get compared, and the outcome. Everything else is yours, and when it needs a fact, dispatch a subagent to find it.

## 1. Options

Read enough of the code to see what the decision turns on, then name back to me every option you would put in the record, one line each, along with any option I named that you would drop and why. Wait for my go-ahead. The options you bring me and the ones I approve each need at least two; when either falls short, tell me so and stop.

## 2. Research

Dispatch a subagent for every lookup the record needs, all in parallel: the current implementation each option would change, the libraries or services each one pulls in, the prior art in neighbouring code, the benchmark or migration facts an option's consequences turn on. Have each one report its sources with its findings. Write nothing until every one has reported.

## 3. The record

Name the file `NNNN-<kebab-slug>.md`: `NNNN` is one past the highest number in `adr/`, or `0001` when there is none, and the slug names the decision. Inside it, an `#` title naming the decision in the terms someone would search for it by later, then the sections below, in this order, in plain prose and plain markdown, words and ordinary punctuation only.

Weigh options by their consequences alone: an estimate of the effort to build, migrate, or maintain any of them stays out of every section, in every unit and every sizing scheme.

### Background

`## Background`: the situation as it stands and what forces a decision now, such as a constraint that appeared, a limit the current design hit, or something that broke. Written for someone who has never opened this repo.

### Considered options

`## Considered options`, holding one `### Option N: <title>` per option. Each body is **how**, never **whether**: the concrete shape of the implementation (the files it touches, the symbols it adds, the dependencies it takes on, the behaviour it changes) in enough detail to build from, written as if that option were the one being built. Every judgement, whether a pro, a con, a trade-off, a comparison, or a preference, goes in Summary.

### Additional sections

`##` sections of your own naming, only where the decision turns on them: a benchmark, a migration path, the breaking changes, the security surface, a compatibility matrix.

### Summary

`## Summary`, one table:

```md
| Decision factor | Option 1                | Option 2                |
| --------------- | ----------------------- | ----------------------- |
| <factor>        | <how this option fares> | <how this option fares> |
```

Factors look like execution speed, whether components render in a real browser, or the blast radius of a breaking change. The table is done when every factor the record raises, in Background, in your research, or in an additional section, has exactly one row, and every option answers every row. Each cell carries what the option does to the running system and to the people who keep it running: to the code, to behaviour at the boundary, to what maintaining it will oblige them to do.

### Resources

`## Resources`: every source the record rests on, whether you read it or a subagent did (docs, tickets, merge requests, benchmarks, earlier records under `adr/`), as a link where one exists and a repository path where none does.

### Outcome

`## Outcome`, left empty.

## 4. Outcome

Report the record's path, tell me in chat which option you would pick and why, and wait for my pick. Then write the outcome under its heading, naming the option by number and title, justified by:

- **My reasoning**, when I give some, carried as I gave it. An estimate in it still stays out: ask me which consequence the number stands for and write my answer in its place.
- **Your stated reasoning**, when I pick the option you recommended without giving any.
- **The reasoning you ask me for**, before you write anything, when I pick another option without giving any.
