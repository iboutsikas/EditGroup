###*
# Validates the whole form using the Judge Gem.
#
# @param {object} form The form object.
# @returns {boolean} True if all field validate.
###
@validateForm = (form) ->
  valid = true

  inputs = $(form).find('.required .form-control')
  inputs.each (index, element) ->
    valid = false if !validateFormElement(element)
    return

  return valid

###*
# Validates an input field of the form using the Judge Gem.
#
# @param {object} elem An input field of a form.
# @returns {boolean} True if field validates.
###
@validateFormElement = (elem) ->
  valid = true

  judge.validate elem,

    valid: (element) ->
      element.style.border = '1px solid #ccc'
      $("label[for='#{element.id}']").css('color','#73879C')
      toggleSubmitButton true
      document.getElementById("#{element.name}").innerHTML = ""
      valid = true
      return

    invalid: (element, messages) ->
      # fail silently if judge validation doen't work for email
      if elem.name == "member[email]"
        return true if messages[0] == "Judge validation for Member#email not allowed"

      element.style.border = '1px solid #a94442'
      $("label[for='#{element.id}']").css('color','#a94442')
      document.getElementById("#{element.name}").innerHTML = '* ' + messages.join('<br>* ')
      valid = false
      return

  return valid

###*
# Enables/Disables the submit button of the modal. Changes the
# colour of the button to grey if the button is disabled.
#
# value: String that corresponds to the resource of the
#           current page. Preceded by # i.e. #project, #member
###
@toggleSubmitButton = (value) ->
  $('#saveModalBtn').prop('disabled', !value);
  if value
    $('#saveModalBtn').css('background','#f05f40');
  else
    $('#saveModalBtn').css('background','grey');

###*
# Hide the modal and redraw the datatable.
#
# @param {string} resource Corresponds to the resource of the current
#                          page. Should be preceded by # i.e. #project, #member
###
@hide_and_redraw = (resource) ->
  $(resource).modal 'hide'
  redraw_table(resource)

@hide_and_redraw = () ->
  $('.modal').modal 'hide'
  redraw_table()

###*
# Redraw the datatable.
#
# resource: String that corresponds to the resource of the
#           current page. Preceded by # i.e. #project, #member
###
@redraw_table = (resource) ->
  $(resource + "s-table").dataTable().api().ajax.reload()

@redraw_table = () ->
  $('table').dataTable().api().ajax.reload()

###*
# Executed when the edit button is pressed. Changes the label in
# the modal as well as the button, disables the submit button,
# shows the modal and places focus on the first non-hidden field.
#
# @param {string} resource Corresponds to the resource of the current
#                          page. Should be preceded by # i.e. #project, #member
###
@editButtonPressed = (resource) ->
  $("#myModalLabel").html "Edit " + resource
  $("#saveModalBtn").html("Save Changes");
  toggleSubmitButton false
  $(".modal").first().modal 'show'
  $(".modal").first().on 'shown.bs.modal', ->
    $('form:first *:input[type!=hidden]:first').focus()

###*
# Executed when the new button is pressed. Changes the label in
# the modal as well as the button, disables the submit button,
# shows the modal and places focus on the first non-hidden field.
#
###
@newButtonPressed = (resource) ->
  $('#myModalLabel').html "New " + resource
  $('#saveModalBtn').html 'Create'
  toggleSubmitButton false
  $(".modal").first().modal 'show'
  $(".modal").first().on 'shown.bs.modal', ->
    $('form:first *:input[type!=hidden]:first').focus()

###*
# Alter the modals appearce to create a custom confirmation modal.
# The original buttons are hidden and not removed in order to preserve
# the event listeners. The confirmation button is added to the footer
# and the styling classes are added to the modal-content
#
# @param {object} button the delete button, duplicated, without the confirmation part
#
###
@changeToConfirmationModal = (button) ->
  $('#modal_original_buttons').css('display','none')
  $('#modal_confirmation_buttons').html button
  $('#myModalLabel').html "Are You Sure?"
  $('.modal-content').addClass 'alert-danger modal-alert'

###*
# Attach the default event listeners for the modal submit button.
# It unbinds the button first to clear it of any alternative mappings.
# When the button is clicked, the form is validated and if true is submitted,
# or the button is disabled. The ENTER key is also bound to trigger the submit button.
#
###
@bind_modal_submit_default =  () ->
  $("#saveModalBtn").unbind()
  $('.modal').first().off('keypress')

  $("#saveModalBtn").click ->
    if validateForm('form')
      formSubmit()
    else
      toggleSubmitButton(false)

  $('.modal').first().keypress (e) ->
    if e.which == 13
      e.preventDefault()
      $("#saveModalBtn").trigger 'click'

###*
# Bind the modal button in order to handle the special case of selecting multiple
# authors from the database. First unbind any event handlers to avoid duplicate calls.
# Check if the user has selected some author before submitting.
# Finally bind the ENTER key to trigger the modal submit button.
#
###
@bind_modal_submit_for_select2 =  () ->
  $("#saveModalBtn").unbind()
  $('.modal').first().off('keypress')

  $("#saveModalBtn").click ->
    unless typeof $("#select2_box").select2('data')[0] == 'undefined'
      submit_the_select_form()
    else
      toggleSubmitButton(false)

  $("#select2_modal").on 'keypress', (e) ->
    if e.which == 13
      e.preventDefault()
      submit_the_select_form()
    else
      $('#select2_box').select2 'open'

###*
# Submit the form.
#
###
@formSubmit = () ->
  #$('form').submit()
  $('#form_main').submit()

###*
# Submit the form. First select the select2 component and get
# the selected data and push them into an array. Then submit the
# form via ajax.
#
###
@submit_the_select_form = () ->
  selectData = $("#select2_box").select2 'data'
  ids = []

  ids.push selectData[i].id for i in [0...selectData.length]

  $.ajax
    url: $("#select2_box").parents('form')[0].action
    headers:
      Accept: 'text/javascript; charset=utf-8'
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    type: 'POST'
    dataType: 'script'
    data:
      'people': ids
      'authenticity_token': $("#select2_box").siblings('#authenticity_token').val()


###*
# Shows notifications using the PNotify js plugin
#
# @param {string} type : can be "notice", "info", "success", or "error"
# @param {string} title : title
# @param {string} text : content
#
###
@showNotification = (type, title, text) ->
  new PNotify(
    buttons:
      sticker: false
    animate:
      animate: true
      in_class: "slideInUp"
      out_class: "fadeOut"
    type: type
    title: title
    text: text
    delay: 3000)
  return

@showConfirmationModal = () ->
  $('#confirmation_modal').modal 'show'

@confirmation_delete = (element) ->
  message = element.data('confirm')
  button_text = element.data('confirm-button')

  return true unless message

  button = element.clone()
    .removeAttr('class')
    .removeAttr('data-confirm')
    .addClass('btn').addClass('btn-danger')
    .html(button_text)

  $('#confirmation_modal .modal-body').html(message)
  $('#confirmation_modal #modal_confirmation_buttons').html button
  $("#confirmation_modal").modal 'show'

@changePriority = (form) ->
  $.ajax
    url: form.action
    headers:
      Accept: 'text/javascript; charset=utf-8'
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    type: 'PATCH'
    dataType: 'script'
    data:
      "#{form.dataset.form_type}": "priority": form.priority.value
