$ ->
  $('#accept_invitation').on "input", ->
    validateFormElement(document.activeElement)


@validate_accept_invitations_form = () ->
  if validateForm('#accept_invitation')
    $('#accept_invitation_form').submit()
  else
    scroll(0,0)
