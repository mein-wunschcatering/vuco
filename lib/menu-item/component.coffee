_ = require('underscore')

module.exports = require('../abstract/component').extend

  template: require('./component.hamlc')

  props:
    disabled: { default: false }
    selected: { default: false }
    value:    { default: null }

  computed:

    _value: ->
      v = @getStateAttr('value')
      if v? then v else @value

    _label: ->
      v = @getStateAttr('label')
      if _.isString(v) && _.size(v) > 0 then v else @label

    _disabled: ->
      v = @getStateAttr('disabled')
      if _.isBoolean(v) then v else (@disabled == 'true' || @disabled == true)

    _selected: ->
      v = @getStateAttr('selected')
      if _.isBoolean(v) then v else (@selected == 'true' || @selected == true)

    hasLabel: ->
      _.isString(@_label) && _.size(@_label) > 0

    isDisabled: ->
      @_disabled == true || @_disabled == 'true'

    isSelected: ->
      @_selected == true || @_selected == 'true'

    defaultClasses: ->
      'vuco-menu-item'

    disabledClass: ->
      'vuco-menu-item-disabled'

    selectedClass: ->
      'vuco-menu-item-selected'

  methods:

    getSlotContent: ->
      slot = @.$slots.default?[0]
      return unless slot?

      if _.isString(slot.elm?.outerHTML)
        slot.elm.outerHTML
      else
        slot.text

    onClick: (event) ->
      event.preventDefault()
      event.stopPropagation()

      @.$emit('vuco-menu-item-click', @)

