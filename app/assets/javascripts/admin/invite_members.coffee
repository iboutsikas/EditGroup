$ ->
  $('#member').on 'shown.bs.modal', ->
    bind_student_member_selection_to_dates()

###
# In the invite member modal, when the user sets isStudent to true show the
# member_from and member_to date pickers. If they set it false, hide it and
# clear the year values
###
@bind_student_member_selection_to_dates = () ->
  $from_year = document.getElementById('member_member_from_1i')
  $to_year = document.getElementById('member_member_to_1i')
  $member_to_from_div = document.getElementById('member_to_from_div')

  document.getElementById('member_isStudent_false').addEventListener 'change', ->
    $from_year.selectedIndex = -1
    $to_year.selectedIndex = -1
    $member_to_from_div.style.display = "none"


  document.getElementById('member_isStudent_true').addEventListener 'change', ->
    $member_to_from_div.style.display = "block"
