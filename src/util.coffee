fs = require 'fs'
detect_indent = require 'detect-indent'
{exit} = process

default_indent = 2
indent = null

# Show an error message and terminate the program.
fatal = (message) ->
  console.error(message.red)
  exit(1)

# Add the .json extension to filenames that don't have it.
normalise = (f, extension='.json') ->
  if '.' in f then f else (f + extension)

# Read the contents of a text file to a string.
read = (f) -> fs.readFileSync(f, 'utf-8')

# Read the contents of a JSON text file to an object.
readJSON = (f) ->
  f = normalise(f)
  contents = read(f)
  indent = detect_indent(contents) or default_indent

  try
    return JSON.parse(contents)
  catch e
    fatal "Invalid JSON in file #{f}"

# Write an object to a JSON file.
writeJSON = (filename, object) ->
  fs.writeFileSync(normalise(filename), pretty(object, indent))

# Pretty-print an object.
pretty = (object, indent=2) -> JSON.stringify(object, null, indent)

# Convert strings to values like 'true' -> true and '1' -> 1.
valueise = (value) ->
  try
    return JSON.parse(value)
  catch exception
    return value

module.exports = {fatal, pretty, normalise, read, readJSON, writeJSON, valueise}
