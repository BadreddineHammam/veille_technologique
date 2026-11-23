---
marp: true
theme: default
paginate: true
size: 16:9
style: |
  section {
    font-family: "Segoe UI", Aptos, sans-serif;
    background: #0b132b;
    color: #f5f7fb;
    padding: 46px 62px;
    font-size: 24px;
  }
  section h1 {
    color: #8bdcff;
    font-size: 1.8em;
    margin: 0 0 20px;
  }
  section p {
    line-height: 1.3;
    margin: 0.15em 0;
  }
  section strong { color: #8bdcff; }
  section::after {
    color: #9eb2cc;
    font-size: 0.6em;
  }
  section img[src*="assets/diagrams/"] {
    display: block;
    width: 100%;
    height: auto;
    max-width: 100%;
    max-height: 320px;
    object-fit: contain;
    margin: 14px auto 0;
  }
  section.cover {
    display: grid;
    grid-template-rows: 1fr 1.15fr 0.65fr;
    padding: 28px 62px;
    text-align: center;
  }
  .cover-images {
    display: grid;
    grid-template-columns: 1fr 1fr;
    align-items: center;
    justify-items: center;
  }
  .cover-images img {
    width: 200px;
    height: 200px;
    object-fit: contain;
    border-radius: 24px;
  }
  .cover-headline {
    align-self: center;
  }
  section.cover h1 {
    font-size: 2.1em;
    margin: 0 0 12px;
    color: #8bdcff;
  }
  .cover-subtitle {
    color: #c5d5e8;
    font-size: 1.15em;
  }
  .cover-credits {
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: 8px;
    color: #c5d5e8;
    font-size: 0.82em;
  }
---

<!-- _class: cover -->

<div class="cover-images">
  <img src="assets/images/ai.png" alt="Artificial intelligence network" width="200" />
  <img src="assets/images/documents.png" alt="Documents" width="200" />
</div>
<div class="cover-headline">
  <h1>VEILLE TECHNOLOGIQUE</h1>
  <p class="cover-subtitle">RAG – Retrieval-Augmented Generation</p>
</div>
<div class="cover-credits">
  <p>This work was created by Badreddine Hammam</p>
  <p>Formateur: Fouad SERRAG</p>
</div>

---

# What is RAG?

RAG lets AI search your documents before it answers. It uses useful facts from them to make a better answer.

![](assets/diagrams/slide-02.svg)

---

# Why do we need RAG?

AI alone may not know private company facts. RAG checks the company files first.

![](assets/diagrams/slide-03.svg)

---

# How does RAG work?

- **Documents:** Give the system your files.
- **Retrieval:** Find useful parts in those files.
- **Augmentation:** Add the useful parts to the question.
- **Generation:** AI writes an answer using those parts.

![](assets/diagrams/slide-04.svg)

---

# Real example: Education

A student asks, “How do I make a PHP variable?” The answer is in a course PDF.

![](assets/diagrams/slide-05.svg)

---

# Real example: Companies

A customer asks for a product price. RAG checks the company price list.

![](assets/diagrams/slide-06.svg)

---

# Real example: Customer support

A customer asks about returning a product. RAG checks the return rules.

![](assets/diagrams/slide-07.svg)

---

# Important RAG technologies

- **Retriever:** Finds useful text.
- **Embeddings:** Turn text into number patterns that help compare meaning.
- **Vector database:** Stores those patterns and helps find similar text.
- **LLM:** The AI that writes the answer.

![](assets/diagrams/slide-08.svg)

---

# Two limits to remember

- **Wrong information:** Bad search results can lead to a wrong answer.
- **Complexity:** Several parts must work together.

![](assets/diagrams/slide-09.svg)

---

# How to build a simple RAG system

Collect course files, split them into small pieces, make number patterns, store them, then connect search to AI.

![](assets/diagrams/slide-10.svg)

---

# Conclusion

RAG allows AI to search external documents before generating an answer.

![](assets/diagrams/slide-11.svg)
