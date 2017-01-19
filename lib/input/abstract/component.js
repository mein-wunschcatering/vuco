import _ from 'underscore';
import Abstract from '../../abstract/component';

/**

Attributes
==========

  * value
  * label         - string
  * errorMessage  - string
  * hint          - string
  * disabled      - true/false
  * small         - true/false
  * large         - true/false

*/
export default Abstract.extend({

  props: {
    label:        { default: null },
    errorMessage: { default: null },
    hint:         { default: null },
    disabled:     { default: null },
    small:        { default: null },
    large:        { default: null },
    value:        { default: null },
  },

  computed: {

    _label: function() {
      let v = this.getStateAttr('label');
      return _.isString(v) && _.size(v) > 0 ? v : (this.label || null);
    },

    _errorMessage: function() {
      let v = this.getStateAttr('errorMessage');
      return _.isString(v) && _.size(v) > 0 ? v : (this.errorMessage || null);
    },

    _hint: function() {
      let v = this.getStateAttr('hint');
      return _.isString(v) && _.size(v) > 0 ? v : (this.hint || null);
    },

    _disabled: function() {
      let v = this.getStateAttr('disabled');
      return _.isBoolean(v) ? v : this.disabled;
    },

    _small: function() {
      let v = this.getStateAttr('small');
      return _.isBoolean(v) ? v : this.small;
    },

    _large: function() {
      let v = this.getStateAttr('large');
      return _.isBoolean(v) ? v : this.large;
    },

    _value: {
      get: function() {
        let v = this.getStateAttr('value');
        return v ? v : this.value;
      },
      set: function(val) {
        this.onUpdateValue(val);
      },
    },

    hasLabel: function() {
      if (!_.isString(this._label)) return false;

      return _.size(this._label) > 0 && this._label != 'false';
    },

    hasErrors: function() {
      return _.isString(this._errorMessage) && _.size(this._errorMessage) > 0;
    },

    hasHint: function() {
      return _.isString(this._hint) && _.size(this._hint) > 0;
    },

    isDisabled: function() {
      return this._disabled == 'true' || this._disabled == true;
    },

    isSmall: function() {
      return this._small == 'true' || this._small == true;
    },

    isLarge: function() {
      return this._large == 'true' || this._large == true;
    },

    defaultClasses: function() {
      return 'vuco-input';
    },

    disabledClass: function() {
      return 'vuco-input-disabled';
    },

    errorClass: function() {
      return 'vuco-input-error';
    },

    smallClass: function() {
      return 'vuco-input-small';
    },

    largeClass: function() {
      return 'vuco-input-large';
    },

  },

});