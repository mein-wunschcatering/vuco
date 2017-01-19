import _ from 'underscore';
import Abstract from '../abstract/component';
import template from './component.hamlc';

export default Abstract.extend({

  template: template,

  props: {
    multiple: { default: false },
    required: { default: null },
  },

  computed: {

    // _value:
    //   get: ->
    //     v = @getStateAttr('value')
    //     if v? then v else @value
    //   set: (val) ->
    //     @onUpdateValue(val)

    _multiple: function() {
      let v = this.getStateAttr('multiple');
      return _.isBoolean(v) ? v : (this.multiple == true || this.multiple == 'true');
    },

    _required: function() {
      let v = this.getStateAttr('required');
      v = _.isBoolean(v) ? v : this.required;

      return v == true || v == 'true' ? 'required' : null;
    },

    isRequired: function() {
      return this._required == 'true' || this._required == true;
    },

    defaultClasses: function() {
      return 'vuco-input vuco-select';
    },

  },

  methods: {

    updateButtonLabel: function() {
      _.each(this.$children, (child) => {
        if (_.isFunction(child.getLabelForMenuItemValue)) {
          this.onUpdateStateAttribute(child._name, 'label', child.getLabelForMenuItemValue(this._value));
        }
      });
    },

    onVucoMenuItemClick: function(dropdownComp, menuComp, itemComp) {
      this.onUpdateValue(itemComp._value);
    },

  },

  watch: {

    _value: function(newVal, oldVal) {
      _.each(this.$children, function(child) {
        child.$emit('vuco-dropdown-menu-menu-item-select', newVal, true);
      });
      this.updateButtonLabel();
    },

  },

  mounted: function() {
    _.each(this.$children, (child) => {
      child.$on('vuco-dropdown-menu-menu-item-click', this.onVucoMenuItemClick);
    });

    this.updateButtonLabel();
  },

  beforeDestroy: function() {
    _.each(this.$children, function(child) {
      child.$off('vuco-dropdown-menu-menu-item-click');
    });
  },

});
