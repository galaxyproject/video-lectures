# SARS-NCOV-2 / COVID-19 generated lectures

[![Netlify Status](https://api.netlify.com/api/v1/badges/d33035ea-4760-443f-bef7-c1ee3431dc51/deploy-status)](https://app.netlify.com/sites/covid19-lessons/deploys)

Framework to generate HTML, slides (HTML, pdf, images) and narrated videos
(using ari) from markdown.


# Installation

## In the terminal

conda install -y r-essentials nodejs 
conda install -y -c conda-forge ffmpeg
npm install yarn
yarn add jake

## In a R console

install.packages('ari')
install.packages('aws.polly')
install.packages('docopt')

# Usage

Write Markdown source files in `src/*.md`.

Jake tasks exist to generate slides in html, pdf, image, and video. For example,
to generate from the markdown file `src/How-to.md` run:

- HTML slides: `yarn jake dist/How-to-slides.html`
- HTML  full page: `yarn jake dist/How-to-document.pdf`
- Video: `yarn jake dist/How-to.mp4`
