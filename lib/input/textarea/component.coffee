_ = require('underscore')

###

Options:

  * maxRows
  * minRows

###
module.exports = require('../input/component').extend

  template: require('./component.hamlc')

  props:
    maxRows: { default: null }
    minRows: { default: null }

  computed:

    defaultClasses: ->
      'vuco-input vuco-textarea'

    _value:
      get: ->
        v = @getStateAttr('value')
        if v? then v else @value
      set: (val) ->
        @onUpdateValue(val)
        @_updateMirror()

    _maxRows: ->
      v = parseInt(@getStateAttr('maxRows'))
      return v if _.isNumber(v) && !_.isNaN(v) && v != 0

      v = parseInt(@maxRows)
      return v if _.isNumber(v) && !_.isNaN(v) && v != 0
      return null

    _minRows: ->
      v = parseInt(@getStateAttr('minRows'))
      return v if _.isNumber(v) && !_.isNaN(v) && v != 0

      v = parseInt(@minRows)
      return v if _.isNumber(v) && !_.isNaN(v) && v != 0
      return null

  methods:

    _updateMirror: (addLine = false) ->
      value   = @.$refs.textarea?.value || ''
      value   = value.replace(/&/gm, '&amp;').replace(/"/gm, '&quot;').replace(/'/gm, '&#39;')
      value   = value.replace(/</gm, '&lt;').replace(/>/gm, '&gt;').split('\n')
      _tokens = null

      if _.isNumber(@_maxRows) && !_.isNaN(@_maxRows) && @_maxRows > 0 && value.length > @_maxRows
        _tokens = value.slice(0, @_maxRows)
      else
        _tokens = value.slice(0)

      while @_minRows > 0 && _tokens.length < @_minRows
        _tokens.push ''

      value = _tokens.join('<br/>')
      value += '<br/>' if addLine == true
      value += '&#160;'

      @.$refs.mirror.innerHTML = value

  mounted: ->
    @_updateMirror()

