$ ->

  @show_member_bio = (element, type, row, index, max_per_row) ->
    member_row_string = "##{type}-row-#{row}"
    members_to_hide_array = []
    $member_row = $("#{member_row_string}")
    $member_cards = $("#{member_row_string} .member-card")
    $member_bio = $("##{element} .member-bio")
    $member_card = $($member_cards[index])

    # define the animations
    show_animation = "flipInX"
    hide_animation = "flipOutX"

    # Hide the rest of the member-cards in the row
    for i in [0...max_per_row]
      if i != index
        $card = $($member_cards[i])
        members_to_hide_array.push $card
        $card.addClass("animated #{hide_animation}")
        $card.hide()

    # show the member-bio
    $member_card.addClass("active")
    $member_row.addClass("animated #{show_animation}")
    $member_bio.addClass("animated #{show_animation}")
    $member_bio.show()

    # on mouseleave, restore the original view
    $window = $(window)
    $window.click ->
      $member_card.removeClass("active")
      $member_bio.hide()
      $member_bio.removeClass("animate #{show_animation}")
      $member_row.removeClass("animated #{show_animation}")
      for i in [0...members_to_hide_array.length]
        $card = members_to_hide_array[i]
        $card.removeClass("#{hide_animation}")
        $card.addClass("#{show_animation}")
        $card.show()

      # unbind the mouseleave event
      $member_row.unbind()
      $window.unbind('click')
      return

    $member_row.click (event) ->
      event.stopPropagation()
      return
    #$member_row.mouseleave ->
