#!/usr/bin/env Rscript

"Usage:
  run_ari.R <output> <script> <image>..." -> doc

library(ari)
library(docopt)
library(text2speech)

Sys.setenv("AWS_ACCESS_KEY_ID" = "","AWS_SECRET_ACCESS_KEY" = "","AWS_DEFAULT_REGION" = "us-east-2")

# Parse command line
arguments <- docopt(doc)
script = readLines( arguments$script )
images = arguments$image
output = arguments$output

# Script should have one line per slide
if ( length(script) != length(images) ) {
    stop("Script length and number of slides do not match")
}

#tts_amazon(
#  text,
#  output_format = c("mp3", "wav"),
#  voice = "Joanna",
#  bind_audio = TRUE
#)



# Run ari spin to generate audio and combine to movie

ari_spin( images, script, output,
          voice="Joanna", service="amazon" )
