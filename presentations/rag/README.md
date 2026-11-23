# RAG presentation

This folder contains an 11-slide Marp presentation and its local images and Mermaid diagrams.

## Preview

Open `rag-presentation.md` in VS Code with the **Marp for VS Code** extension, then choose **Marp: Open Preview**. The diagrams are pre-rendered SVGs, so they also appear in the preview without a Mermaid plugin.

## Render Mermaid diagrams

Editable Mermaid sources are in `assets/diagrams/source/`. To rebuild the SVGs, install Mermaid CLI:

```powershell
npm install --global @mermaid-js/mermaid-cli
.\render-diagrams.ps1
```

The script renders each source file to a matching SVG in `assets/diagrams/`, sizes it for the slides, and applies the deck's dark-theme colors.

## Export

Install Marp CLI and run these commands from this folder:

```powershell
npm install --global @marp-team/marp-cli
marp .\rag-presentation.md --html
marp .\rag-presentation.md --pdf
marp .\rag-presentation.md --pptx
```

Keep the `assets/` folder beside the Markdown file so local images and diagrams remain available.
