function hideBorderBottomLastChild(){
  var last_child = $('.children-comment')[$('.children-comment').size()-1];
  $(last_child).find('.comment-main').css({'border-bottom':'none'});
  var last_replied = $(last_child).find('.replied-container > .plr0')[$(last_child).find('.replied-container > .plr0').size()-1];
  $(last_replied).css({'border-bottom':'none'});

  $('.replied-container > .plr0').each(function(){
    var child_replied = $(this).find('.reply-main > .form-group > div > .plr0');
    $(child_replied[child_replied.size()-1]).css({'border-bottom':'none'});

  });
}

function resetBorder() {
  $('.comment-main').css({'border-bottom':'1px solid #ccc'});
  $('.plr0').css({'border-bottom':'1px solid #ccc'});
}
