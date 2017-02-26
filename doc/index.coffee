Vue   = require('vue')
Vuex  = require('vuex')
Vue.use(Vuex)

require('../lib/index')(Vue, Vuex)

_     = require('underscore')
$     = require('jquery')
Prism = require('prismjs')

require('prismjs/plugins/normalize-whitespace/prism-normalize-whitespace')

$ ->

  window.store = new (require('vuex')).Store({
    mutations:
      'UPDATE_VALUE': (state, data) ->
        Vue.set(state, data.attr, {}) if !state[data.attr]?
        Vue.set(state[data.attr], data.key, data.value)
    state:
      btn1: {}
      btn2:
        label: 'Button'
      btn3: {}
  })

  Prism.plugins.NormalizeWhitespace.setDefaults({
    'remove-trailing':          true
    'remove-indent':            true
    'left-trim':                true
    'right-trim':               true
    'remove-initial-line-feed': false
    'indent':                   2
    'tabs-to-spaces':           2
    'spaces-to-tabs':           2
  })
  opts = {
    'remove-trailing':          true
    'remove-indent':            true
    'left-trim':                true
    'right-trim':               true
    'remove-initial-line-feed': false
    'indent':                   2
    'tabs-to-spaces':           2
    'spaces-to-tabs':           2
  }

  $('.vucoex').each ->
    html    = $(this).html()
    el      = $("<div class='vucoex-inside'><div class='vuco-example'></div><pre class='vuco-code language-html'><code></code></pre></div>")
    vueEl   = el.find('> .vuco-example')
    codeEl  = el.find('> pre > code')

    vueEl.html(html)
    codeEl.html(Prism.highlight(html.trim(), Prism.languages.html))
    $(this).html(el)

    new Vue({
      el:     vueEl.get(0)
      store:  store
    })

  $('.store-updater form').on 'submit', (event) ->
    event.preventDefault()

    attr  = "#{$(this).find('[name="attr"]').val()}"
    key   = "#{$(this).find('[name="key"]').val()}"
    value = $(this).find('[name="value"]').val()

    if _.isNumber(parseInt(value)) && !_.isNaN(parseInt(value))
      value = parseInt(value)

    if _.isNumber(parseFloat(value)) && !_.isNaN(parseFloat(value))
      value = parseFloat(value)

    value = true if value == "true"
    value = false if value == "false"

    store.commit('UPDATE_VALUE', { attr: attr, key: key, value })

  $('.navigation a').on 'click', (event) ->
    anchor = event.target.getAttribute('href').replace(/^#/, '')
    $('section').removeClass('visible')
    $("section##{anchor}").addClass('visible')

  anchor = window.location.hash.replace(/^#/, '')
  if _.size(anchor) <= 0
    $('section').first().addClass('visible')
  else
    $('section').removeClass('visible')
    $("section##{anchor}").addClass('visible')


