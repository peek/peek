updatePerformanceBar = ->
  glimpse_performance = $('#glimpse_performance')
  $('#glimpse [data-defer-to]').each ->
    deferKey = $(this).data 'defer-to'
    data = glimpse_performance.data deferKey
    $(this).text data

$(document).on 'pjax:end', updatePerformanceBar

$ ->
  updatePerformanceBar()