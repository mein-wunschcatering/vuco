import _ from 'underscore';
import Vue from 'vue';

export default Vue.extend({

  props: {
    name: { default: null },
  },

  computed: {

    _name: function() {
      return _.isUndefined(this.name) || _.isNull(this.name) ? this.getGeneratedName() : this.name
    },

    // Returns the sub-state based on _store
    _state: function() {
      return this.$store.state
    },

    // Generated unique id for each component
    componentUniqueId: function() {
      if (!this._componentUniqueId) this._componentUniqueId = this.getGeneratedName();
      return this._componentUniqueId;
    },

  },

  methods: {

    getGeneratedName: function() {
      if (!this._generatedName) this._generatedName = _.uniqueId('vuco-');
      return this._generatedName;
    },

    getStateAttr: function(name) {
      if (!_.has(this._state, this._name)) return void 0;
      if (!_.has(this._state[this._name], name)) return void 0;
      return this._state[this._name][name];
    },

    onUpdateValue: function(value) {
      return this.$store.commit('UPDATE_VALUE', { attr: this._name, key: 'value', value: value });
    },

    onUpdateAttribute: function(attrName, value) {
      return this.$store.commit('UPDATE_VALUE', { attr: this._name, key: attrName, value: value });
    },

    onUpdateStateAttribute: function(attrName, attrKey, value) {
      return this.$store.commit('UPDATE_VALUE', { attr: attrName, key: attrKey, value: value });
    },

    fireDomEvent: function(...args) {
      if (args.length <= 0 || !args[0]) return void 0;

      // event = new CustomEvent('my-custom-event', {bubbles: true, cancelable: true});
      // someElement.dispatchEvent(event);

      // el = $(@.$el)
      // el.trigger.apply(el, args)
      console.error('Fire dom event');
    },

  },

  created: function() {
    if (!_.isFunction(this.$options.template)) return void 0;

    let data = _.isFunction(this.serializeData) ? this.serializeData() : {};

    this.$options.template = this.$options.template(data);
  },

});

