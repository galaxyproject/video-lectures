const { task, rule, Task } = require('jake')
const exec = require('child_process').execSync
const html_style = "+native_spans+native_divs"
const md_style = "+fenced_divs+bracketed_spans+definition_lists+yaml_metadata_block"
const slidy_style = "+native_spans+native_divs+fenced_divs+bracketed_spans"


/**
 * Build rules for making HTML and PDF slides from annotated Markdown,
 * extracting narration scripts, and building videos (with ari).
 */

 /** Build slides HTML from Markdown with pandoc */
 rule(`dist/%-slides.html`, 'src/%.md', ['src/slides.css'], function () {
   exec(`pandoc --webtex -t slidy${slidy_style} ${this.source} -f markdown${md_style} \
            -o ${this.name} --self-contained --css src/slides.css 2>&1`)
 })

/** Build document HTML from Markdown with pandoc */
rule(`dist/%-document.html`, 'src/%.md', ['src/document.css'], function () {
  exec(`pandoc  -f markdown${md_style} -t html${html_style} ${this.source} \
           -o ${this.name} --section-divs --self-contained --css src/document.css 2>&1`)
})


/** Build script from HTML */
rule(`dist/%.script`, 'dist/%-slides.html', function () {
  exec(`node ./scripts/extract-script-from-html.js ${this.source}  --translate=script-rewrite-words.yaml > ${this.name} 2>&1 `)
})



/** Build slide images */
rule(`dist/%.001.png`, 'dist/%.script', function () {
  let basename = this.name.substring(0, this.name.indexOf('.'))
  exec(`bash ./scripts/create_images.sh -h  ${basename}-slides.html -s  ${this.source} -o ${basename} 2>&1`)
})



/** Build slide pdf */
rule(`dist/%-slides.pdf`, 'dist/%-slides.html' ,['src/topdf.css'], function () {
  exec(`weasyprint -s src/topdf.css  ${this.source} ${this.name}   2>&1`)
})



/** Build video from images and script using ari */
rule(`dist/%.mp4`, `dist/%.001.png`, function () {
  let basename = this.name.substring(0, this.name.lastIndexOf('.'))
  // Run ari
  exec(`./scripts/run_ari_spin.R ${this.name} ${basename}.script ${basename}.*.png 2>&1`)
})



/** Default task: build HTML slides */
task('slides-html', ['dist/%-slides.html'])


/** Default task: build HTML document */
task('document-html', ['dist/%-document.html'])

/** Build HTML files from slides */
task('slides-pdf', ['dist/%-slides.pdf'])

/** Build images */
/** task('slides-img', ['dist/%.001.png']) */


/** Build script */
/** task('slides-script', ['dist/%.script']) */


/** Build video files */
task('slides-video', ['dist/%-slides.mp4'])

/** Build vuepress site that provides overall index */
task('site', function () {
  exec('vuepress build src')
})
