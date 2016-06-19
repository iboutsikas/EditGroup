$(function() {

  $('.news-item-toggle').on('click', function () {
    var $button = $(this);
    var $content = $('#' + $button.data("target"));

    if($content.hasClass("ellipsis")) {
      $content.removeClass("ellipsis");
      $button.html("Show less");
    } else {
      $content.addClass("ellipsis");
      $button.html("Show more");
    }

  });
});
