import _ from 'underscore';
import Abstract from '../abstract/component';
import template from './component.hamlc';

export default Abstract.extend({

  template: template,

  computed: {

    defaultClasses: function() {
      return 'vuco-menu';
    },

    isVucoMenu: function() {
      return true;
    },

  },

  methods: {

    getLabelForMenuItemValue: function(value) {
      let label = null;

      _.each(this.$children, function(child){
        if (child._value == value) {
          if (child.hasLabel) {
            label = child._label;
          } else {
            label = child.getSlotContent();
          }
        }
      });

      return label;
    },

    onVucoMenuItemClick: function(vueComp) {
      this.$emit('vuco-menu-menu-item-click', this, vueComp)
    },

    onSelfMenuItemSelect: function(value, singleSelect = true) {
      _.each(this.$children, (child) => {
        this.onUpdateStateAttribute(child._name, 'selected', value == child._value);
      });
    },

  },

  mounted: function() {
    _.each(this.$children, (child) => {
      child.$on('vuco-menu-item-click', this.onVucoMenuItemClick);
    });

    this.$on('vuco-menu-menu-item-select', this.onSelfMenuItemSelect);
  },

  beforeDestroy: function() {
    _.each(this.$children, function(child) {
      child.$off('vuco-menu-item-click');
    });

    this.$off('vuco-menu-menu-item-select');
  },

});
