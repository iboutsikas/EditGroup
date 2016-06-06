$ ->
  PNotify.prototype.options.styling = "fontawesome";
  default_sort_column = $(".table").data "default_sort_column"
  default_sort_direction = $(".table").data "default_sort_direction"

  # Initialize datatable
  $("table").DataTable
    oLanguage:
      sProcessing: "<div class='animated pulse'><i class='fa fa-database fa-2x' aria-hidden='true'></i><p>Loading..</p></div>"
    processing: true
    serverSide: false
    responsive: true
    fixedHeader: false
    aaSorting: [[default_sort_column, default_sort_direction]]
    ajax:
      url: $("table").data('source') + "/datatables"
      type: "POST"
      data: (data) ->
        data.length = 999999
        return data
    pagingType: 'full_numbers'
    drawCallback: (settings) ->
      $("table td .avatar").parent().addClass("avatarColumn")
      $("table td .editButton").parent().addClass("buttonColumn")
      $("table td .deleteButton").parent().addClass("buttonColumn")
      $("table td .editLoginButton").parent().addClass("buttonColumn")
      $("table td .participantsButton").parent().addClass("buttonColumn")
      $("table td .authorsButton").parent().addClass("buttonColumn")
      $("table td .websitesButton").parent().addClass("buttonColumn")
      $("table td .resendButton").parent().addClass("buttonColumn")
      $("table td .cancelInvitationButton").parent().addClass("buttonColumn")
      $("table td .website_logo").parent().addClass("buttonColumn")
      $("table td .isMember").parent().addClass("isMemberColumn")
    fnInitComplete: (settings, json) ->
      $("table").addClass("tableVisible animated fadeIn")

  # When submit button of modal is clicked, validate the form
  # and submit. Otherwise disable the submit button.
  bind_modal_submit_default()

  # On any input on the form, validate the active field.
  $('.modal').first().on "input", ->
    validateFormElement(document.activeElement)

  $("form#edit_member input").on "input", ->
    validateFormElement(document.activeElement)

  $.rails.allowAction = (element) ->
    # if there is no confirmation required, execute action normally
    if !element.attr('data-confirm')
      return true

    # Show confirmation and delete the resource normally
    confirmation_delete element
    return false
