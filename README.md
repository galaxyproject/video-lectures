# SARS-NCOV-2 / COVID-19 generated lectures

[![Netlify Status](https://api.netlify.com/api/v1/badges/d33035ea-4760-443f-bef7-c1ee3431dc51/deploy-status)](https://app.netlify.com/sites/covid19-lessons/deploys)

Framework to generate HTML, slides (HTML, pdf, images) and narrated videos
(using ari) from markdown.

Markdown source files are in `src/*.md`.

Jake tasks exist to generate slides in html, pdf, image, and video. For example,
to generate from the markdown file `src/sars2-biology.md` run:

- HTML slides: `yarn jake dist/sars2-biology-slides.html`
- PDF slides: `yarn jake dist/sars2-biology-slides.pdf`
- Video: `yarn jake dist/sars2-biology-slides.mp4`
