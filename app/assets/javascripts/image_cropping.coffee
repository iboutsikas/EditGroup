$ ->

@loadFile = (event) ->
  file =  event.path[0].files[0]
  reader = new FileReader()
  reader.onloadend = () ->
    img = $('#cropbox')[0]
    img.src = reader.result
    #img.height = 500;
    #img.width = 500;

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
    ratioW = $('#cropbox')[0].naturalWidth / $('#cropbox').width()
    ratioH = $('#cropbox')[0].naturalHeight / $('#cropbox').height()
    currentRatio = Math.min(ratioW, ratioH)
    $('#member_crop_x').val(coords.x * currentRatio)
    $('#member_crop_y').val(coords.y * currentRatio)
    $('#member_crop_w').val(coords.w * currentRatio)
    $('#member_crop_h').val(coords.h * currentRatio)
