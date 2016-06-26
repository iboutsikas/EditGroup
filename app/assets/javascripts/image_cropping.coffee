@loadFile = (event) ->
  file =  event.path[0].files[0]
  reader = new FileReader()
  img = $('#cropbox')[0]

  reader.onloadend = () ->
    img.src = reader.result
    hiddenimg = new Image()
    hiddenimg.onload = () ->
      console.log this.width
      console.log this.height
    hiddenimg.src = reader.result

    canvas = document.createElement('canvas')
    MAX_WIDTH = 600
    MAX_HEIGHT = 600
    width = img.width
    height = img.height
    if width > height
      if width > MAX_WIDTH
        height *= MAX_WIDTH / width
        width = MAX_WIDTH
    else
      if height > MAX_HEIGHT
        width *= MAX_HEIGHT / height
        height = MAX_HEIGHT
    canvas.width = width
    canvas.height = height
    ctx = canvas.getContext('2d')
    ctx.drawImage img, 0, 0, width, height
    dataurl = canvas.toDataURL('image/png')
    img.src = dataurl

    new AvatarCropper()
    img.id = "cropbox"
    $('.jcrop-holder .img').style = ""
    $('.jcrop-tracker').style = "width: 600px; height: 600px;"

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
