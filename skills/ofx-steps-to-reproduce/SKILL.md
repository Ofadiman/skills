---
name: ofx-steps-to-reproduce
description: Use when a bug needs steps to reproduce it by hand.
disable-model-invocation: true
---

# Steps to reproduce

The bug is the one I name when invoking this skill, or else the one most recently explained in this conversation.

## 1. Trace

Find the bug's **failing state**: the line where it goes wrong, and every condition that must hold when that line runs, such as the data, the configuration, earlier actions, and the order of events. Walk back from that line to the outermost interface that reaches it, the one people using the product touch: the UI, a CLI, an HTTP endpoint, or a library's public API. Turn each condition into the action that sets it up through that interface.

Name every control by the label the code renders and every input by the exact value to enter. Reach a condition that depends on timing through an interface lever, such as network throttling in the browser's devtools, a second tab, or a double click, and fall back to a code change, given as an exact diff, only when no lever exists.

The trace is done when every condition of the failing state is set up by a step and every step is matched to the code it drives. When no interface reaches the failing state, reply with the condition that blocks every path and correct the explanation it contradicts, instead of writing steps.

## 2. Run

When you can drive the interface yourself on a local instance, such as a CLI, a local HTTP endpoint, or a dev server through a browser tool, run the steps and check that they end on the bug. When a step's result differs from the one you wrote, fix that step or the explanation, and run them again.

## 3. Reply

Reply with the steps, written to this template:

```md
**Bug:** <what goes wrong, in the words of someone using the product>

**Before you start:** <the branch or build, account and role, data, configuration and flags, and browser settings the steps assume>

1. <action> → <what you see>
   _Why:_ <the part of the failing state this step sets up, and the code that sets it, as `path:line`>

**Expected:** <what should happen>

**Actual:** <what happens instead>

**Run:** <where you reproduced it, the step whose result differed, or why you could not run them>
```

A step gets a _Why_ line only when it sets up part of the failing state.
