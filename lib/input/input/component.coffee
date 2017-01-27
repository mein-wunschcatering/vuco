_   = require('underscore')
_s  = require('underscore.string')

###

Options:

  * autocomplete
  * autofocus
  * placeholder
  * mdiIcon
  * icon
  * iconPosition
  * readonly
  * required
  * type - allowed: text, email, number, search, tel, url, password, currency
  * step
  * maxlength
  * max
  * min
  * sepDecimal
  * sepGroup
  * currPrecision
  * currValAsInteger
  * textAlign

###
module.exports = require('../abstract/component').extend

  template: require('./component.hamlc')

  props:
    placeholder:      { default: null }
    autocomplete:     { default: false }
    autofocus:        { default: false }
    textAlign:        { default: null }
    mdiIcon:          { default: null }
    icon:             { default: null }
    iconPosition:     { default: null }
    readonly:         { default: null }
    required:         { default: null }
    type:             { default: null }
    maxlength:        { default: null }
    max:              { default: null }
    min:              { default: null }
    step:             { default: null }
    sepDecimal:       { default: null }
    sepGroup:         { default: null }
    currPrecision:    { default: null }
    currValAsInteger: { default: null }

  computed:

    _placeholder: ->
      v = @getStateAttr('placeholder')
      if _.isString(v) && _.size(v) > 0 then v else (@placeholder || null)

    _autocomplete: ->
      v = @getStateAttr('autocomplete')
      v = if _.isString(v) && _.size(v) > 0 then v else (@autocomplete || null)

      if v == 'on' || v == 'off' then v else null

    _autofocus: ->
      v = @getStateAttr('autofocus')
      v = if !_.isNull(v) && !_.isUndefined(v) then v else (@autofocus || null)

      if v == 'true' || v == true then 'autofocus' else null

    _mdiIcon: ->
      v = @getStateAttr('mdiIcon')
      if _.isString(v) && _.size(v) > 0 then v else (@mdiIcon || null)

    _icon: ->
      v = @getStateAttr('icon')
      if _.isString(v) && _.size(v) > 0 then v else (@icon || null)

    _iconPosition: ->
      v = @getStateAttr('iconPosition')
      if _.isString(v) && _.size(v) > 0 then v else (@iconPosition || null)

    _readonly: ->
      v = @getStateAttr('readonly')
      v = if _.isBoolean(v) then v else @readonly

      if v == true || v == 'true' then 'readonly' else null

    _required: ->
      v = @getStateAttr('required')
      v = if _.isBoolean(v) then v else @required

      if v == true || v == 'true' then 'required' else null

    _type: ->
      v = @getStateAttr('type')
      v = if _.isString(v) && _.size(v) > 0 then v else (@type || null)

      if _.isString(v) && _.size(v) > 0 then v else 'text'

    _textAlign: ->
      v = @getStateAttr('textAlign')
      if _.isString(v) && _.size(v) > 0 then v else (@textAlign || null)

    _step: ->
      v = parseFloat(@getStateAttr('step'))
      return v if _.isNumber(v) && !_.isNaN(v) && v != 0

      v = parseFloat(@step)
      return v if _.isNumber(v) && !_.isNaN(v) && v != 0
      return null

    _maxlength: ->
      v = parseFloat(@getStateAttr('maxlength'))
      return v if _.isNumber(v) && !_.isNaN(v) && v != 0

      v = parseFloat(@maxlength)
      return v if _.isNumber(v) && !_.isNaN(v) && v != 0
      return null

    _max: ->
      v = parseFloat(@getStateAttr('max'))
      return v if _.isNumber(v) && !_.isNaN(v)

      v = parseFloat(@max)
      return v if _.isNumber(v) && !_.isNaN(v)
      return null

    _min: ->
      v = parseFloat(@getStateAttr('min'))
      return v if _.isNumber(v) && !_.isNaN(v)

      v = parseFloat(@min)
      return v if _.isNumber(v) && !_.isNaN(v)
      return 3

    _sepDecimal: ->
      v = @getStateAttr('sepDecimal')
      v = if _.isString(v) && _.size(v) > 0 then v else (@sepDecimal || null)
      if _.isString(v) && _.size(v) > 0 then v else '.'

    _sepGroup  : ->
      v = @getStateAttr('sepGroup')
      v = if _.isString(v) && _.size(v) > 0 then v else (@sepGroup || null)
      if _.isString(v) && _.size(v) > 0 then v else ','

    _currPrecision : ->
      v = parseInt(@getStateAttr('currPrecision'))
      return v if _.isNumber(v) && !_.isNaN(v)

      v = parseInt(@currPrecision)
      return v if _.isNumber(v) && !_.isNaN(v)
      return 2

    _currValAsInteger  : ->
      v = @getStateAttr('currValAsInteger')
      v = if _.isBoolean(v) then v else @currValAsInteger
      v == true || v == 'true'

    _value:
      get: ->
        if @_focussed == true && @_type == 'currency'
          @getStateAttr('_internalValue')
        else
          @valueToCurrency(@getStateAttr('value'))
      set: (newValue) ->
        @onUpdateAttribute('_internalValue', newValue)
        @onUpdateValue(@currencyToValue(newValue))

    hasIcon: ->
      return true if _.isString(@_icon) && _.size(@_icon) > 0

      _.isString(@_mdiIcon) && _.size(@_mdiIcon) > 0

    hasNormalIcon: ->
      _.isString(@_icon) && _.size(@_icon) > 0

    hasMdiIcon: ->
      return false if @hasNormalIcon == true
      return false unless @hasIcon == true

      _.isString(@_mdiIcon) && _.size(@_mdiIcon) > 0

    hasStep: ->
      step = parseFloat(@getStateAttr('step'))

      _.isNumber(step) && !_.isNaN(step) && step != 0

    isRequired: ->
      @_required == 'true' || @_required == true

    textAlignClass: ->
      "vuco-input-text-align-#{@_textAlign || 'left'}"

    requiredClass: ->
      'vuco-input-required'

    mdiClass: ->
      "mdi mdi-#{@_mdiIcon}"

    iconClass: ->
      if @_iconPosition == 'right'
        'vuco-input-icon-right'
      else
        'vuco-input-icon-left'

  methods:

    currencyToValue: (value = null) ->
      return value unless @_type == 'currency'
      return null if _.isNull(value) || _.isUndefined(value)

      value = "#{value}".replace(new RegExp("[^#{@_sepDecimal}0-9]", 'g'), '')
      value = parseFloat(value.replace(@_sepDecimal, '.'))
      value = parseInt(value * Math.pow(10, @_currPrecision)) if @_currValAsInteger
      return null if !_.isNumber(value) || _.isNaN(value)

      value

    valueToCurrency: (value = null) ->
      return value unless @_type == 'currency'
      return null if _.isNull(value) || _.isUndefined(value)

      value = parseFloat(value)
      value = parseFloat(value / Math.pow(10, @_currPrecision)) if @_currValAsInteger
      return null if !_.isNumber(value) || _.isNaN(value)

      _s.numberFormat(value, @_currPrecision, @_sepDecimal, @_sepGroup)

    onInputFocus: (event) ->
      @_focussed = true

      @fireDomEvent('focus', event)

    onInputBlur: (event) ->
      @_focussed = false

      @onUpdateAttribute('_internalValue', @valueToCurrency(@getStateAttr('value')))

      @fireDomEvent('vucoBlur', event)

    onInputKeydown: (event) ->
      # @fireDomEvent('keydown', event)

    onInputKeyup: (event) ->
      # @fireDomEvent('keyup', event)

  mounted: ->
    @_focussed = false

    if _.isNull(@_value) || _.isUndefined(@_value)
      @_value = @valueToCurrency(@value)
    else
      @onUpdateAttribute('_internalValue', @_value)

