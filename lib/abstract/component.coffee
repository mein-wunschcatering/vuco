_ = require('underscore')

module.exports = require('vue').extend

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
      if @_state[@_name]?[name]? then @_state[@_name][name] else null

    onUpdateValue: (value) ->
      @.$store.commit('UPDATE_VALUE', { attr: @_name, key: 'value', value: value })

    onUpdateAttribute: (attrName, value) ->
      @.$store.commit('UPDATE_VALUE', { attr: @_name, key: attrName, value: value })

    onUpdateStateAttribute: (attrName, attrKey, value) ->
      @.$store.commit('UPDATE_VALUE', { attr: attrName, key: attrKey, value: value })

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

