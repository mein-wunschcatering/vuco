_ = require('underscore')

###

Options:

  * checked
  * realValue

###
module.exports = require('../abstract/component').extend

  template: require('./component.hamlc')

  props:
    checked:    { default: false }
    realValue:  { default: false }

  computed:

    _checked: ->
      v = @getStateAttr('checked')
      v = if _.isBoolean(v) then v else @checked
      v == true || v == 'true'

    _realValue: ->
      v = @getStateAttr('realValue')
      v = if _.isBoolean(v) then v else @realValue
      v == true || v == 'true'

    defaultClasses: ->
      'vuco-input vuco-checkbox'

    checkedClass: ->
      'vuco-checkbox-checked'

    isChecked: ->
      @_checked == true || @_checked == 'true'

  methods:

    onCheckClick: (event) ->
      event.preventDefault()

      return if @isDisabled == true

      @onUpdateAttribute 'checked', @isChecked == false

    updateValueByCheckedState: ->
      if @_realValue == true
        @onUpdateValue if @isChecked then @_internalValue else null
      else
        @_value = @isChecked == true

  watch:

    'checked': (newValue, oldValue) ->
      @updateValueByCheckedState()

    'realValue': (newValue, oldValue) ->
      @updateValueByCheckedState()

  mounted: ->
    @_internalValue = @_value

    if _.isBoolean(@_value) || @_value == 'true' || @_value == 'false'
      @onUpdateAttribute('checked', if @_value == 'true' || @_value == true then true else false)

    @updateValueByCheckedState()

