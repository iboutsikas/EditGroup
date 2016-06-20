$(function() {

  $('.news-item-toggle').on('click', function () {

    var $button = $(this);
    var $content = $('#' + $button.attr("data-target"));

    if($content.hasClass("ellipsis")) {
      $content.removeClass("ellipsis");
      $content.addClass("open");
      $button.html("Show less");
    } else {
      $content.addClass("ellipsis");
      $content.removeClass("open");
      $button.html("Show more");
    }

  });
});
