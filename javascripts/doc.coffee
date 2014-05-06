'use strict'
require.config
  shim:
    'zepto':
      exports: '$'
    'orange':
      deps: [
        'zepto'
      ]
  paths:
    'zepto': 'http://cdn.staticfile.org/zepto/1.1.3/zepto.min'
    'orange': 'https://rawgithub.com/baidao/orange/master/dist/js/orange'

require [
  'zepto'
  'orange'
], ($, orange) ->
  #delegate click to tap for not touch device
  ($(document).delegate 'body', 'click', (e) -> $(e.target).trigger 'tap') unless 'ontouchend' in window
  $ ->
    html_encode = (str) ->
      s = ''
      return '' if str.length is 0
      s = str.replace(/&/g, '&gt;')
      s = s.replace(/</g, '&lt;')
      s = s.replace(/>/g, '&gt;')
      s = s.replace(/\'/g, '&#39;')
      s = s.replace(/\'/g, '&quot;')
      s = s.replace(/\n/g, '<br>')
      return s

    #prettify code
    $('pre.lang-html').each (index, item) ->
      source = $(item).html()
      $(item).parent('.source').siblings('.perform').html("<div class='iphone'>#{source}</div>")
      $(item).html html_encode(source)
    prettyPrint()


    #plugins
    carouselWrapper = $('#carouselWrapper')
    spinnerWrapper = $('#spinnerWrapper')
    showSpinner = $('#showSpinner')
    hideSpinner = $('#hideSpinner')

    carouselWrapper.carousel()
    showSpinner.on 'tap', -> spinnerWrapper.spinner()
    hideSpinner.on 'tap', -> spinnerWrapper.spinner('hide')

    #show docs
    $('#main_content_wrap').show()
    $('#doc-spinner').remove()