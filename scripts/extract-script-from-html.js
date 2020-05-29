const doc = `
Usage:
  extract-script-from-html.js <slides_html> --translate=YAML
`

const fs = require('fs')
const yaml = require('js-yaml')
const cheerio = require('cheerio')
const options = require('docopt').docopt(doc)

// Translation table
const transTable = yaml.safeLoad(
  fs.readFileSync(options['--translate'], 'utf8')
)

// Translate str based on key -> value pairs in transTable
function translate(str) {
  for (let [key, value] of Object.entries(transTable)) {
    str = str.replace(new RegExp(key, 'g'), value)
  }
  return str
}

// Load the HTML document
const $ = cheerio.load(fs.readFileSync(options['<slides_html>']))


// Iterate over each slide
$('.section').each((slideIndex, slideElement) => {
  // Extract all elements that should be spoken from slide contents,
  // and concatenate into a single line.
  textForSlide = []
  content =  cheerio.load(slideElement)
  content('.spoken').each((_,el)=> {
      textForSlide.push(content(el).text().replace(/\n/g,' '))
    })
  // console.log( translate( textForSlide.join( ". " ) ) )
  process.stdout.write(` ${translate(textForSlide.join(' '))}\n`)
})
