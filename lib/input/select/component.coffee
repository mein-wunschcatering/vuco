_ = require('underscore')

module.exports = require('../input/component').extend

  template: require('./component.hamlc')

  props:
    multiple: { default: false }

  computed:

    # _value:
    #   get: ->
    #     v = @getStateAttr('value')
    #     if v? then v else @value
    #   set: (val) ->
    #     @onUpdateValue(val)

    _multiple: ->
      v = @getStateAttr('multiple')
      v = if _.isBoolean(v) then v else (@multiple == true || @multiple == 'true')

    defaultClasses: ->
      'vuco-input vuco-select'

  methods:

    updateButtonLabel: ->
      _.each @.$children, (child) =>
        if _.isFunction(child.getLabelForMenuItemValue)
          @onUpdateStateAttribute(child._name, 'label', child.getLabelForMenuItemValue(@_value))

    onVucoMenuItemClick: (dropdownComp, menuComp, itemComp) ->
      @onUpdateValue(itemComp._value)

  watch:

    _value: (newVal, oldVal) ->
      _.each @.$children, (child) =>
        child.$emit('vuco-dropdown-menu-menu-item-select', newVal, true)
      @updateButtonLabel()

  mounted: ->
    _.each @.$children, (child) =>
      child.$on('vuco-dropdown-menu-menu-item-click', @onVucoMenuItemClick)

    @updateButtonLabel()

  beforeDestroy: ->
    _.each @.$children, (child) =>
      child.$off('vuco-dropdown-menu-menu-item-click')