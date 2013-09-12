fs = require('fs')
path = require('path')
glob = require('glob')
jade = require('jade')
coffee = require("coffee-script")

# File search
jadeFiles = glob.sync("*views/**/*.jade")
styleFiles = glob.sync("*styles/**/*.tss.coffee")
coffeeFiles = glob.sync("*controllers/**/*.coffee")

# Transformation functions
jade2xml = (data) ->
  jade.compile(data, pretty: true)(this)

coffee2js = (data) ->
  coffee.compile(data, {bare: true})

coffee2tss = (data) ->
  # Remove the 4 first line and the two last
  coffee2js(data).split('\n')[3...-2].join('\n')

changeFormat = (filename, from, to, transform) ->
  newFilename = filename.replace(from, to)
  data = fs.readFileSync(filename, 'utf8')
  content = transform(data)
  fs.writeFileSync(newFilename, content, 'utf8')

# Alloy specific tasks
task 'pre:compile', (event, logger) ->
  logger.info '----- COFFEE/JADE PREPROCESSOR -----'
  for jadeFile in jadeFiles
    changeFormat(jadeFile, '.jade', '.xml', jade2xml)
  for coffeeFile in coffeeFiles
    changeFormat(coffeeFile, '.coffee', '.js', coffee2js)
  for styleFile in styleFiles
    changeFormat(styleFile, '.tss.coffee', '.tss', coffee2tss)

task 'post:compile', (event, logger) ->
  logger.info '----- COFFEE/JADE POSTPROCESSOR -----'
  for jadeFile in jadeFiles
    fs.unlinkSync(jadeFile.replace('.jade', '.xml'))
  for coffeeFile in coffeeFiles
    fs.unlinkSync(coffeeFile.replace('.coffee', '.js'))
  for styleFile in styleFiles
    fs.unlinkSync(styleFile.replace('.tss.coffee', '.tss'))
