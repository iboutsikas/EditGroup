$(function() {
  var navigation = $("#navigation");

  $("#navbar-wrapper").height( navigation.height() );

  navigation.affix({
    offset: {
      top: function() {
        return $('#header-image').height();
      }
    }
  });
});
