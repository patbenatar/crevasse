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
  invoke "build:coffee"
  invoke "build:sass"

task "build:coffee", "Compile coffeescript files from src/coffee and join them in lib/js", ->
  srcFiles = "src/coffee/#{file}" for file in COFFEE_FILES
  options = [
    "-j",
    "crevasse.js",
    "-c",
    "-o",
    "lib/js",
    srcFiles
  ]
  execute "coffee", options

task "build:sass", "Compile sass files from src/sass and join them in lib/css", ->
  options = [
    "--update"
    "src/sass/crevasse.scss:lib/css/crevasse.css"
  ]
  execute "sass", options

execute = (command, options) ->
  command = spawn command, options
  command.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  command.stdout.on 'data', (data) ->
    print data.toString()
  command.on 'exit', (code) ->
    callback?() if code is 0