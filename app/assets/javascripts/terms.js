$(document).ready(function(){
	var active = $('.howitwork li:nth-child(1)');
	var index = 3;
	$('.content-body:nth-child(3)').css('display','block');
	$('.howitwork li').click(function(event) {
		active.removeClass('active');
		$('.content-body:nth-child(' + index + ')').css('display','none');
		index = $(this).index() + 3;
		active = $(this);
		$(this).addClass('active');
		$('.content-body:nth-child(' + index + ')').css('display','block');
	});
});