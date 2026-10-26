---
name: ofx-to-flashcards
description: Use when study notes, typically taken while reading programming docs, need turning into flashcards to learn from, or an existing flashcard file needs new notes folded in.
disable-model-invocation: true
---

# Flashcards

Turn my raw notes into a markdown file of flashcards I can study from. A **card** is one question with its answer beneath it. The notes are fragments I jotted while reading documentation: half-sentences, pasted snippets, repeats, things I understood only in the moment. The file is the opposite: every card stands alone, and every answer is something I could say out loud from memory.

The notes reach you as a file path, several paths, or text pasted into the conversation. The **subject** is what the notes study (React, the Go scheduler, PostgreSQL indexes) and the **source** is the documentation they were taken from; read both from the notes, and ask me only when neither the notes nor their file path names them.

## 1. Organize

Read every note before writing anything. Sort each one into a **topic**: a concept worth learning as one unit, such as `useEffect` cleanup or reconciliation keys. Merge notes that say the same thing, and split a note that crams two concepts into one line. Order the topics so each one comes after the topics it builds on.

The step is done when every note is accounted for: sorted into a topic, merged into another note, or set aside as noise (a reminder to myself, a broken fragment, a link with nothing said about it). Keep the set-aside notes for the report.

## 2. Check against the source

Notes taken mid-read get things wrong. For every claim an answer will rest on, check it against the source: the official docs for the subject, through the docs tools you have, or a subagent sent to read them. Dispatch the lookups in one go so they run in parallel, and let them all report before you write.

When a note contradicts the source, the answer follows the source, and the contradiction goes in the report with both versions quoted. When a note is too terse to answer from, fill it in from the source rather than from memory.

## 3. Write the cards

Write one card per **point**: a single thing my notes say about a topic. The notes set the count, so a short set of notes makes a short file. Each card takes the one kind of question its point supports:

- **Recall**: the point says what a feature is or does.
- **Why**: the point gives the problem a feature solves, or the reason behind a rule.
- **Contrast**: the point sets two neighbouring features against each other.
- **Scenario**: the point is a situation to handle, a bug to explain, or a design choice to defend.

Every question is one I could hear read out loud and answer with nothing on screen. It names its subject outright and states in words any code it is about, so I can answer it cold, out of order, before reading the example below it: "Why does a React component wrapped in `memo` still re-render when its parent passes it a function declared in the parent's body?" Within a topic, run from foundational to advanced.

Every answer reads on from its question and fits on the back of an index card: one to three sentences of prose that open on the direct answer and carry only the reasoning the question asks for. When the point lives in code, add a runnable example in the subject's own language: it imports or defines every name it uses, so it runs as-is when pasted into a fresh project. Keep it minimal: the lines that show the point, plus the smallest stand-ins that make it run. Cover what my notes cover; a fact the source adds earns its place only when the answer is wrong or incomplete without it.

The step is done when every card answers a point from my notes and every point has its card.

The file holds cards, nothing else. Topics shape the order only: keep each topic's cards together, in topic order, with no heading of their own. Write the file to this template exactly:

````md
### <Question>

<answer>

### <Question>

<answer>

```<language>
<example>
```
````

Write in plain prose and plain markdown: no icons, no decorative symbols.

## 4. Save and report

Name the file `<subject>-flashcards.md` in kebab case. Save it next to the notes file, or in the current working directory when the notes were pasted.

When that file already exists, fold the new notes into it: leave every existing card word for word, add each new card after the existing cards on its topic, place a new topic's cards in prerequisite order, and skip a note whose concept a card already covers.

The work is done when every topic from step 1 has its cards in the file. Then report the file path, the card count per topic, every contradiction from step 2, and every note set aside as noise, so I can confirm nothing I meant to learn was dropped.
