# Automatic generation of material from Markdown document

Framework to generate HTML, slides (HTML, pdf, images) and narrated videos (using ari) from markdown.


## Installation

Download and install https://wkhtmltopdf.org/downloads.html

### In the terminal

Download and install miniconda https://docs.conda.io/en/latest/miniconda.html

Run 'script/install.sh'


## Configuration

To use the video generation function, you need AWS identifiers.
Add them at the beginning of the Jakefile in the lines:

```
const acc_key = ""  /** enter your AWS_ACCESS_KEY_ID */
const secret_key = "" /** enter your AWS_SECRET_ACCESS_KEY */
```


## Usage

Write Markdown source files in `src/*.md`.

Jake tasks exist to generate slides in html, pdf, image, and video. For example,
to generate from the markdown file `src/How-to.md` run (From the base directory):

- HTML slides: `yarn jake dist/How-to-slides.html`
- HTML  full page: `yarn jake dist/How-to-document.html`
- Video: `yarn jake dist/How-to.mp4`


## Document structure

### Class and Id tags


Class :
```
:::::::::{ .name_class}

Block of content

::::::::::::::::::

# Line of content{ .name_class}

```

Id
```
:::::::::{ #name_id }

Block of content

::::::::::::::::::

# Line of content{ #name_id }
```

To end a block, the number of colons in the end line must be superior to the number of colons in the start line.

### Support specific classes

To display content only in the main document, use `{ .document}`


To display content only in the slides, use `{ .slide_only}`


To mark the content to be spoken in the videos, use `{ .spoken}`

For more informations, watch the how-to video.
