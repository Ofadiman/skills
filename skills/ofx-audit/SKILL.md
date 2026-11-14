---
name: ofx-audit
description: Use when a file or part of a project needs auditing.
disable-model-invocation: true
---

# Audit

An audit is read-only: it writes its report and changes nothing else.

## 1. Scope

Start from the target and follow its edges: everything that loads, sources, or calls it, everything it loads, sources, or calls, and every file the tool reads from its search path, including files outside the repo. Note the installed version of each tool involved. Scope is settled when every edge ends in a file that is either in scope or named as out of scope with the reason.

## 2. Investigate

Apply every lens to every file in scope:

- **Edge cases**: runs the author never tried, such as a fresh machine, a missing dependency, empty input, or the first or last item.
- **Idempotence**: what happens when the file is loaded, run, or applied a second time.
- **Portability**: hardcoded paths, users, and OS assumptions, against the platforms the project installs on.
- **Redundancy**: duplicate loading, defaults left beside their custom replacements, a dependency whose remaining effect fits in a few lines.
- **Consistency**: siblings that behave differently for no reason.
- **Safety**: destructive actions with no confirmation and no undo.
- **Idioms**: hand-rolled code the installed version does directly.
- **Staleness**: comments, docs, pins, and files that no longer match the code.
- **Checks**: a cheap parse, lint, or test the project could run in CI.

Reading the code or the docs suggests a claim; only a test proves it. Reproduce every claim in a finding, side remarks included, on a throwaway instance, such as a separate server socket, a temporary `HOME`, or a copy of the file in a temporary directory, and record the test and what it showed. Reproduce the fix the same way: applied to a throwaway copy, it removes the problem and changes nothing else. Drop every claim without a passing test, whether the test disproved it or none could run safely, and drop every finding left with no proven problem.

Investigation is done when every lens has been applied to every file in scope and every remaining claim has been reproduced.

## 3. Report

Rank the findings by impact: what is broken now, then what breaks on a path or platform the project supports, then rough edges, then cleanups that fix nothing broken, each marked _Optional_. Write them in that order to `.agent-output/<subject>-audit.md`, where every line after the title belongs to a finding:

```md
# <subject> audit

## 1. <the fix>: <the consequence it removes>

<the mechanism, the test and what it showed, and a copy-paste fix>
```

Then reply with a numbered summary mirroring the report: per finding, one bold sentence naming the fix and its consequence, then its test and what it showed in a sentence or two. Open with the finding count, that nothing changed, and the report's path.
