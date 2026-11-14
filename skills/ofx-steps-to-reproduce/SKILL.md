---
name: ofx-steps-to-reproduce
description: Use when a behaviour, such as a bug or what a command's option does, needs steps to reproduce it by hand.
disable-model-invocation: true
---

# Steps to reproduce

The behaviour is the one I name when invoking this skill, or else the one most recently explained in this conversation.

## 1. Trace

Read the source that decides the behaviour: its code, or, for an installed tool whose code you don't have, the installed version's man page or `--help`. Find the behaviour's **target state** there: the line where the behaviour happens, and every condition that must hold when that line runs, such as the data, the configuration, the arguments, earlier actions, and the order of events. Walk back from that line to the outermost interface that reaches it, the one people using the product touch: the UI, a CLI, an HTTP endpoint, or a library's public API. Turn each condition into the action that sets it up through that interface.

Name every control by the label the code renders and every input by the exact value to enter. Reach a condition that depends on timing through an interface lever, such as network throttling in the browser's devtools, a second tab, or a double click, and fall back to a code change, given as an exact diff, only when no lever exists.

The trace is done when every condition of the target state is set up by a step and every step is matched to the source line that decides its result. When no interface reaches the target state, reply with the condition that blocks every path and correct the explanation it contradicts, instead of writing steps.

## 2. Reply

Reply with the steps, written to this template:

```md
1. <action> → <what you see>
   _Why:_ <the part of the target state this step sets up, and the source line that sets it, as `path:line` or a quote from the man page>
```

A step gets a _Why_ line only when it sets up part of the target state.
