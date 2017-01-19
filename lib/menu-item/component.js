import _ from 'underscore';
import Abstract from '../abstract/component';
import template from './component.hamlc';

export default Abstract.extend({

  template: template,

  props: {
    disabled: { default: false },
    selected: { default: false },
    value:    { default: null },
  },

  computed: {

    _value: function() {
      let v = this.getStateAttr('value');
      return v ? v : this.value;
    },

    _label: function() {
      let v = this.getStateAttr('label');
      return _.isString(v) && _.size(v) > 0 ? v : this.label;
    },

    _disabled: function() {
      let v = this.getStateAttr('disabled');
      return _.isBoolean(v) ? v : (this.disabled == 'true' || this.disabled == true);
    },

    _selected: function() {
      let v = this.getStateAttr('selected');
      return _.isBoolean(v) ? v : (this.selected == 'true' || this.selected == true);
    },

    hasLabel: function() {
      return _.isString(this._label) && _.size(this._label) > 0;
    },

    isDisabled: function() {
      return this._disabled == true || this._disabled == 'true';
    },

    isSelected: function() {
      return this._selected == true || this._selected == 'true';
    },

    defaultClasses: function() {
      return 'vuco-menu-item';
    },

    disabledClass: function() {
      return 'vuco-menu-item-disabled';
    },

    selectedClass: function() {
      return 'vuco-menu-item-selected';
    },

  },

  methods: {

    getSlotContent: function() {
      let slot = this.$slots.default ? this.$slots.default[0] : void 0;
      if (!slot) return void 0;

      if (slot.elm && _.isString(slot.elm.outerHTML)) {
        return slot.elm.outerHTML;
      } else {
        return slot.text;
      }
    },

    onClick: function(event) {
      event.preventDefault();
      event.stopPropagation();

      this.$emit('vuco-menu-item-click', this);
    },

  },

});