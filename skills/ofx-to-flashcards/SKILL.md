---
name: ofx-to-flashcards
description: Use when turning notes taken while reading documentation into flashcards, or folding new notes into an existing flashcard file.
disable-model-invocation: true
---

# Flashcards

The **subject** is what my notes study (React, the Go scheduler, PostgreSQL indexes), and the **source** is its official documentation. Read the subject from the notes or their file path, and ask me only when neither names it.

## 1. Organize

Sort every note into a **topic**: a concept worth learning as one unit, such as `useEffect` cleanup or reconciliation keys. Merge notes that say the same thing, and split a note that crams two concepts into one line. Order the topics by prerequisite, each after the topics it builds on.

The step is done when every note is accounted for: sorted into a topic, merged into another note, or set aside as noise (a reminder to myself, a broken fragment, a link with nothing said about it).

## 2. Check against the source

Check every claim an answer will rest on against the source, through the docs tools you have or a subagent sent to read it. Dispatch the lookups in parallel, and wait for every one to report before you write.

When a note contradicts the source, the answer follows the source. When a note is too terse to answer from, fill it in from the source.

## 3. Write the cards

Write one card per **point**: a single thing my notes say about a topic. Each card takes the one kind of question its point supports:

- **Recall**: the point says what a feature is or does.
- **Why**: the point gives the problem a feature solves, or the reason behind a rule.
- **Contrast**: the point sets two neighbouring features against each other.
- **Scenario**: the point is a situation to handle, a bug to explain, or a design choice to defend.

Every question can be answered cold, out of order, with nothing on screen: it names its subject outright and states in words any code it is about, as in "Why does a React component wrapped in `memo` still re-render when its parent passes it a function declared in the parent's body?"

Every answer is one to three sentences of prose that open on the direct answer and carry only the reasoning the question asks for. When the point lives in code, add an example in the subject's own language that runs as-is when pasted into a fresh project: it imports or defines every name it uses, and holds only the lines that show the point plus the smallest stand-ins that make it run. Cover what my notes cover; a fact the source adds earns its place only when the answer is wrong or incomplete without it.

Each topic's cards sit together, in topic order, running from foundational to advanced. The file is the cards alone, in plain markdown, written to this template exactly:

````md
### <Question>

<answer>

### <Question>

<answer>

```<language>
<example>
```
````

The step is done when every card answers a point from my notes and every point has its card.

## 4. Save and report

Save the file as `<subject>-flashcards.md`, the subject in kebab case, next to the notes file, or in the current working directory when the notes were pasted.

When that file already exists, fold the new notes into it: leave every existing card word for word, add each new card after the existing cards on its topic, place a new topic's cards in prerequisite order, and skip a note whose concept a card already covers.

Report the file path, the card count per topic, every contradiction from step 2 with the note and the source both quoted, and every note set aside as noise.
