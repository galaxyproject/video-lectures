const { task, rule, Task } = require('jake')
const exec = require('child_process').execSync

/**
 * Build rules for making HTML and PDF slides from annotated Markdown,
 * extracting narration scripts, and building videos (with ari).
 */

/** Build CSS to be used by Marp HTML presentations
rule('src/%.css', 'src/%.scss', function () {
  exec(`mkdir -p dist`)
  exec(`node-sass \
          --importer node_modules/node-sass-package-importer/dist/cli.js \
          ${this.source} > ${this.name}`)
}) */

/** Build slides HTML from Markdown with Marp
rule(`dist/%-slides.html`, 'src/%.md', ['src/slides.css'], function () {
  exec(`marp --engine ./lib/marp-engine.js \
          --html ${this.source} -o ${this.name} 2>&1`)
}) */

/** Build slides PDF */
rule(`dist/%-slides.pdf`, 'src/%.md', ['src/slides.css'], function () {
  exec(`node ./scripts/marp-cli-wrapper.js \
            --engine ./lib/marp-engine.js \
            --html ${this.source} -o ${this.name} 2>&1`)
})

/** Build slide images */
rule(`dist/%-slides.001.png`, 'src/%.md', ['src/slides.css'], function () {
  let dest = this.name.replace('.001', '')
  exec(`marp --engine ./lib/marp-engine.js \
          --html ${this.source} --images png -o ${dest} 2>&1`)
})


/** Build slides HTML from Markdown with pandoc */
rule(`dist/%-slides.html`, 'src/%.md', ['src/slides.css'], function () {
  exec(`pandoc -t slidy ${this.source} \
           -o ${this.name} --self-contained --css src/slides.css 2>&1`)
})

/** Build document HTML from Markdown with pandoc */
rule(`dist/%-document.html`, 'src/%.md', ['src/document.css'], function () {
  exec(`pandoc  -f markdown_mmd -t html ${this.source} \
           -o ${this.name} --self-contained --css src/document.css 2>&1`)
})

/** Build script from HTML */
rule(`dist/%-slides.script`, `dist/%-slides.html`, function () {
  exec(`node ./scripts/extract-script-from-html.js ${this.source} \
          --translate=script-rewrite-words.yaml > ${this.name}`)
})

/** Build video from images and script using ari */
rule(`dist/%-slides.mp4`, `dist/%-slides.script`, function () {
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

/** Build video files */
task('slides-video', ['dist/%-slides.mp4'])

/** Build vuepress site that provides overall index */
task('site', function () {
  exec('vuepress build src')
})
