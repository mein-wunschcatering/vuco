import _ from 'underscore';
import _s from 'underscore.string';
import Abstract from '../abstract/component';
import template from './component.hamlc';

/**

Options:

  * autocomplete
  * autofocus
  * placeholder
  * mdiIcon
  * icon
  * iconPosition
  * readonly
  * required
  * type - allowed: text, email, number, search, tel, url, password, currency
  * step
  * maxlength
  * max
  * min
  * sepDecimal
  * sepGroup
  * currPrecision
  * currValAsInteger
  * textAlign

*/
export default Abstract.extend({

  template: template,

  props: {
    placeholder:      { default: null },
    autocomplete:     { default: false },
    autofocus:        { default: false },
    textAlign:        { default: null },
    mdiIcon:          { default: null },
    icon:             { default: null },
    iconPosition:     { default: null },
    readonly:         { default: null },
    required:         { default: null },
    type:             { default: null },
    maxlength:        { default: null },
    max:              { default: null },
    min:              { default: null },
    step:             { default: null },
    sepDecimal:       { default: null },
    sepGroup:         { default: null },
    currPrecision:    { default: null },
    currValAsInteger: { default: null },
  },

  computed: {

    _placeholder: function() {
      let v = this.getStateAttr('placeholder');
      return _.isString(v) && _.size(v) > 0 ? v : (this.placeholder || null);
    },

    _autocomplete: function() {
      let v = this.getStateAttr('autocomplete');
      v = _.isString(v) && _.size(v) > 0 ? v : (this.autocomplete || null);

      return v == 'on' || v == 'off' ? v : null;
    },

    _autofocus: function() {
      let v = this.getStateAttr('autofocus');
      v = !_.isNull(v) && !_.isUndefined(v) ? v : (this.autofocus || null);

      return v == 'true' || v == true ? 'autofocus' : null;
    },

    _mdiIcon: function() {
      let v = this.getStateAttr('mdiIcon');
      return _.isString(v) && _.size(v) > 0 ? v : (this.mdiIcon || null);
    },

    _icon: function() {
      let v = this.getStateAttr('icon');
      return _.isString(v) && _.size(v) > 0 ? v : (this.icon || null);
    },

    _iconPosition: function() {
      let v = this.getStateAttr('iconPosition');
      return _.isString(v) && _.size(v) > 0 ? v : (this.iconPosition || null);
    },

    _readonly: function() {
      let v = this.getStateAttr('readonly');
      v = _.isBoolean(v) ? v : this.readonly;

      return v == true || v == 'true' ? 'readonly' : null;
    },

    _required: function() {
      let v = this.getStateAttr('required');
      v = _.isBoolean(v) ? v : this.required;

      return v == true || v == 'true' ? 'required' : null;
    },

    _type: function() {
      let v = this.getStateAttr('type');
      v = _.isString(v) && _.size(v) > 0 ? v : (this.type || null);

      return _.isString(v) && _.size(v) > 0 ? v : 'text';
    },

    _textAlign: function() {
      let v = this.getStateAttr('textAlign');
      return _.isString(v) && _.size(v) > 0 ? v : (this.textAlign || null);
    },

    _step: function() {
      let v = parseFloat(this.getStateAttr('step'));
      if (_.isNumber(v) && !_.isNaN(v) && v != 0) return v;

      v = parseFloat(this.step);
      return _.isNumber(v) && !_.isNaN(v) && v != 0 ? v : null;
    },

    _maxlength: function() {
      let v = parseFloat(this.getStateAttr('maxlength'));
      if (_.isNumber(v) && !_.isNaN(v) && v != 0) return v;

      v = parseFloat(this.maxlength);
      return _.isNumber(v) && !_.isNaN(v) && v != 0 ? v : null;
    },

    _max: function() {
      let v = parseFloat(this.getStateAttr('max'));
      if (_.isNumber(v) && !_.isNaN(v)) return v;

      v = parseFloat(this.max);
      return _.isNumber(v) && !_.isNaN(v) ? v : null;
    },

    _min: function() {
      let v = parseFloat(this.getStateAttr('min'));
      if (_.isNumber(v) && !_.isNaN(v)) return v;

      v = parseFloat(this.min);
      return _.isNumber(v) && !_.isNaN(v) ? v : 3;
    },

    _sepDecimal: function() {
      let v = this.getStateAttr('sepDecimal');
      v = _.isString(v) && _.size(v) > 0 ? v : (this.sepDecimal || null);
      return _.isString(v) && _.size(v) > 0 ? v : '.';
    },

    _sepGroup  : function() {
      let v = this.getStateAttr('sepGroup');
      v = _.isString(v) && _.size(v) > 0 ? v : (this.sepGroup || null);
      return _.isString(v) && _.size(v) > 0 ? v : ',';
    },

    _currPrecision : function() {
      let v = parseInt(this.getStateAttr('currPrecision'));
      if (_.isNumber(v) && !_.isNaN(v)) return v;

      v = parseInt(this.currPrecision);
      return _.isNumber(v) && !_.isNaN(v) ? v : 2;
    },

    _currValAsInteger: function() {
      let v = this.getStateAttr('currValAsInteger');
      v = _.isBoolean(v) ? v : this.currValAsInteger;
      return v == true || v == 'true';
    },

    _value: {
      get: function() {
        if (this._focussed == true && this._type == 'currency') {
          return this.getStateAttr('_internalValue');
        } else {
          return this.valueToCurrency(this.getStateAttr('value'));
        }
      },
      set: function(newValue) {
        this.onUpdateAttribute('_internalValue', newValue);
        this.onUpdateValue(this.currencyToValue(newValue));
      },
    },

    hasIcon: function() {
      if (_.isString(this._icon) && _.size(this._icon) > 0) return true;

      return _.isString(this._mdiIcon) && _.size(this._mdiIcon) > 0;
    },

    hasNormalIcon: function() {
      return _.isString(this._icon) && _.size(this._icon) > 0;
    },

    hasMdiIcon: function() {
      if (this.hasNormalIcon == true) return false;
      if (this.hasIcon != true) return false;

      return _.isString(this._mdiIcon) && _.size(this._mdiIcon) > 0;
    },

    hasStep: function() {
      let step = parseFloat(this.getStateAttr('step'));

      return _.isNumber(step) && !_.isNaN(step) && step != 0;
    },

    isRequired: function() {
      return this._required == 'true' || this._required == true;
    },

    textAlignClass: function() {
      return `vuco-input-text-align-${this._textAlign || 'left'}`;
    },

    requiredClass: function() {
      return 'vuco-input-required';
    },

    mdiClass: function() {
      return `mdi mdi-${this._mdiIcon}`;
    },

    iconClass: function() {
      if (this._iconPosition == 'right') {
        return 'vuco-input-icon-right';
      } else {
        return 'vuco-input-icon-left';
      }
    },

  },

  methods: {

    currencyToValue: function (value = null) {
      if (this._type != 'currency') return value;
      if (_.isNull(value) || _.isUndefined(value)) return null;

      value = `${value}`.replace(new RegExp(`[^${this._sepDecimal}0-9]`, 'g'), '');
      value = parseFloat(value.replace(this._sepDecimal, '.'));
      if (this._currValAsInteger) value = parseInt(value * Math.pow(10, this._currPrecision));

      return !_.isNumber(value) || _.isNaN(value) ? null : value;
    },

    valueToCurrency: function (value = null) {
      if (this._type != 'currency') return value;
      if (_.isNull(value) || _.isUndefined(value)) return null;

      value = parseFloat(value);
      if (this._currValAsInteger) value = parseFloat(value / Math.pow(10, this._currPrecision));

      if (!_.isNumber(value) || _.isNaN(value)) return null;

      return _s.numberFormat(value, this._currPrecision, this._sepDecimal, this._sepGroup);
    },

    onInputFocus: function (event) {
      this._focussed = true;
      this.fireDomEvent('focus', event);
    },

    onInputBlur: function (event) {
      this._focussed = false;
      this.onUpdateAttribute('_internalValue', this.valueToCurrency(this.getStateAttr('value')));
      this.fireDomEvent('vucoBlur', event);
    },

    onInputKeydown: function (event) {
      // this.fireDomEvent('keydown', event);
    },

    onInputKeyup: function (event) {
      // this.fireDomEvent('keyup', event);
    },

  },

  mounted: function() {
    this._focussed = false;

    if (_.isNull(this._value) || _.isUndefined(this._value)) {
      this._value = this.valueToCurrency(this.value);
    } else {
      this.onUpdateAttribute('_internalValue', this._value);
    }
  },

});