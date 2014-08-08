'use strict'

require 'colors'

fs = require 'fs'
path = require 'path'
yaml = require 'yaml'
fuzzy = require 'fuzzy'
open = require 'open'

{docopt} = require 'docopt'
{exit} = process

{fatal, pretty, normalise, read, readJSON, writeJSON, valueise} = require './util'
repl = require './repl'

version = '0.0.13'

console.log

# Usage instructions used to build the option parser.
doc = read path.resolve(__dirname, '../help.txt')

# Parse the options into a configuration object.
opts = docopt(doc, help: false)

# console.log opts

banner = """
/==============================================\\
   ####   #####  #####  #   #  #       ###
   #  ##  #      #   #  #   #  #      ## ##
   #   #  ###    #####  #   #  #      #   #
   #  ##  #      #  #   ## ##  #      ## ##
   ####   #####  #   #   ###   #####   ###
\\==============================================/
""".yellow

# TODO: finish this.
modes =
  JSON: 1
  YAML: 2

object = null
filename = null

init = ->
  if opts['--yaml']
    extension = '.yml'
    mode = modes.YAML
  else
    extension = '.json'
    mode = modes.JSON

  filename = opts['<filename>']

  # Check if the exact filename was provided, and read it if so.
  if fs.existsSync(normalise(filename, extension))
    object = readJSON(filename)
  else
    # Do a fuzzy match on all files in the current directory if there's no exact
    # match.
    files = fs.readdirSync('.')
    matches = fuzzy.filter(filename, files)

    if matches.length > 0
      filename = matches[0].string
      object = readJSON(filename)
    # Otherwise there's no matching file at all, so create the file.
    else
      object = {}
      writeJSON(filename, object)

# Adds the key-value pairs provided on the command line arguments to the object.
add = ->
  keys = opts['<key>']
  values = opts['<value>']

  for i in [0...keys.length]
    object[keys[i]] = valueise(values[i])

# Removes the keys provided on the command line arguments from the object.
remove = ->
  keys = opts['<key>']

  for key in keys
    delete object[key]

# Main function that triggers the different program modes based on the
# command line arguments.
main = ->
  if opts['--wiggle']
    console.log '♫ Jason Derulo ♫'.cyan
    open 'https://www.youtube.com/watch?v=Ak-OUYwCbmo'
    return

  if opts['--version']
    console.log "JSON Derulo version #{version}".cyan
    return

  if opts['--help']
    console.log doc
    return

  if opts['<key>'].length is 0
    repl(normalise(opts['<filename>']))
    return

  init()

  if opts['--delete']
    remove()
  else
    add()

  writeJSON(filename, object)

# If the script is being run directly, call main, otherwise export it for use
# by whichever script is requiring it.
if require.main is module
  main()
else
  module.exports = main
