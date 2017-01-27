_ = require('underscore')

module.exports = require('../abstract/component').extend

  template: require('./component.hamlc')

  computed:

    defaultClasses: ->
      'vuco-menu'

    isVucoMenu: ->
      true

  methods:

    getLabelForMenuItemValue: (value) ->
      label = null

      _.each @.$children, (child) =>
        if child._value == value
          if child.hasLabel
            label = child._label
          else
            label = child.getSlotContent()

      label

    onVucoMenuItemClick: (vueComp) ->
      @.$emit('vuco-menu-menu-item-click', @, vueComp)

    onSelfMenuItemSelect: (value, singleSelect = true) ->
      if _.isArray(value)
        _.each @.$children, (child) =>
          @onUpdateStateAttribute(child._name, 'selected', _.contains(value, child._value))
      else
        _.each @.$children, (child) =>
          @onUpdateStateAttribute(child._name, 'selected', value == child._value)

  mounted: ->
    _.each @.$children, (child) =>
      child.$on('vuco-menu-item-click', @onVucoMenuItemClick)

    @.$on('vuco-menu-menu-item-select', @onSelfMenuItemSelect)

  beforeDestroy: ->
    _.each @.$children, (child) =>
      child.$off('vuco-menu-item-click')

    @.$off('vuco-menu-menu-item-select')


