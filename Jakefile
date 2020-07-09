const { task, rule, Task } = require('jake')
const exec = require('child_process').execSync

/**
 * Build rules for making HTML and PDF slides from annotated Markdown,
 * extracting narration scripts, and building videos (with ari).
 */

 /** Build slides HTML from Markdown with pandoc  for video images (same than html, but need some sizes fixed) */
 rule(`dist/%-video.html`, 'src/%.md', ['src/video.css'], function () {
   exec(`pandoc --webtex -t slidy+native_spans+native_divs+fenced_divs+bracketed_spans ${this.source} -f markdown+fenced_divs+bracketed_spans+definition_lists+yaml_metadata_block \
            -o ${this.name} --self-contained --css src/video.css 2>&1`)
 })

 /** Build slides HTML from Markdown with pandoc */
 rule(`dist/%-slides.html`, 'src/%.md', ['src/slides.css'], function () {
   exec(`pandoc --webtex -t slidy+native_spans+native_divs+fenced_divs+bracketed_spans ${this.source} -f markdown+fenced_divs+bracketed_spans+definition_lists+yaml_metadata_block \
            -o ${this.name} --self-contained --css src/slides.css 2>&1`)
 })



/** Build document HTML from Markdown with pandoc */
rule(`dist/%-document.html`, 'src/%.md', ['src/document.css'], function () {
  exec(`pandoc  -f markdown+fenced_divs+bracketed_spans+definition_lists+yaml_metadata_block -t html+native_spans+native_divs ${this.source} \
           -o ${this.name} --section-divs --self-contained --css src/document.css 2>&1`)
})


/** Build script from HTML */
rule(`dist/%.script`, 'dist/%-slides.html', function () {
  exec(`node ./scripts/extract-script-from-html.js ${this.source}  --translate=script-rewrite-words.yaml > ${this.name} 2>&1 `)
})



/** Build slide images */
rule(`dist/%.001.png`, 'dist/%.script', function () {
  let basename = this.name.substring(0, this.name.indexOf('.'))
  jake.attemptRule(basename + '-video.html', jake.currentNamespace).execute()
  exec(`/bin/bash ./scripts/create_images.sh -h  ${basename}-video.html -s  ${this.source} -o ${basename} 2>&1`)
})


/** Build video from images and script using ari */
rule(`dist/%.mp4`, `dist/%.script`, function () {
  // Little hack to allow pattern based dependency -- ensures images exist
  let basename = this.name.substring(0, this.name.lastIndexOf('.'))
  jake.attemptRule(basename + '.001.png', jake.currentNamespace).execute()
  // Run ari
  exec(`./scripts/run_ari_spin.R ${this.name} ${this.source} ${basename}.*.png`)
})

/** Default task: build HTML slides */
task('slides-html', ['dist/%-slides.html'])


/** Default task: build HTML document */
task('document-html', ['dist/%-document.html'])

/** Build HTML files */
task('slides-pdf', ['dist/%-slides.pdf'])

/** Build images */
task('slides-img', ['dist/%.001.png'])


/** Build script */
/** task('slides-script', ['dist/%.script']) */


/** Build video files */
task('slides-video', ['dist/%-slides.mp4'])

/** Build vuepress site that provides overall index */
task('site', function () {
  exec('vuepress build src')
})
