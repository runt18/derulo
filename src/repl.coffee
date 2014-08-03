prompt = require 'prompt'

{fatal, pretty, valueise, writeJSON} = require './util'

object = {}

schema =
  properties:
    key:
      required: yes
    value:
      required: yes

filename = null

read_loop = ->
  prompt.get schema,  (err, result) ->
    {key, value} = result

    if 'end' in [key, value]
      finish()
    else
      object[key] = valueise(value)
      read_loop()

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

repl = (fn) ->
  filename = fn
  console.log 'Entering Derulo interactive JSON builder.'.cyan
  prompt.start()
  read_loop()

module.exports = repl
