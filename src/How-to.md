---
date: July 19th, 2020
author: "Delphine Lariviere"
layout: true
lang: en-GB
keywords: ["training", "workshop"]
header-in : "[Hello everyone.]{ .spoken}"
...

:::{ .firsttitle}
# Automated generation of training materials from markdown documents
:::::::::


::::{ .authorinfo}
Delphine Lariviere, Penn State University, Galaxy project

BCC2020, July 19th
::::::::::::


:::::{ .spoken  .document}
Hello everyone, thank you for connecting to this talk. My name is Delphine Lariviere, but I am connecting with you through an artificial voice called Joanna. I work at the Pennsylvania State University, with the Galaxy Team, and today I am here to talk about the automatic generation of training material.
::::::::::


# Introduction { .slide_only}


::::::::::::::::::::{ .two_col_one_row}


:::::{ .col}

Goals
  ~ Make the creation and maintenance of training material faster and easier

Automatic generation of Content
  ~ A hands-on HTML page
  ~ An HTML Slide-show
  ~ A lecture Video

::::::::::


:::::{ .col}

1.  How it works
    1.  Workflow
1.  Create your base material
    1.  Markdown
    1.  Pandoc Markdown
    2.  Document Structure
2.  Formatting with css
2.  Usage
    1.  Slides
    2.  Web page
    3.  Video

::::::::::



::::::::::::::::::::


:::::{ .spoken  .document}
Online training is a wonderful tool to learn new skills at our own rythm. Trainers often have to consider the best way to convey their knowledge. Some people learn better by reading, some other by listening or doing. Ideally all material would be available in all formats, but it can be very time consuming. To facilitate this process, we are building three type of support from a single markdown  document : A hands-on page, slides, and a video lecture using text-to-speech.
In this lecture, we will show how to generate these different type of teaching material.
I will start by talking about the general workflow and tools that we used for this material. I will explain how to structure the base document, and then how to personalize each output. Finally, I will talk about the generation of the diverse document, and the future evolution of this project.
::::::::::


# How it works { .slide_only}


## Workflow { .slide_only}

::::{ .workflowimg}
![](src/Images/Workflow_lecture1.png)
::::::

Pandoc
 ~ This tool has been selected because it allows the creation of self contained html with different css files
 ~ We use a different css file for the Main document and the slides


:::::{ .spoken  .document}
We start by creating two documents from the original Markdown material. One is the main tutorial document, and the other is a slide show. We use pandoc to generate these HTML files because it allows us to use our own CSS files, and to create stand-alone html files, that are easier to share and manipulate.
:::::::::


# How it works { .slide_only}


## Workflow { .slide_only}

::::{ .workflowimg}
![](src/Images/Workflow_lecture2.png)
:::::::::

wkhtmltoimage
 ~ Extract an image per HTML slide
 ~ Independant of how we build the HTML


:::::{ .spoken .document}
From the slide show document, we extract the text dedicated to the text-to-speech. These block of text can be the same one that are used to be more descriptive in the main document. We extract them by parsing the html document and extracting a specific class of text. From the same HTML slide show, we extract one image per slide, using a tool neither the artificial voice not me can pronounce. This tool ha one great advantage : it is not dependant on how we built our html, making it very adaptable. We now have one image, and one paragraph per slide.
:::::::::


# How it works { .slide_only}


## Workflow { .slide_only}

::::{ .workflowimg}
![](src/Images/Workflow_lecture3.png)
:::::::::


[Ari](https://github.com/jhudsl/ari) R package
 ~ From a html and a a text file, producte a video with voice over


:::::{ .spoken .document}
We now assemble the video from these files with ari. Ari is a R package that uses Amazon Polly services to convert text to speech, and stich together the voice and images to produce a video. It is developped in Johns Hopkins Data Science Lab. The script file used to generate the video contains one line per slide, making it easy to use it as a base to generate subtitles.
:::::::::


# How it works { .slide_only}


## Workflow { .slide_only}

::::{ .workflowimg}
![](src/Images/Workflow_lecture4.png)
:::::::::


:::::{ .spoken .document}
All the tools are encapsulated in scripts managed with yarn. You simply need to ask for one of the possible output, and the necessary steps are run automatically.
:::::::::


# [Create your base material]{.bignbold} { .slide_only .maintitle}

The document contains :
  ~ Content common to all supports
  ~ Content displayed in the Slides
  ~ Content displayed in the Document
  ~ Content destined to text-to speech


:::::{ .spoken}
Let's start with your initial material in Markdown. One document will contain four set of content : The biggest set is the common core between all supports. There are the two mutually exclusive sets containing the content to be displayed only in the slide show, or only in the hands-on document. The last set contain paragraphs destined to be read by the artificial voice. This set can often overlap with the text dedicated to the hands-on document.
These seta re marked by Markdown tags. For those of you who are not familiar with markdown, I will present the lanquage rapidly before looking into these specific tags.
:::::::::


# Markdown


::::::::::::::::::::{ .two_col}

:::::{ .col}
```

### Section Title

#### Sub Section Title

This is a text where we include a list:
-   First non numbered item
    1.  First numbered item
    4.  Second numbered Item
*   Second non numbered item

```
::::::::::

:::::{ .col}
### Title

#### Sub Title

This is a text where we can include a list:

-   First non numbered item
    1.  First numbered item
    4.  Second numbered Item
*   Second non numbered item
::::::::::


:::::{.legend}
YAFIYGI format : you asked for it you got it. Form is encoded with tags in the document.
::::::::::

::::::::::::::::::::::::::::::::::::::::


:::::{ .spoken  .document}
Markdown is a text format used to generate html pages. There is no formating in the raw text, the formatting will be described in a css file and applied when the markdown is converted into html. For example, in this slide, you can see that titles are described with hashtags. The top level with one, and one more for each lower level. Lists can be encoded with number for ordered lists, or hyphens for non ordered one.  The first number of an ordered list is set to the number in the support,  but the following will increment by 1 independently of the number written in the markdown.
Markdown is a format pretty simple to use, but it is important to notice that the spacing is very important and ask for some riguor.
::::::::::


# Pandoc Markdown

## Special styles

::::::::::::::::::::{ .two_col}

:::::{ .col}
```

:::::{ .class}
For a special block of Text.
::::::::

[For a special line]{ .class}

```
::::::::::

:::::{ .col}


:::::{ .personal_class}
For a special block of text.
::::::::

[For a special word or line.]{ .personal_class}


::::::::::


:::::{.legend}

::::::::::

::::::::::::::::::::::::::::::::::::::::


Class
  ~ { .name_class}

Id
  ~ { #name_id }

:::::{ .spoken}
Markdown comes in many flavors when the elements of style become more complex. Every platform has different syntaxes to apply a certain formating to part of the document. In this version of pandoc, you can caracterize a special fragment of line by square brackets around the word, and special paragraphs with collons. The start of the paragraph is marked with at least three colons, and the end by the next line of collons containing more colons than the first one.
The name between brackets are the names of the style that we will apply to the content.
:::::::::



# Pandoc Markdown { .slide_only}


## Header


```

---
title: "How to build a wonderful presentation"
author: "Miss Bumblebee"
---

```


:::::{ .spoken  .document}
In Pandoc, One Basic structure of the document is the head. It appear to be build as a slide, but it will contain the metadata of your document: Title, author, licence an others. For the moment, this slide is deactivated because it causes problems with the parsing looking for speech paragraphs.
::::::::::


# Document Structure

## Slides structure

A new slide is created for each level 1 header `# Header`.

To avoid the repetition of titles in the Main Document, use the `.slide_only` class.


```
# Document Structure  { .slide_only}
```

:::::{ .spoken}
You do not need to insert a line to separate slides in pandoc markdown. The change of is done at each top level header. This permit to  not have random lines appearing in the hands-on  document. If you wish to continue display a title across several slides, use the slide only tag to hide the additional titles in the main HTML document.
:::::::::

# Document Structure  { .slide_only}

## Sets marking

Class tags
  ~ `.document` :  in the hand-on document and not in the slide show
  ~ `.slide_only` : in the slide show and not in the hand-on document
  ~ `.spoken` : is read by the text-to-speech in the video


:::::::::::::::::::::::::{ .two_col}


:::::{ .col}

```
:::::{ .document}
This table is useful, but impossible to present in a talk.

| Movie | Note |
|:-----:|:----:|
| The exorcist  | 8/10 |
| Scream  | 7/10 |
::::::::::

![](src/Images/table_doc.png){ .slide_only}

```

:::::::::::::::

:::::::::::{ .col}

:::::{ .document}

This table is useful, but impossible to present in a talk.

| Movie | Note |
|:-----:|:----:|
| The exorcist  | 8/10 |
| Scream  | 7/10 |

::::::::

![](src/Images/table_doc.png){ .slide_only}

:::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:::::{ .spoken}
The three tags use to mark the different sets of content are : slide only, document, and spoken. They can be used interchangeably for paragraphs or in line text. The document tag hide the content of the block in the slide show, but displays it in the hand-son document. Here, I am hidding a table that would be counter-productive in the slide show, but display it in the main document.
The slide only tag hide the content in the hand-on document and display it in the slide show. In this example, I am displaying the image of the hand-on document on the right. I don't wish to include this image in the main document to avoid an infinite loop of self screenshot.
Finally, I am currently voicing the content of the spoken tag, that does not appear in either support.
:::::::::


# [Formatting with css]{.bignbold} { .slide_only .maintitle}

Two separate css :
  ~ One for the slides
  ~ One for the Hands-on document


:::::{ .spoken}
Once we have clearly delimited the different set in the main document, the generation of the html will cleanly detangle them. CSS files, used to explicitate the format of our documents, is where the hidding and displaying takes place.
:::::::::

# Formatting with css { .slide_only}



::::::::::::::::::::{ .two_col_one_row}

:::::{ .col}

The .document class :
  - In the slide css
```css
.document {
  display: none;
}
```
  - In the document css
```css
.document {
  display: block;
  padding: 0.5rem;
  justify-content: center;
}
```

::::::::::

:::::{ .col}

The .slide_only class :
  - In the slide css
```css
.slide_only {
  display: inline ;
  visibility:  visible ;
}
```

  - In the document css
```css
.slide_only {
  display: none !important;
  visibility: hidden  !important;
  position: static;
}
```

::::::::::



::::::::::::::::::::::::::::::::::::::::

:::::{ .spoken}
We hide the different content by changing the display and visibility parameters of each class.
That is were a standalone HTML file is useful,  the css is passed as an argument to the pandoc tool, and does not need to be specified in the Markdown document. It allows to truly have the same original document for all supports.
:::::::::


# Usage


## Generate files


Note: The files will not be generated if files with the same name exist, be sure to remove previous runs from the destination folder.

To generate the files from an original document `How-to.md`

- Document
```
yarn jake dist/How-to-document.html
```

- Slides

```
yarn jake dist/How-to-slides.html
```

:::::{ .spoken}
Using the tools are made very easy by the usage of yarn.
The format of the output names is composed by the name of the original file, and the specific suffix of each output : document dot HTML for the hands-on material, slides dot HTML for the slide show, and slides dot MP four for the video.
:::::::::

# Usage { .slide_only}


## Generate files { .slide_only}

- Video

```
yarn jake dist/How-to-slides.mp4
```


Important for the generation of the video
 ~ Need of AWS access ID
 ~ Modify the script run_ari_spin.R to use it

```
Sys.setenv("AWS_ACCESS_KEY_ID" = " ","AWS_SECRET_ACCESS_KEY" = " ","AWS_DEFAULT_REGION" = "us-east-2")

```


:::::{ .spoken}
All the script and options are in the Jakefile running the different workflows. The parameters are hard coded for now, including the AWS login that needs to be entered in the R script using the ari package. In the future, we will gather all the parameters in a single parameter file for an easier use.
:::::::::

# Thank You


:::::{ .spoken}
To all of you who are talking at this conference, I know you understand the struggle of adding correction to a talk video. The text-to-speech technology solve this problem, as it only necessitate writing editing.
Another advantage of this project is the centralization of all content in a unique document, making maintenance of the material much easier.
In this project future, we want to adapt this tool to the jekyll software used by the Galaxy Training Network to convert markdown to HTML. This would permit an easier maintenance of tutorials, and the opportunity to propose video lecture. Ideally, this would become a workflow in Galaxy for an easy use.

Thank you for your attention.
I regret to not be abble to be here for the question session of the Eastern hemisphere, but please don't hesitate to find me in a Bird of a feather event, or to contact me on the BCC 2020 discord if you have any question.
:::::::::
