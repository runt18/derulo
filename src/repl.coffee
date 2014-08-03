prompt = require 'prompt'

{fatal, pretty, valueise, writeJSON} = require './util'

object = {}

# Prompt configuration. Requests a key and a value to be added to the object.
schema =
  properties:
    key:
      required: yes
    value:
      required: yes

# TODO: no globals.
filename = null

# Recursive function that implements the read loop.
read_loop = ->
  prompt.get schema,  (err, result) ->
    {key, value} = result

    if 'end' in [key, value]
      finish()
    else
      object[key] = valueise(value)
      read_loop()

# Writes the file when the REPL has finished.
finish = ->
  console.log "Here's your object:\n"
  console.log pretty object
  console.log ''
  console.log "Save this to #{filename}?"

  prompt.get ['answer'], (err, result) ->
    if result.answer is 'yes'
      writeJSON(filename, object)
      console.log "Saved to #{filename}.".green
    else
      fatal 'Cancelled.'

# Starts the REPL.
repl = (fn) ->
  filename = fn
  console.log 'Entering Derulo interactive JSON builder.'.cyan
  console.log "Enter keys and values to be added to #{filename}."
  console.log 'Type `end` at any time to finish.\n'
  prompt.start()
  read_loop()

module.exports = repl
