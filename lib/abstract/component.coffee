_     = require('underscore')
setup = require('../setup')

module.exports = setup.Vue.extend

  props:
    name: { default: null }

  computed:

    _name: ->
      if _.isUndefined(@name) || _.isNull(@name) then @getGeneratedName() else @name

    # Generated unique id for each component
    componentUniqueId: ->
      @_componentUniqueId or= @getGeneratedName()

    # Returns the sub-state based on _store
    _state: ->
      @.$store.state

  methods:

    getGeneratedName: ->
      @_generatedName or= _.uniqueId('vuco-')

    getStateAttr: (name) ->
      @.$store.getters[setup.options.getterName](@_name, name)

    onUpdateValue: (value) ->
      @.$store.dispatch(setup.options.updateActionName, { attr: @_name, key: 'value', value: value }, { root: true })

    onUpdateAttribute: (attrName, value) ->
      @.$store.dispatch(setup.options.updateActionName, { attr: @_name, key: attrName, value: value }, { root: true })

    onUpdateStateAttribute: (attrName, attrKey, value) ->
      @.$store.dispatch(setup.options.updateActionName, { attr: attrName, key: attrKey, value: value }, { root: true })

    fireDomEvent: ->
      args = Array.prototype.slice.call(arguments)
      return unless args.length > 0 && args[0]?

      # event = new CustomEvent('my-custom-event', {bubbles: true, cancelable: true});
      # someElement.dispatchEvent(event);

      # el = $(@.$el)
      # el.trigger.apply(el, args)
      console.error 'Fire dom event'

  vuex:

    getters:

      # The only way to retrieve the state internally
      _globalState: (state) -> state


  created: ->
    return unless _.isFunction(@.$options.template)

    data = @serializeData() if _.isFunction(@serializeData)
    data or= {}

    @.$options.template = @.$options.template(data)

