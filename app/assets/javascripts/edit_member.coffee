$ ->
  forms = $('form')
  for i in [0...forms.length]
    formObject = $(forms[i])
    formObject.on "input", ->
      validateFormElement(document.activeElement)

  $('#form-tabs a').click = (e) ->
    e.preventDefault()
    $(this).tab('show')


@update_member = (form) ->
  formObject = $("##{form}")
  if validateForm(formObject)
    formObject.submit()
