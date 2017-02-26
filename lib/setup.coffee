_ = require('underscore')

setup =
  Vue:  null
  Vuex: null
  options:
    updateActionName: 'vucoUpdateValue'
    getterName: 'vucoGetValue'
  setup: (Vue, Vuex, options = {}) ->
    setup.Vue     = Vue
    setup.Vuex    = Vuex
    setup.options = _.extend(setup.options, options)

module.exports = setup