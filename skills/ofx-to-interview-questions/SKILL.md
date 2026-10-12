---
name: ofx-to-interview-questions
description: Use when study notes, typically taken while reading programming docs, need turning into interview questions to learn from, or an existing question file needs new notes folded in.
disable-model-invocation: true
---

# Interview questions

Turn my raw notes into a markdown file of interview questions I can study from. The notes are fragments I jotted while reading documentation: half-sentences, pasted snippets, repeats, things I understood only in the moment. The file is the opposite: every question stands alone, and every answer is something I could say out loud in an interview.

The notes reach you as a file path, several paths, or text pasted into the conversation. The **subject** is what the notes study (React, the Go scheduler, PostgreSQL indexes) and the **source** is the documentation they were taken from; read both from the notes, and ask me only when neither the notes nor their file path names them.

## 1. Organize

Read every note before writing anything. Sort each one into a **topic**: a concept an interviewer would probe as one unit, such as `useEffect` cleanup or reconciliation keys. Merge notes that say the same thing, and split a note that crams two concepts into one line. Order the topics so each one comes after the topics it builds on.

The step is done when every note is accounted for: sorted into a topic, merged into another note, or set aside as noise (a reminder to myself, a broken fragment, a link with nothing said about it). Keep the set-aside notes for the report.

## 2. Check against the source

Notes taken mid-read get things wrong. For every claim an answer will rest on, check it against the source: the official docs for the subject, through the docs tools you have, or a subagent sent to read them. Dispatch the lookups in one go so they run in parallel, and let them all report before you write.

When a note contradicts the source, the answer follows the source, and the contradiction goes in the report with both versions quoted. When a note is too terse to answer from, fill it in from the source rather than from memory.

## 3. Write the questions

Write each topic as questions an interviewer would ask, one concept per question. Mix the kinds the topic supports:

- **Recall**: what a feature is and what it does.
- **Why**: the problem a feature solves, or the reason behind a rule.
- **Contrast**: the difference between two neighbouring features, and when to pick each.
- **Scenario**: a situation to handle, a bug to explain, or a design choice to defend.
- **Code reading**: a short snippet, and what it prints, renders, or gets wrong.

Every question names its subject outright, so it still reads clearly when I meet it cold, out of order. Within a topic, run from foundational to advanced.

Every answer is prose that sits directly under its question and reads as one piece with it: it opens with the direct answer in one or two sentences and runs on into the reasoning, followed by a code example whenever the concept lives in code. Keep the examples minimal and runnable, in the subject's own language. Cover what my notes cover; a fact the source adds earns its place only when the answer is wrong or incomplete without it.

The file holds questions and their answers, nothing else. Topics shape the order only: keep each topic's questions together, in topic order, with no heading of their own. Write the file to this template exactly:

````md
### <Question>

<answer>

```<language>
<example>
```

### <Question>

<answer>
````

Write in plain prose and plain markdown: no icons, no decorative symbols.

## 4. Save and report

Name the file `<subject>-interview-questions.md` in kebab case. Save it next to the notes file, or in the current working directory when the notes were pasted.

When that file already exists, fold the new notes into it: leave every existing question word for word, add each new question after the existing questions on its topic, place a new topic's questions in prerequisite order, and skip a note whose concept a question already covers.

The work is done when every topic from step 1 has its questions in the file. Then report the file path, the question count per topic, every contradiction from step 2, and every note set aside as noise, so I can confirm nothing I meant to learn was dropped.
