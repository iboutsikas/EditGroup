$ ->
  new AvatarCropper()


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
