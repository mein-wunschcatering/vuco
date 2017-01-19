import _ from 'underscore';
import Abstract from '../abstract/component';
import template from './component.hamlc';

/**

Options:

  * checked
  * realValue

*/
export default Abstract.extend({

  template: template,

  props: {
    checked:    { default: false },
    realValue:  { default: false },
  },

  computed: {

    _checked: function() {
      let v = this.getStateAttr('checked');
      v = _.isBoolean(v) ? v : this.checked;
      return v == true || v == 'true';
    },

    _realValue: function() {
      let v = this.getStateAttr('realValue');
      v = _.isBoolean(v) ? v : this.realValue;
      return v == true || v == 'true';
    },

    defaultClasses: function() {
      return 'vuco-input vuco-checkbox';
    },

    checkedClass: function() {
      return 'vuco-checkbox-checked';
    },

    isChecked: function() {
      return this._checked == true || this._checked == 'true';
    },

  },

  methods: {

    onCheckClick: function(event) {
      event.preventDefault();

      if (this.isDisabled == true) return void 0;

      this.onUpdateAttribute('checked', this.isChecked == false)
    },

    updateValueByCheckedState: function() {
      if (this._realValue == true) {
        this.onUpdateValue(this.isChecked ? this._internalValue : null);
      } else {
        this._value = this.isChecked == true;
      }
    },

  },

  watch: {

    'checked': function(newValue, oldValue) {
      this.updateValueByCheckedState();
    },

    'realValue': function(newValue, oldValue) {
      this.updateValueByCheckedState();
    },

  },

  mounted: function() {
    this._internalValue = this._value;

    if (_.isBoolean(this._value) || this._value == 'true' || this._value == 'false') {
      this.onUpdateAttribute('checked', this._value == 'true' || this._value == true ? true : false);
    }

    this.updateValueByCheckedState();
  },

});
