/** ******  left menu  *********************** **/
$(function () {

    // make the content column equal to the window height
    windowHeight = $(window).height();
    contentHeight = windowHeight - 200;
    console.log(windowHeight);
    console.log(contentHeight);
    $("#side-menu-everything").css('height', windowHeight);
    $("#right-col-id").css("min-height", windowHeight);
    $("#all_content").css("min-height", contentHeight);


    var $collapsibles, url;

    // Get the current url, and upadate the side menu with the acive class
    url = window.location.pathname;
    $('#sidebar-menu a[href="' + url + '"]').parent('li').addClass('current-page').parent('ul').slideDown().parent().addClass('active');

    // add the functionality to the collapsable menus on the side menu
    $collapsibles = $('#sidebar-menu li.collapsable');

    $collapsibles.on('click touchstart', function() {
      var $thiscache, i, j, ref;

      $thiscache = $(this);
      if ($thiscache.hasClass('active')) {
        return $thiscache.removeClass('active').children().eq(1).slideUp();
      } else {
        $collapsibles.removeClass('active');
        for (i = j = 0, ref = $collapsibles.length; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
          $($collapsibles[i].children[1]).slideUp();
        }
        return $thiscache.addClass('active').children().eq(1).slideDown();
      }
    });

    // controlls the behavior of the menu toggle for small screens
    $('#menu_toggle').click(function () {
      if ($('body').hasClass('nav-md')) {
          $('body').removeClass('nav-md').addClass('nav-sm');
          $('.left_col').removeClass('scroll-view').removeAttr('style');
          $('.sidebar-footer').hide();

          if ($('#sidebar-menu li').hasClass('active')) {
              $('#sidebar-menu li.active').addClass('active-sm').removeClass('active');
          }
      } else {
          $('body').removeClass('nav-sm').addClass('nav-md');
          $('.sidebar-footer').show();

          if ($('#sidebar-menu li').hasClass('active-sm')) {
              $('#sidebar-menu li.active-sm').addClass('active').removeClass('active-sm');
          }
      }
    });
});

/** ******  tooltip  *********************** **/
// $(function () {
//     $('[data-toggle="tooltip"]').tooltip()
// })
