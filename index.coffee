#! /usr/bin/env coffee

'use strict'

fs = require 'fs'
require 'colors'
yaml = require 'yaml'
fuzzy = require 'fuzzy'
{docopt} = require 'docopt'
{exit} = process

version = '0.0.2'

doc = """
JSON Derulo.

Usage:
  derulo <filename> (<key> <value>)...
  derulo -d <filename> <key>...
  derulo -h | --help
  derulo -v | --version

Options:
  -h --help      Show this screen.
  -v --version   Show version.
  -d --delete    Delete keys instead of adding them
"""

opts = docopt(doc, version: version)

banner = """
/==============================================\\
   ####   #####  #####  #   #  #       ###
   #  ##  #      #   #  #   #  #      ## ##
   #   #  ###    #####  #   #  #      #   #
   #  ##  #      #  #   ## ##  #      ## ##
   ####   #####  #   #   ###   #####   ###
\\==============================================/
""".yellow


# Show an error message and terminate the program.
fatal = (message) ->
  console.error(message.red)
  exit(1)

# Add the .json extension to filenames that don't have it.
normalise = (f) -> if '.' in f then f else "#{f}.json"

# Read the contents of a text file to a string.
read = (f) -> fs.readFileSync(f, 'utf-8')

# Read the contents of a JSON text file to an object.
readJSON = (f) ->
  f = normalise(f)
  contents = read(f)

  try
    return JSON.parse(contents)
  catch e
    fatal "Invalid JSON in file #{f}"

# Write an object to a JSON file.
writeJSON = (f, o) ->
  fs.writeFileSync(normalise(f), pretty(o))

# Pretty-print an object.
pretty = (o, indent=2) -> JSON.stringify(o, null, indent)

# Convert strings to values like 'true' -> true and '1' -> 1.
valueise = (v) ->
  try
    v = JSON.parse(v)
  catch e

  return v

filename = opts['<filename>']

if fs.existsSync(normalise(filename))
  object = readJSON(filename)
else
  files = fs.readdirSync('.')
  matches = fuzzy.filter(filename, files)

  if matches.length > 0
    filename = matches[0].string
    object = readJSON(filename)
  else
    object = {}
    writeJSON(filename, object)

add = ->
  keys = opts['<key>']
  values = opts['<value>']

  for i in [0...keys.length]
    object[keys[i]] = values[i]

remove = ->
  keys = opts['<key>']

  for key in keys
    delete object[key]

main = ->
  if opts['--version']
    console.log "JSON Derulo version #{version}"
    return

  if opts['--help']
    console.log doc
    return

  if opts['--delete']
    remove()
  else
    add()

main()
writeJSON(filename, object)
