$ ->
  # select2 for site preferences page
  $('#citations_select2').select2
    theme: 'bootstrap'

  $('#citations_select2').on "select2:select", () ->
    $('form').submit()


  # Select2 for select boxes in authors and project participants
  $("#select2_modal")
    # operations and keybinding for when the modal in initialized and shown
    .on 'shown.bs.modal', ->
      # remove event handlers from the save modal button in order to avoid submitting the form twice
      if $( '#select2_box' ).length == 0
        bind_modal_submit_default()
      else
        bind_modal_submit_for_select2()

      # inialize select2
      $('#select2_box').select2
        allowClear: true
        theme: 'bootstrap'
        multiple: true

      # clear the default empty value
      $('#select2_box').select2('val','')

      #press the add new button in the create multiple to create the first one
      $('.add_fields').trigger 'click'

      $('#select2_box')
        # on unselect, if no selection remains disable submit button
        .on "select2:unselect", (e) ->
          if typeof $("#person_select2").select2('data')[0] == 'undefined'
            toggleSubmitButton(false)

        # on selection enable the sumbit button
        .on "select2:select", () ->
          toggleSubmitButton(true)


  # always last or search doesn't work in select2
  $.fn.modal.Constructor::enforceFocus = ->
    return
