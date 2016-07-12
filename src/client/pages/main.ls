require! components
{sleep} = require "aea"

# Ractive definition
ractive = new Ractive do
    el: '#main-output'
    template: '#main-template'
    data:
        button-state: null


ractive.on \complete, ->
    i = 0
    states =
        \waiting
        \normal
        \error
        \okey

    <- :lo(op) ->
        new-state = states[i++]
        #console.log "changing state: ", new-state
        ractive.set \buttonState, new-state
        if i > 3
            i:=0
        <- sleep 5000ms
        lo(op)