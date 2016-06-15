$ ->
  # initialize PNotify
  PNotify.prototype.options.styling = "fontawesome";

  # Create variables and get JQuery oblects for things needed in datatables
  $table = $("table")
  default_sort_column = $(".table").data "default_sort_column"
  default_sort_direction = $(".table").data "default_sort_direction"

  # Initialize datatable
  $dataTable = $table.DataTable
    oLanguage:
      sProcessing: "<div class='animated pulse'><i class='fa fa-database fa-2x' aria-hidden='true'></i><p>Loading..</p></div>"
    processing: true
    serverSide: false
    responsive: true
    fixedHeader: false
    pagingType: 'full_numbers'
    aaSorting: [[default_sort_column, default_sort_direction]]
    ajax:
      url: $table.data('source') + "/datatables"
      type: "POST"
      data: (data) ->
        data.length = 999999
        return data
    rowCallback: ( row, data, index ) ->
      for i in [0...data.length]
        elem = row.children[i]
        elem.className = elem.firstChild.dataset.tdclass
    fnInitComplete: (settings, json) ->
      $table.addClass("tableVisible animated fadeIn")

  # when ordering or searching (including during initialization), add row index
  $dataTable.on('order.dt search.dt', ->
    nodes = $dataTable.column(0,
      search: 'applied'
      order: 'applied').nodes()

    for i in [0...nodes.length]
      nodes[i].innerHTML = "<div data-tdclass=''> #{i + 1} </div>"
  ).draw()

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
