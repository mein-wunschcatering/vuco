module.exports = (Vue, Vuex, options = {}) ->
  require('./setup').setup(Vue, Vuex, options)

  Vue.component('vuco-button', require('../lib/button/component'))
  Vue.component('vuco-menu', require('../lib/menu/component'))
  Vue.component('vuco-menu-item', require('../lib/menu-item/component'))
  Vue.component('vuco-dropdown-button', require('../lib/dropdown-button/component'))
  Vue.component('vuco-input', require('../lib/input/input/component'))
  Vue.component('vuco-textarea', require('../lib/input/textarea/component'))
  Vue.component('vuco-checkbox', require('../lib/input/checkbox/component'))
  Vue.component('vuco-select', require('../lib/input/select/component'))