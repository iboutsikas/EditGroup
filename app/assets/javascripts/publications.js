$(function() {
  let timelineBlocks = $('.cd-timeline-block'),
      offset = 0.8;

	hideBlocks(timelineBlocks, offset);

	$(window).on('scroll', function(){
		(!window.requestAnimationFrame)
			? setTimeout(function(){ showBlocks(timelineBlocks, offset); }, 100)
			: window.requestAnimationFrame(function(){ showBlocks(timelineBlocks, offset); });
	});

	function hideBlocks(blocks, offset) {
		blocks.each(function(){
      let block = $(this);
			(block.offset().top > $(window).scrollTop()+$(window).height()*offset ) && block.find('.cd-timeline-img, .cd-timeline-content').addClass('is-hidden');
		});
	}

	function showBlocks(blocks, offset) {
		blocks.each(function(){
      let block = $(this);
			(block.offset().top <= $(window).scrollTop()+$(window).height()*offset && block.find('.cd-timeline-img').hasClass('is-hidden')) && block.find('.cd-timeline-img, .cd-timeline-content').removeClass('is-hidden').addClass('bounce-in');
		});
	}

});
