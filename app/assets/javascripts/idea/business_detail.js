$(document).ready(function() {
	//Change color percentage circle
  var percentage_circle = $('.txt-percentage  > label').text();
  //Percentage Circle Right
  if(percentage_circle <= 12.5){
    var deg = percentage_circle * 4;
    $('.percentage-circle-current').css({'border-right': deg + 'px solid transparent', 'border-top': '40px solid white'});
  }
  if(percentage_circle > 12.5 && percentage_circle < 25){
    var deg = ((percentage_circle - 12.5) * 12) + 50;
    $('.percentage-circle-current').css({'border-right': deg + 'px solid transparent', 'border-top': '40px solid white'});
  }
  if(percentage_circle == 25){
    $('.percentage-circle-current').css({'border-right': '40px solid white', 'border-top': '40px solid white'});
  }
  if(percentage_circle > 25 && percentage_circle < 50){
    var deg = (percentage_circle - 25) * 4;
    $('.percentage-circle-current').css({'border-right': '40px solid white','border-bottom': deg + 'px solid transparent', 'border-top': '40px solid white'});
  }
  if(percentage_circle == 50){
    $('.percentage-circle-current').css({'border-right': '40px solid white','border-bottom': '40px solid white', 'border-top': '40px solid white'});
  }


  //Percentage Circle Left
  if(percentage_circle > 50 && percentage_circle < 65){
    var deg = (percentage_circle - 50) * 4;
    $('.percentage-circle-current').css({'border-right': '40px solid white','border-bottom': '40px solid white', 'border-top': '40px solid white'});
    $('.percentage-circle-current-left').css({'border-left': deg + 'px solid transparent', 'border-bottom': '40px solid white'});
  }
  if(percentage_circle >= 65 && percentage_circle < 75){
    var deg = (percentage_circle - 50) * 4;
    $('.percentage-circle-current').css({'border-right': '40px solid white','border-bottom': '40px solid white'});
    $('.percentage-circle-current-left').css({'border-left': deg + 'px solid transparent'});
  }
  if(percentage_circle == 75){
    $('.percentage-circle-current').css({'border-right': '40px solid white','border-bottom': '40px solid white'});
    $('.percentage-circle-current-left').css({'border-left': '40px solid white'});
  }
  if(percentage_circle > 75 && percentage_circle < 100){
    var deg = (percentage_circle - 75) * 4;
    $('.percentage-circle-current').css({'border-right': '40px solid white','border-bottom': '40px solid white', 'border-top': '40px solid white'});
    $('.percentage-circle-current-left').css({'border-left': '40px solid white','border-top': deg + 'px solid transparent'});
  }
  if(percentage_circle == 100){
    $('.percentage-circle-current').css({'border-right': '40px solid white','border-bottom': '40px solid white'});
    $('.percentage-circle-current-left').css({'border-left': '40px solid white','border-top': '40px solid white'});
  }

  $('body').click(function(event) {
    $('.form-info').removeClass('active');
    $('.btn-view-list').removeClass('active');
    $('.form-info-competetors').removeClass('active');
    $('.btn-competetors').removeClass('active');
    $('.show-all-section .form-info').removeClass('active');
    $('.btn-show-all').removeClass('active');
  });

  $('.show-all-section .form-info').click(function(event){
    event.stopPropagation();
  });

  $('.btn-view-list').click(function(event) {
    $('.form-info').toggleClass('active');
    $('.btn-view-list').toggleClass('active');
    event.stopPropagation();
  });

  $('.btn-competetors').click(function(event) {
    $('.form-info-competetors').toggleClass('active');
    $('.btn-competetors').toggleClass('active');
    event.stopPropagation();
  });

  $('.btn-send-request').click(function(event){
    event.preventDefault();
    if($('#message_detail').val() == ''){
      $('#message_detail').css({'border-color':'#F78181'});
    }else{
      var url = $('form#new_message').attr('data-url');
      var data = $('form#new_message').serializeArray();
      sendRequest(url, data);
    }
  });
});
