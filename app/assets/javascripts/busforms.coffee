# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'change', '.is_return_route', ->
  if $(this).is ':checked'
    $('.return-routes').hide()
  else
    $('.return-routes').show()
$(document).on 'click', '.first-bus-submit', ->
  if $('#bus_detail_is_return_route').is ':checked'
    return true
  else
    if $('.bus_detail_bus_return_routes_name').length > 0
      return true
    else
      $('.error-text').show()
      $('.error-text').text('Add Retun Route')
      return false
$(document).on 'click', '.buses', ->
  id = $(this).data('busid')
  $.ajax(
    url: '/change_bus'
    type: 'POST'
    data: bus_id: id
  )
$(document).on 'click', '.delete_selected', ->
  all = []
  selected = $('input[name=bus_name_list]:checked')
  if (selected.length > 0)
    $('input[name=bus_name_list]:checked').each ->
      all.push($(this).val())
    conf = confirm "Are You Sure!"
    if conf == true
      $.ajax(
        url: '/delete_selected_bus'
        type: 'POST'
        data: bus_ids: all
      )
    else
      return false
  else
    alert("Please Select atleast one row")
    return false