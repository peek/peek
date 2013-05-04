#= require peek/vendor/jquery.tipsy

getRequestId = ->
  $('#peek-results').data 'request-id'

updatePerformanceBar = (data) ->
  peekResults = $('#peek-results')
  $('#peek [data-defer-to]').each ->
    deferKey = $(this).data 'defer-to'
    $(this).text data[deferKey]

initializeTipsy = ->
  $('#peek .peek-tooltip, #peek .tooltip').each ->
    el = $(this)
    gravity = if el.hasClass('rightwards') then 'w' else 'n'
    gravity = if el.hasClass('leftwards') then 'e' else gravity
    el.tipsy { gravity }

toggleBar = (event) ->
  return if $(event.target).is ':input'

  if event.keyCode == 96 && !event.metaKey
    wrapper = $('#peek')
    if wrapper.hasClass 'disabled'
      wrapper.removeClass 'disabled'
      document.cookie = "peek=true; path=/";
    else
      wrapper.addClass 'disabled'
      document.cookie = "peek=false; path=/";

fetchRequestResults = ->
  $.ajax '/peek/results',
    data:
      request_id: getRequestId()
    success: (data, textStatus, xhr) ->
      updatePerformanceBar data
    error: (xhr, textStatus, error) ->
      console.log xhr, textStatus, error

$(document).on 'keypress', toggleBar

$(document).on 'peek:update', initializeTipsy
$(document).on 'peek:update', fetchRequestResults

# Fire the event for our own listeners.
$(document).on 'pjax:end', (xhr, options) ->
  $(this).trigger 'peek:update'

# Also listen to turbolinks page change event
$(document).on 'page:change', ->
  $(this).trigger 'peek:update'

$ ->
  $(this).trigger 'peek:update'
