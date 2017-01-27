_ = require('underscore')

module.exports = require('../button/component').extend

  template: require('./component.hamlc')

  mixins: [
    require('vue-clickaway').mixin
  ]

  props:
    opened:   { default: false }
    overflow: { default: 'ellipsis' } # null, ellipsis

  computed:

    _opened: ->
      v = @getStateAttr('opened')
      if _.isBoolean(v) then v else (@opened == 'true' || @opened == true)

    defaultClasses: ->
      'vuco-button vuco-dropdown-button'

    dropdownVisibilityClass: ->
      'vuco-dropdown-button-open'

  methods:

    getLabelForMenuItemValue: (value) ->
      label = null

      _.each @.$children, (child) =>
        if _.isFunction(child.getLabelForMenuItemValue)
          label = child.getLabelForMenuItemValue(value)

      label

    onClickOutside: ->
      @onUpdateAttribute('opened', false)

    onClick: (event) ->
      event.preventDefault() if @isDefaultPrevented || @isDisabled

      if @_opened == true
        @onUpdateAttribute('opened', false)
      else
        @onUpdateAttribute('opened', true)

      @.$emit 'click', event

    onVucoMenuItemClick: (menuComp, itemComp) ->
      @onUpdateAttribute('opened', false)
      @.$emit('vuco-dropdown-menu-menu-item-click', @, menuComp, itemComp)

    onSelfMenuItemSelect: (value, singleSelect = true) ->
      _.each @.$children, (child) =>
        child.$emit('vuco-menu-menu-item-select', value, singleSelect)

  mounted: ->
    _.each @.$children, (child) =>
      child.$on('vuco-menu-menu-item-click', @onVucoMenuItemClick)

    @.$on('vuco-dropdown-menu-menu-item-select', @onSelfMenuItemSelect)

  beforeDestroy: ->
    _.each @.$children, (child) =>
      child.$off('vuco-menu-menu-item-click')

    @.$off('vuco-dropdown-menu-menu-item-select')




