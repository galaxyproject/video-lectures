#!/usr/bin/env Rscript

#"Usage:
#  run_ari.R  -o <output> -s <script> -i <image> -a <accesskey> -k <secretkey>" -> doc


"Usage:
  run_ari.R  <output> <script> <accesskey> <secretkey> <images>... " -> doc


library(ari)
library(docopt)
library(text2speech)

arguments <- docopt(doc,args = commandArgs(trailingOnly = TRUE))

script = readLines( arguments$script )
images = arguments$images
output = arguments$output


Sys.setenv("AWS_ACCESS_KEY_ID" = arguments$accesskey ,"AWS_SECRET_ACCESS_KEY" = arguments$secretkey ,"AWS_DEFAULT_REGION" = "us-east-2")

# Parse command line



# Script should have one line per slide
if ( length(script) != length(images) ) {
    stop("Script length and number of slides do not match")
}


# Run ari spin to generate audio and combine to movie

ari_spin( images, script, output,
          voice="Joanna", service="amazon" )
