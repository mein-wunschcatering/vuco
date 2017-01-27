_ = require('underscore')

###

Attributes
==========

  * value
  * label         - string
  * errorMessage  - string
  * hint          - string
  * disabled      - true/false
  * small         - true/false
  * large         - true/false



###
module.exports = require('../../abstract/component').extend

  props:
    label:        { default: null }
    errorMessage: { default: null }
    hint:         { default: null }
    disabled:     { default: null }
    small:        { default: null }
    large:        { default: null }
    value:        { default: null }

  computed:

    _label: ->
      v = @getStateAttr('label')
      if _.isString(v) && _.size(v) > 0 then v else (@label || null)

    _errorMessage: ->
      v = @getStateAttr('errorMessage')
      if _.isString(v) && _.size(v) > 0 then v else (@errorMessage || null)

    _hint: ->
      v = @getStateAttr('hint')
      if _.isString(v) && _.size(v) > 0 then v else (@hint || null)

    _disabled: ->
      v = @getStateAttr('disabled')
      if _.isBoolean(v) then v else @disabled

    _small: ->
      v = @getStateAttr('small')
      if _.isBoolean(v) then v else @small

    _large: ->
      v = @getStateAttr('large')
      if _.isBoolean(v) then v else @large

    _value:
      get: ->
        v = @getStateAttr('value')
        if v? then v else @value
      set: (val) ->
        @onUpdateValue(val)

    hasLabel: ->
      return false unless _.isString(@_label)

      _.size(@_label) > 0 && @_label != 'false'

    hasErrors: ->
      _.isString(@_errorMessage) && _.size(@_errorMessage) > 0

    hasHint: ->
      _.isString(@_hint) && _.size(@_hint) > 0

    isDisabled: ->
      @_disabled == 'true' || @_disabled == true

    isSmall: ->
      @_small == 'true' || @_small == true

    isLarge: ->
      @_large == 'true' || @_large == true

    defaultClasses: ->
      'vuco-input'

    disabledClass: ->
      'vuco-input-disabled'

    errorClass: ->
      'vuco-input-error'

    smallClass: ->
      'vuco-input-small'

    largeClass: ->
      'vuco-input-large'



