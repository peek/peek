#= require glimpse/vendor/jquery.cookies
#= require glimpse/vendor/jquery.tipsy

updatePerformanceBar = ->
  glimpseResults = $('#glimpse-results')
  $('#glimpse [data-defer-to]').each ->
    deferKey = $(this).data 'defer-to'
    data = glimpseResults.data deferKey
    $(this).text data

initializeTipsy = ->
  $('#glimpse .tooltip').each ->
    el = $(this)
    gravity = if el.hasClass('rightwards') then 'w' else 'n'
    gravity = if el.hasClass('leftwards') then 'e' else gravity
    el.tipsy { gravity }

toggleBar = (event) ->
  return if $(event.target).is ':input'

  if event.keyCode == 96
    $('#glimpse').toggleClass 'disabled'
    enable = $.cookie('glimpse') == 'false'
    $.cookie('glimpse', enable)

$(document).on 'keypress', toggleBar

$(document).on 'glimpse:update', updatePerformanceBar
$(document).on 'glimpse:update', initializeTipsy

# Fire the event for our own listeners.
$(document).on 'pjax:end', ->
  $(this).trigger 'glimpse:update'

$ ->
  $(this).trigger 'glimpse:update'
