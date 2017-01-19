import Vue from 'vue';

import VucoButton from '../lib/button/component';
import VucoMenu from '../lib/menu/component';
import VucoMenuItem from '../lib/menu-item/component';
import VucoDropdownButton from '../lib/dropdown-button/component';
import VucoInput from '../lib/input/input/component';
import VucoTextarea from '../lib/input/textarea/component';
import VucoCheckbox from '../lib/input/checkbox/component';
import VucoSelect from '../lib/input/select/component';

Vue.component('vuco-button',          VucoButton);
Vue.component('vuco-menu',            VucoMenu);
Vue.component('vuco-menu-item',       VucoMenuItem);
Vue.component('vuco-dropdown-button', VucoDropdownButton);
Vue.component('vuco-input',           VucoInput);
Vue.component('vuco-textarea',        VucoTextarea);
Vue.component('vuco-checkbox',        VucoCheckbox);
Vue.component('vuco-select',          VucoSelect);
