#= require peek/vendor/jquery.tipsy

requestId = null

do ($ = jQuery) ->

  getRequestId = ->
    if requestId? then requestId else $('#peek').data('request-id')

  peekEnabled = ->
    $('#peek').length

  updatePerformanceBar = (results) ->
    for key of results.data
      for label of results.data[key]
        $("[data-defer-to=#{key}-#{label}]").text results.data[key][label]
    $(document).trigger 'peek:render', [getRequestId(), results]

  updateNoResults = ->
   $('[data-defer-to]').parents('.view').addClass('hidden')
   $('#peek-no-results').removeClass('hidden')

  initializeTipsy = ->
    $('#peek .peek-tooltip, #peek .tooltip').each ->
      el = $(this)
      gravity = if el.hasClass('rightwards') || el.hasClass('leftwards')
        $.fn.tipsy.autoWE
      else
        $.fn.tipsy.autoNS

      el.tipsy
        gravity: gravity

  toggleBar = (event) ->
    return if $(event.target).is ':input'

    if event.which == 96 && !event.metaKey
      wrapper = $('#peek')
      if wrapper.hasClass 'disabled'
        wrapper.removeClass 'disabled'
        setPeekEnabledCookie(true)
      else
        wrapper.addClass 'disabled'
        setPeekEnabledCookie(false)

  fetchRequestResults = ->
    $.ajax '/peek/results',
      data:
        request_id: getRequestId()
      success: (data, textStatus, xhr) ->
        if data?
          updatePerformanceBar data
        else
          updateNoResults()
      error: (xhr, textStatus, error) ->
        # Swallow the error

  setPeekEnabledCookie = (enabled) ->
    document.cookie = "peek=#{!!enabled}; path=/";

  $(document).on 'keypress', toggleBar

  $(document).on 'peek:update', initializeTipsy
  $(document).on 'peek:update', fetchRequestResults

  # Fire the event for our own listeners.
  $(document).on 'pjax:end', (event, xhr, options) ->
    if xhr?
      requestId = xhr.getResponseHeader 'X-Request-Id'
    if peekEnabled()
      $(this).trigger 'peek:update'

  # Also listen to turbolinks page change event
  $(document).on 'page:change turbolinks:load', ->
    if peekEnabled()
      $(this).trigger 'peek:update'

  $ ->
    if peekEnabled()
      setPeekEnabledCookie(true)
      $(this).trigger 'peek:update'
