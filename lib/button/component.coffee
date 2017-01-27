_ = require('underscore')

module.exports = require('../abstract/component').extend

  template: require('./component.hamlc')

  props:
    label:          { default: null }
    theme:          { default: null }
    hidden:         { default: false }
    filled:         { default: false }
    block:          { default: false }
    tiny:           { default: false }
    small:          { default: false }
    large:          { default: false }
    preventDefault: { default: false }
    disabled:       { default: false }
    href:           { default: null }
    target:         { default: null }
    title:          { default: null }

  computed:

    _label: ->
      v = @getStateAttr('label')
      if _.isString(v) && _.size(v) > 0 then v else @label

    _theme: ->
      v = @getStateAttr('theme')
      if _.isString(v) && _.size(v) > 0 then v else @theme

    _hidden: ->
      v = @getStateAttr('hidden')
      if _.isBoolean(v) then v else @hidden

    _filled: ->
      v = @getStateAttr('filled')
      if _.isBoolean(v) then v else @filled

    _block: ->
      v = @getStateAttr('block')
      if _.isBoolean(v) then v else @block

    _tiny: ->
      v = @getStateAttr('tiny')
      if _.isBoolean(v) then v else @tiny

    _small: ->
      v = @getStateAttr('small')
      if _.isBoolean(v) then v else @small

    _large: ->
      v = @getStateAttr('large')
      if _.isBoolean(v) then v else @large

    _href: ->
      v = @getStateAttr('href')
      v = if _.isString(v) && _.size(v) > 0 then v else @href

      if _.isString(v) && _.size(v) > 0 then v else null

    _target: ->
      v = @getStateAttr('target')
      v = if _.isString(v) && _.size(v) > 0 then v else @target

      if _.isString(v) && _.size(v) > 0 then v else null

    _title: ->
      v = @getStateAttr('title')
      v = if _.isString(v) && _.size(v) > 0 then v else @title

      if _.isString(v) && _.size(v) > 0 then v else null

    _preventDefault: ->
      v = @getStateAttr('preventDefault')
      if _.isBoolean(v) then v else @preventDefault

    _disabled: ->
      v = @getStateAttr('disabled')
      if _.isBoolean(v) then v else @disabled

    hasLabel: ->
      _.isString(@_label) && _.size(@_label) > 0

    hasTheme: ->
      _.isString(@_theme) && _.size(@_theme) > 0

    hasSize: ->
      @isSmall || @isLarge || @isTiny

    isHidden: ->
      @_hidden == true || @_hidden == 'true'

    isFilled: ->
      @_filled == true || @_filled == 'true'

    isBlock: ->
      @_block == true || @_block == 'true'

    isTiny: ->
      @_tiny == true || @_tiny == 'true'

    isSmall: ->
      @_small == true || @_small == 'true'

    isLarge: ->
      @_large == true || @_large == 'true'

    isDefaultPrevented: ->
      @_preventDefault == true || @_preventDefault == 'true'

    isDisabled: ->
      @_disabled == true || @_disabled == 'true'

    defaultClasses: ->
      'vuco-button'

    hiddenClass: ->
      'vuco-button-hidden'

    filledClass: ->
      'vuco-button-filled'

    blockClass: ->
      'vuco-button-block'

    disabledClass: ->
      'vuco-button-disabled'

    themeClass: ->
      return '' if !_.isString(@_theme) || _.size(@_theme) <= 0

      classes = @_theme.split(' ')
      classes = _.map(classes, (str) -> "vuco-button-#{str}")
      classes.join(' ')

    sizeClass: ->
      if @isLarge
        'vuco-button-large'
      else if @isSmall
        'vuco-button-small'
      else if @isTiny
        'vuco-button-tiny'
      else
        null

  methods:

    onClick: (event) ->
      event.preventDefault() if @isDefaultPrevented || @isDisabled

      @.$emit 'click', event




