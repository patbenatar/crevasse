fs = require 'fs'

{print} = require 'util'
{spawn} = require 'child_process'

COFFEE_FILES = [
  "jquery.crevasse.coffee",
  "crevasse.coffee",
  "editor.coffee",
  "previewer.coffee"
]

task "build", "Package Crevasse for distribution", ->
  fs.readFile 'VERSION', 'utf8', (err, data) ->
    throw err if err
    version = data
    emptyLib()
    compileCoffee(false, version)
    compileSass(false, version)

task "build:tag", "Tag the git repo with the version number", ->
  fs.readFile 'VERSION', 'utf8', (err, data) ->
    throw err if err
    gitTag(data)

task "build:development", "Watch for changes in src and update development package", ->
  compileCoffee(true)
  compileSass(true)

emptyLib = ->
  execute "rm", ["-r", "lib"]

compileCoffee = (development, version = null) ->
  behavior = if development then "-w" else "-c"
  outputPath = if development then "development/lib/js" else "lib/js"
  outputFilename = if version then "crevasse-#{version}.js" else "crevasse.js"
  options = [
    "-j",
    outputFilename,
    behavior,
    "-o",
    outputPath
  ]
  # Add files to compile in proper order
  options.push "src/coffee/#{file}" for file in COFFEE_FILES
  execute "coffee", options

compileSass = (development, version = null) ->
  behavior = if development then "--watch" else "--update"
  outputPath = if development then "development/lib/css" else "lib/css"
  outputFilename = if version then "crevasse-#{version}.css" else "crevasse.css"
  options = [
    behavior,
    "src/sass/crevasse.scss:#{outputPath}/#{outputFilename}"
  ]
  execute "sass", options

gitTag = (version) ->
  execute "git", ["tag", version]

execute = (command, options) ->
  command = spawn command, options
  command.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  command.stdout.on 'data', (data) ->
    print data.toString()
  command.on 'exit', (code) ->
    callback?() if code is 0