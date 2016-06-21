$ ->

@loadFile = (event) ->
  file =  event.path[0].files[0]
  reader = new FileReader()
  reader.onloadend = () ->
    img = $('#cropbox')[0]
    img.src = reader.result

    new AvatarCropper()
    img.id = "cropbox"
    $('#cropbox').style = "width: 500px; height: 500px;"
    $('.jcrop-holder .img').style = ""

  reader.readAsDataURL(file)
  $('#crop_div').show()


class AvatarCropper
  constructor: ->
    $('#cropbox').Jcrop
      aspectRatio: 1
      setSelect: [0,0,400,400]
      onSelect: @update
      onChange: @update

  update: (coords) =>
    $('#member_crop_x').val(coords.x)
    $('#member_crop_y').val(coords.y)
    $('#member_crop_w').val(coords.w)
    $('#member_crop_h').val(coords.h)
