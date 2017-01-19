import _ from 'underscore';
import Input from '../input/component';
import template from './component.hamlc';

/**

Options:

  * maxRows
  * minRows

*/
export default Input.extend({

  template: template,

  props: {
    maxRows: { default: null },
    minRows: { default: null },
  },

  computed: {

    defaultClasses: function() {
      return 'vuco-input vuco-textarea';
    },

    _value: {
      get: function() {
        let v = this.getStateAttr('value');
        return v ? v : this.value;
      },
      set: function(val) {
        this.onUpdateValue(val);
        this._updateMirror();
      },
    },

    _maxRows: function() {
      let v = parseInt(this.getStateAttr('maxRows'));
      if (_.isNumber(v) && !_.isNaN(v) && v != 0) return v;

      v = parseInt(this.maxRows);
      return _.isNumber(v) && !_.isNaN(v) && v != 0 ? v : null;
    },

    _minRows: function() {
      let v = parseInt(this.getStateAttr('minRows'));
      if (_.isNumber(v) && !_.isNaN(v) && v != 0) return v;

      v = parseInt(this.minRows);
      return _.isNumber(v) && !_.isNaN(v) && v != 0 ? v : null;
    },

  },

  methods: {

    _updateMirror: function(addLine = false) {
      let value = '';
      if (this.$refs.textarea) value = this.$refs.textarea.value;
      value   = value.replace(/&/gm, '&amp;').replace(/"/gm, '&quot;').replace(/'/gm, '&#39;');
      value   = value.replace(/</gm, '&lt;').replace(/>/gm, '&gt;').split('\n');
      let _tokens = null;

      if (_.isNumber(this._maxRows) && !_.isNaN(this._maxRows) && this._maxRows > 0 && value.length > this._maxRows) {
        _tokens = value.slice(0, this._maxRows);
      } else {
        _tokens = value.slice(0);
      }

      while (this._minRows > 0 && _tokens.length < this._minRows) {
        _tokens.push('');
      }

      value = _tokens.join('<br/>');
      if (addLine == true) value += '<br/>';
      value += '&#160;';

      this.$refs.mirror.innerHTML = value;
    },

  },

  mounted: function() {
    this._updateMirror();
  },

});