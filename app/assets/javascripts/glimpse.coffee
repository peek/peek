#= require glimpse/vendor/jquery.cookies.js

updatePerformanceBar = ->
  glimpseResults = $('#glimpse-results')
  $('#glimpse [data-defer-to]').each ->
    deferKey = $(this).data 'defer-to'
    data = glimpseResults.data deferKey
    $(this).text data

toggleBar = (event) ->
  return if $(event.target).is ':input'

  if event.keyCode == 96
    $('#glimpse').toggleClass 'disabled'
    enable = $.cookie('glimpse') == 'false'
    $.cookie('glimpse', enable)

$(document).on 'pjax:end', updatePerformanceBar
$(document).on 'keypress', toggleBar

$ ->
  updatePerformanceBar()
