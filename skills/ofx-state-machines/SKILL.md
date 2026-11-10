---
name: ofx-state-machines
description: Use when an app's implicit state machines (flag clusters, scattered status checks, guards that rebuild a mode from parts) need finding and reporting.
disable-model-invocation: true
---

# State machines

An **implicit state machine** is behaviour that moves through modes the code never names. Its tells:

- several booleans or nullable fields that together encode one mode (`isLoading`, `error`, `data`), so **impossible states** are representable
- a status string or enum compared in many places, with its **transitions** scattered across handlers, effects, and callbacks
- compound guards that rebuild a mode from parts, like `if (!isSubmitting && !hasError && step === 2)`
- timers, retries, or async races whose ordering decides what the user sees

A single boolean toggled in one place is a variable, not a machine.

## 1. Search

Dispatch one subagent per top-level directory of the source tree, all in one go so they search in parallel. Hand each one the tells above and this entry shape, and have it report every machine in its area:

```md
## <machine name>

- Location: <file paths and symbols>
- States: <every mode the code can be in>
- Transitions: <from → to, and the event that triggers each>
- Impossible states: <combinations the current representation allows, each marked unreachable, or reachable with the sequence of events that reaches it>
```

Each entry describes the machine as the code has it today, in exactly these fields.

## 2. Report

Rank the entries: machines with a reachable impossible state first, since each one is a bug users can hit today, then by how widely the transitions are scattered, since scattered transitions are the hardest for a developer or an agent to follow. Write them in that order to `.agent-output/state-machines.md` in the current working directory, replacing any earlier report, since the code may have moved since it was written.

The report is done when every subagent has reported and every entry fills every field. Tell me its path.
