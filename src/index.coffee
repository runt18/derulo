#! /usr/bin/env coffee

'use strict'

require 'colors'

fs = require 'fs'
yaml = require 'yaml'
fuzzy = require 'fuzzy'

{docopt} = require 'docopt'
{exit} = process
{fatal, pretty, normalise, readJSON, writeJSON, valueise} = require './util'

version = '0.0.7'

doc = """
JSON Derulo.

Usage:
  derulo [-y] <filename> (<key> <value>)...
  derulo -d [-y] <filename> <key>...
  derulo -h | --help
  derulo -v | --version

Options:
  -h --help      Show this screen.
  -v --version   Show version.
  -d --delete    Delete keys instead of adding them.
  -y --yaml      Operate on YAML files instead of JSON.
"""

opts = docopt(doc, version: version)

console.log opts

banner = """
/==============================================\\
   ####   #####  #####  #   #  #       ###
   #  ##  #      #   #  #   #  #      ## ##
   #   #  ###    #####  #   #  #      #   #
   #  ##  #      #  #   ## ##  #      ## ##
   ####   #####  #   #   ###   #####   ###
\\==============================================/
""".yellow

modes =
  JSON: 1
  YAML: 2

if opts['--yaml']
  extension = '.yml'
  mode = modes.YAML
else
  extension = '.json'
  mode = modes.JSON

filename = opts['<filename>']

if fs.existsSync(normalise(filename, extension))
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
