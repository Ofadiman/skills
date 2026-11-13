---
name: ofx-state-machines
description: Use when an app's implicit state machines need finding and reporting.
disable-model-invocation: true
---

# State machines

An **implicit state machine** is behaviour that moves through modes the code never names; a single boolean toggled in one place is a variable, not a machine. Its tells:

- several booleans or nullable fields that together encode one mode (`isLoading`, `error`, `data`), so **impossible states** are representable
- a status string or enum compared in many places, with its **transitions** scattered across handlers, effects, and callbacks
- compound guards that rebuild a mode from parts, like `if (!isSubmitting && !hasError && step === 2)`
- timers, retries, or async races whose ordering decides what the user sees

## 1. Search

Dispatch one subagent per top-level directory of the source tree, all at once so they run in parallel. Hand each one the definition and tells above, and have it report every machine in its area, written to this template exactly:

```md
## <machine name>

- Location: <file paths and symbols>
- States: <every mode the code can be in>
- Transitions: <from → to, and the event that triggers each>
- Impossible states: <combinations the current representation allows, each marked unreachable, or reachable with the sequence of events that reaches it>
```

## 2. Report

Rank the entries: every machine with a reachable impossible state first, then the rest, each group ordered from most to least scattered transitions. Write them in that order to `.agent-output/state-machines.md`, replacing any earlier report.

The report is done when every subagent has reported, each machine has one entry merged from every area that found it, and every entry fills every field. Tell me its path.
