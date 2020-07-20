# Automatic generation of material from Markdown document

Framework to generate HTML, slides (HTML, pdf, images) and narrated videos (using ari) from markdown.


# Installation

## In the terminal

```
conda install -y r-essentials nodejs 
conda install -y -c conda-forge ffmpeg
npm install yarn
yarn add jake
```


## In a R console

```
install.packages('ari')
install.packages('aws.polly')
install.packages('docopt')
```

# Configuration

To use the video generation function, you need AWS identifiers.
Add them to the scripts/run\_ari\_spin.R in the line:

```
Sys.setenv("AWS_ACCESS_KEY_ID" = "","AWS_SECRET_ACCESS_KEY" = "","AWS_DEFAULT_REGION" = "")
``` 


# Usage

Write Markdown source files in `src/*.md`.

Jake tasks exist to generate slides in html, pdf, image, and video. For example,
to generate from the markdown file `src/How-to.md` run (From the base directory):

- HTML slides: `yarn jake dist/How-to-slides.html`
- HTML  full page: `yarn jake dist/How-to-document.pdf`
- Video: `yarn jake dist/How-to.mp4`
