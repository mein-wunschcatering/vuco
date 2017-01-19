import _ from 'underscore';
import Abstract from '../abstract/component';
import template from './component.hamlc';

export default Abstract.extend({

  template: template,

  props: {
    label:          { default: null },
    theme:          { default: null },
    hidden:         { default: false },
    filled:         { default: false },
    block:          { default: false },
    tiny:           { default: false },
    small:          { default: false },
    large:          { default: false },
    preventDefault: { default: false },
    disabled:       { default: false },
    href:           { default: null },
    target:         { default: null },
    title:          { default: null },
  },

  computed: {

    _label: function() {
      let v = this.getStateAttr('label');
      return _.isString(v) && _.size(v) > 0 ? v : this.label;
    },

    _theme: function() {
      let v = this.getStateAttr('theme');
      return _.isString(v) && _.size(v) > 0 ? v : this.theme;
    },

    _hidden: function() {
      let v = this.getStateAttr('hidden');
      return _.isBoolean(v) ? v : this.hidden;
    },

    _filled: function() {
      let v = this.getStateAttr('filled');
      return _.isBoolean(v) ? v : this.filled;
    },

    _block: function() {
      let v = this.getStateAttr('block');
      return _.isBoolean(v) ? v : this.block;
    },

    _tiny: function() {
      let v = this.getStateAttr('tiny');
      return _.isBoolean(v) ? v : this.tiny;
    },

    _small: function() {
      let v = this.getStateAttr('small');
      return _.isBoolean(v) ? v : this.small;
    },

    _large: function() {
      let v = this.getStateAttr('large');
      _.isBoolean(v) ? v : this.large;
    },

    _href: function() {
      let v = this.getStateAttr('href');
      v = _.isString(v) && _.size(v) > 0 ? v : this.href;

      return _.isString(v) && _.size(v) > 0 ? v : null;
    },

    _target: function() {
      let v = this.getStateAttr('target');
      v = _.isString(v) && _.size(v) > 0 ? v : this.target;

      return _.isString(v) && _.size(v) > 0 ? v : null;
    },

    _title: function() {
      let v = this.getStateAttr('title');
      v = _.isString(v) && _.size(v) > 0 ? v : this.title;

      return _.isString(v) && _.size(v) > 0 ? v : null;
    },

    _preventDefault: function() {
      let v = this.getStateAttr('preventDefault');
      return _.isBoolean(v) ? v : this.preventDefault;
    },

    _disabled: function() {
      let v = this.getStateAttr('disabled');
      return _.isBoolean(v) ? v : this.disabled;
    },

    hasLabel: function() {
      return _.isString(this._label) && _.size(this._label) > 0;
    },

    hasTheme: function() {
      return _.isString(this._theme) && _.size(this._theme) > 0;
    },

    hasSize: function() {
      return this.isSmall || this.isLarge || this.isTiny;
    },

    isHidden: function() {
      return this._hidden == true || this._hidden == 'true';
    },

    isFilled: function() {
      return this._filled == true || this._filled == 'true';
    },

    isBlock: function() {
      return this._block == true || this._block == 'true';
    },

    isTiny: function() {
      return this._tiny == true || this._tiny == 'true';
    },

    isSmall: function() {
      return this._small == true || this._small == 'true';
    },

    isLarge: function() {
      return this._large == true || this._large == 'true';
    },

    isDefaultPrevented: function() {
      return this._preventDefault == true || this._preventDefault == 'true';
    },

    isDisabled: function() {
      return this._disabled == true || this._disabled == 'true';
    },

    defaultClasses: function() {
      return 'vuco-button';
    },

    hiddenClass: function() {
      return 'vuco-button-hidden';
    },

    filledClass: function() {
      return 'vuco-button-filled';
    },

    blockClass: function() {
      return 'vuco-button-block';
    },

    disabledClass: function() {
      return 'vuco-button-disabled';
    },

    themeClass: function() {
      if (!_.isString(this._theme) || _.size(this._theme) <= 0) return '';

      let classes = this._theme.split(' ');
      classes = _.map(classes, (str) => `vuco-button-${str}`);
      return classes.join(' ');
    },

    sizeClass: function() {
      if (this.isLarge) return 'vuco-button-large';
      if (this.isSmall) return 'vuco-button-small';
      if (this.isTiny) return 'vuco-button-tiny';
      return void 0;
    },

  },

  methods: {

    onClick: function(event) {
      if (this.isDefaultPrevented || this.isDisabled) event.preventDefault();

      this.$emit('click', event);
    }

  },

});


