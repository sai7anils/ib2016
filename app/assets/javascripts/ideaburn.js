function validate_term_condition(){
  if($('.c-checkbox label > .check').css('opacity') == 0){
    alert('Please Read And Accept Our Terms And Conditions');
  }
}

$(document).ready(function () {
  App.init();
  var slider = $('.c-layout-revo-slider .tp-banner');
  var cont = $('.c-layout-revo-slider .tp-banner-container');
  var api = slider.show().revolution(
    {
      delay: 15000,
      startwidth: 1170,
      startheight: 620,
      navigationType: "hide",
      navigationArrows: "solo",
      touchenabled: "on",
      onHoverStop: "on",
      keyboardNavigation: "off",
      navigationStyle: "circle",
      navigationHAlign: "center",
      navigationVAlign: "bottom",
      spinner: "spinner2",
      fullScreen: "on",
      fullScreenAlignForce: "on",
      fullScreenOffsetContainer: '',
      shadow: 0,
      fullWidth: "off",
      forceFullWidth: "off",
      hideTimerBar: "on",
      hideThumbsOnMobile: "on",
      hideNavDelayOnMobile: 1500,
      hideBulletsOnMobile: "on",
      hideArrowsOnMobile: "on",
      hideThumbsUnderResolution: 0
    });
  api.bind("revolution.slide.onchange", function (e, data) {
      $('.c-layout-header').removeClass('hide');
      setTimeout(function () {
        $('.c-singup-form').fadeIn();
      }, 1500);
  });
  $('#sliders').tinycarousel();

  // Animate when click on top menu
  $('.c-theme-nav > .menu-nav').click(function(){
    if (this.id == "entrepreneur"){
      showEntrepreneur();
    }
    else if (this.id == "investor"){
      showInvestor();
    }
    else if (this.id == "startup"){
      showStartup();
    }
    else {
      showStartupEvent();
    }
    animateTop();
  });

  $('.link_action').click(function(){
    if (this.id == "entrepreneur"){
      showEntrepreneur();
    }
    else if (this.id == "investor"){
      showInvestor();
    }
    else if (this.id == "startup"){
      showStartup();
    }
    else {
      showStartupEvent();
    }
    animateTop();
  });

  var lastUrl = window.location.href.match(/\/([^/]*)$/)[1];

  switch (lastUrl) {
    case '#entrepreneur':
      showEntrepreneur();
      animateTop();
      break;
    case '#investor':
      showInvestor();
      animateTop();
      break;
    case '#startup':
      showStartup();
      animateTop();
      break;
    case '#startupevent':
      showStartupEvent();
      animateTop();
      break;
  }

  $('.btn-close').click(function(){
    $('body').css('overflow', 'visible');
    $("html, body").animate({ scrollTop: 0 }, "slow");
    $('.entrepreneur-section').animate({'opacity':'0','top':'-150%'}, 2000);
    $('.c-layout-page').animate({'opacity':'1'}, 2000);
    $('.c-layout-header').animate({'opacity':'1'}, 2000);
  });

  $('body').keydown(function(e){
    if(e.keyCode == 27) {
      $('.entrepreneur-section').animate({'opacity':'0','top':'-150%'}, 2000);
      $('.c-layout-page').animate({'opacity':'1'}, 2000);
      $('.c-layout-header').animate({'opacity':'1'}, 2000);
      $('body').css({'overflow':'scroll', 'overflow-x': 'hidden'});
      window.history.pushState(null, null, '/');
    }
  });

});
//loadmore entrepreneur
function load_more_entrepreneur(pageno){
  $.ajax({
    url: "/home/loadmoreentrepreneur",
    data: {pageno: pageno},
    success: function(result){
      $(".entrepreneur-content#entrepreneur").append(result);
      $('.load-homepage').hide();
    }
  })
}

$(document).ready(function() {
  var currPage = 1;
  $('.entrepreneur-section#entrepreneur').scroll(function() {
    if($('.entrepreneur-section#entrepreneur')[0].scrollTop + $('.entrepreneur-section#entrepreneur').height() > $('.entrepreneur-section#entrepreneur')[0].scrollHeight - 80){
       $('.load-homepage').show();
       load_more_entrepreneur(++currPage);
    }
  });
});


//loadmore investor
function load_more_investor(pageno){
  $.ajax({
    url: "/home/loadmoreinvestor",
    data: {pageno: pageno},
    success: function(result){
      $(".entrepreneur-content#investor").append(result);
      $('.load-homepage').hide();
    }
  })
}

$(document).ready(function() {
  var currPage = 1;
  $('.entrepreneur-section#investor').scroll(function() {
     if($('.entrepreneur-section#investor')[0].scrollTop + $('.entrepreneur-section#investor').height() > $('.entrepreneur-section#investor')[0].scrollHeight - 80){
       $('.load-homepage').show();
      load_more_investor(++currPage);
    }
  });
});

//loadmore startup
function load_more_startup(pageno){
  $.ajax({
    url: "/home/loadmorestartup",
    data: {pageno: pageno},
    success: function(result){
      $(".entrepreneur-content#startup").append(result);
         $('.load-homepage').hide();
    }
  })
}

$(document).ready(function() {
  var currPage = 1;
  $('.entrepreneur-section#startup').scroll(function() {
     if($('.entrepreneur-section#startup')[0].scrollTop + $('.entrepreneur-section#startup').height() > $('.entrepreneur-section#startup')[0].scrollHeight - 80){
       $('.load-homepage').show();
      load_more_startup(++currPage);
    }
  });
});

function showEntrepreneur() {
  $('.entrepreneur-section#entrepreneur').animate({'opacity':'1','top':'0px'}, 2000);
  $('body').css('overflow', 'hidden');
  // window.scrollTo(0,document.body.scrollHeight);
}

function showInvestor() {
  $('.entrepreneur-section#investor').animate({'opacity':'1','top':'0px'}, 2000);
  $('body').css('overflow', 'hidden');
  // window.scrollTo(0,document.body.scrollHeight);
}

function showStartup() {
  $('.entrepreneur-section#startup').animate({'opacity':'1','top':'0px'}, 2000);
  $('body').css('overflow', 'hidden');
  // window.scrollTo(0,document.body.scrollHeight);
}

function showStartupEvent() {
  $('.entrepreneur-section#startupevent').animate({'opacity':'1','top':'0px'}, 2000);
  $('body').css('overflow', 'hidden');
  // window.scrollTo(0,document.body.scrollHeight);
}

function animateTop() {
  $('.c-layout-page').animate({'opacity':'0'}, 2000);
  $('.c-layout-header').animate({'opacity':'0'}, 2000);
}
