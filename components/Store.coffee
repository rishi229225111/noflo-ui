noflo = require 'noflo'

exports.getComponent = ->
  c = new noflo.Component
  c.inPorts.add 'in',
    datatype: 'all'
  c.inPorts.add 'state',
    datatype: 'object'
  c.outPorts.add 'out',
    datatype: 'object'

  c.inPorts.state.on 'data', (data) ->
    c.state = data

  c.state = {}
  c.shutdown = ->
    c.state = {}

  noflo.helpers.WirePattern c,
    forwardGroups: true
    async: true
  , (data, groups, out, callback) ->
    out.send
      state: c.state
      payload: data
    do callback