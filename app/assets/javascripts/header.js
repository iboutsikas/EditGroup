$(function() {
  $('#navigation').affix({
    offset: {
      top: function() {
        return $('#header-image').height();
      }
    }
  });
});
