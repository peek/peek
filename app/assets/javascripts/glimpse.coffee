updatePerformanceBar = ->
  glimpsePerformance = $('#glimpse-performance')
  $('#glimpse [data-defer-to]').each ->
    deferKey = $(this).data 'defer-to'
    data = glimpsePerformance.data deferKey
    $(this).text data

$(document).on 'pjax:end', updatePerformanceBar

$ ->
  updatePerformanceBar()