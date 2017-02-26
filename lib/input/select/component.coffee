_ = require('underscore')

module.exports = require('../input/component').extend

  template: require('./component.hamlc')

  props:
    multiple: { default: false }

  computed:

    _value:
      get: ->
        v = @getStateAttr('value')
        v = if v? then v else @value
        return v if @_multiple != true

        v = [v] if !_.isNull(v) && !_.isUndefined(v) && !_.isArray(v)
        v || []
      set: (val) ->
        @onUpdateValue(val)

    _multiple: ->
      v = @getStateAttr('multiple')
      v = if _.isBoolean(v) then v else (@multiple == true || @multiple == 'true')

    defaultClasses: ->
      'vuco-input vuco-select'

  methods:

    updateButtonLabel: ->
      _.each @.$children, (child) =>
        if _.isFunction(child.getLabelForMenuItemValue)
          if @_multiple == true
            label = []
            _.each @_value, (v) -> label.push(child.getLabelForMenuItemValue(v))
            @onUpdateStateAttribute(child._name, 'label', _.compact(label).join(', '))
          else
            @onUpdateStateAttribute(child._name, 'label', child.getLabelForMenuItemValue(@_value))

    updateForMultiValue: (value) ->
      return unless @_multiple == true

      if _.contains(@_value, value)
        @onUpdateValue(_.without(@_value, value))
      else
        @onUpdateValue(@_value.concat(value))

    onVucoMenuItemClick: (dropdownComp, menuComp, itemComp) ->
      if @_multiple == true
        @updateForMultiValue(itemComp._value)
      else
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



