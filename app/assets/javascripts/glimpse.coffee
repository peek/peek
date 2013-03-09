#= require glimpse/vendor/jquery.cookies.js

updatePerformanceBar = ->
  glimpsePerformance = $('#glimpse-performance')
  $('#glimpse [data-defer-to]').each ->
    deferKey = $(this).data 'defer-to'
    data = glimpsePerformance.data deferKey
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
