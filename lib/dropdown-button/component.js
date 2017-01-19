import _ from 'underscore';
import VueClickAway from 'vue-clickaway';
import Button from '../button/component';
import template from './component.hamlc';

export default Button.extend({

  template: template,

  mixins: [
    VueClickAway.mixin
  ],

  props: {
    opened: { default: false },
  },

  computed: {

    _opened: function() {
      let v = this.getStateAttr('opened');
      return _.isBoolean(v) ? v : (this.opened == 'true' || this.opened == true);
    },

    defaultClasses: function() {
      return 'vuco-button vuco-dropdown-button';
    },

    dropdownVisibilityClass: function() {
      return 'vuco-dropdown-button-content-open';
    },

  },

  methods: {

    getLabelForMenuItemValue: function(value) {
      let label = null;

      _.each(this.$children, function(child) {
        if (_.isFunction(child.getLabelForMenuItemValue)) {
          label = child.getLabelForMenuItemValue(value);
        }
      });

      return label;
    },

    onClickOutside: function() {
      this.onUpdateAttribute('opened', false);
    },

    onClick: function(event) {
      if (this.isDefaultPrevented || this.isDisabled) event.preventDefault();

      if (this._opened == true) {
        this.onUpdateAttribute('opened', false);
      } else {
        this.onUpdateAttribute('opened', true);
      }

      this.$emit('click', event);
    },

    onVucoMenuItemClick: function(menuComp, itemComp) {
      this.onUpdateAttribute('opened', false);
      this.$emit('vuco-dropdown-menu-menu-item-click', this, menuComp, itemComp);
    },

    onSelfMenuItemSelect: function(value, singleSelect = true) {
      _.each(this.$children, function(child) {
        child.$emit('vuco-menu-menu-item-select', value, singleSelect);
      });
    },

  },

  mounted: function() {
    _.each(this.$children, (child) => {
      child.$on('vuco-menu-menu-item-click', this.onVucoMenuItemClick);
    });

    this.$on('vuco-dropdown-menu-menu-item-select', this.onSelfMenuItemSelect);

  },

  beforeDestroy: function() {
    _.each(this.$children, function(child) {
      child.$off('vuco-menu-menu-item-click');
    });

    this.$off('vuco-dropdown-menu-menu-item-select');
  },

});
