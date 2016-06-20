$(function() {
  var timelineBlocks = $('.publication-timeline-block'),
      offset = 0.8;

	hideBlocks(timelineBlocks, offset);

	$(window).on('scroll', function(){
		(!window.requestAnimationFrame)
			? setTimeout(function(){ showBlocks(timelineBlocks, offset); }, 100)
			: window.requestAnimationFrame(function(){ showBlocks(timelineBlocks, offset); });
	});

	function hideBlocks(blocks, offset) {
		blocks.each(function(){
      var block = $(this);
			(block.offset().top > $(window).scrollTop()+$(window).height()*offset ) && block.find('.publication-timeline-img, .publication-timeline-content').addClass('is-hidden');
		});
	}

	function showBlocks(blocks, offset) {
		blocks.each(function(){
      var block = $(this);
			(block.offset().top <= $(window).scrollTop()+$(window).height()*offset && block.find('.publication-timeline-img').hasClass('is-hidden')) && block.find('.publication-timeline-img, .publication-timeline-content').removeClass('is-hidden').addClass('bounce-in');
		});
	}

  var $searchToggle = $("#searchToggle");
  var $searchCollapse = $("#searchCollapse");
  var showing = false;

  $searchToggle.on('click', function() {
    if(showing) {
      $searchToggle.html("<i class='fa fa-search' aria-hidden='true'></i>");
      $searchCollapse.removeClass("bounceInLeft");
      $searchCollapse.addClass("bounceOutRight");
      $searchCollapse.one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
        $searchCollapse.removeClass("showing");
        $searchCollapse.off('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend');
      });
      showing = false;
    } else {
      $searchToggle.html("<i class='fa fa-times' aria-hidden='true'></i>");
      $searchCollapse.removeClass("bounceOutRight");
      $searchCollapse.addClass("showing");
      $searchCollapse.addClass("bounceInLeft");
      showing = true;
    }
  });


});
