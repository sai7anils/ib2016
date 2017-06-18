//= require jquery-2.2.3.js
//= require jquery_ujs
//= require cocoon
//= require jquery-ui
//= require_tree ./user
//= require private_pub

$(document).ready(function() {
  function applyDatepicker() {
    $( "#datepicker, #datepicker2, #datepicker3" ).datepicker({
      yearRange: '2006:2050',
      buttonText: "",
      changeMonth: true,
      changeYear: true,
      dateFormat: 'yy-mm-dd'});
    $( "#dob-datepicker" ).datepicker({
      yearRange: '1930:2050',
      buttonText: "",
      changeMonth: true,
      changeYear: true,
      maxDate: '+0D',
      dateFormat: 'yy-mm-dd'});
    $( "#datepicker4" ).datepicker({
      yearRange: '1930:2016',
      buttonText: "",
      changeMonth: true,
      changeYear: true,
      maxDate: 0,
      dateFormat: 'yy-mm-dd'});
    $( ".form-datepicker" ).datepicker({
      yearRange: '1930:2050',
      buttonText: "",
      changeMonth: true,
      changeYear: true,
      maxDate: '+0D',
      dateFormat: 'yy-mm-dd'
    });
    $('#datepicker, #datepicker2, #datepicker3, #datepicker4, #dob-datepicker, .form-datepicker').keypress(function(e) {
      e.preventDefault();
    });
  }

  applyDatepicker();

  try {
    document.getElementById('get_file').onclick = function() {
      document.getElementById('my_file').click();
    };
  } catch(err){}

  $('#links .btn-add').on('click', function(){
    setTimeout(function(){ applyDatepicker(); }, 1500);
  });

  var click = 0;
  $('.toggle-btn').click(function() {
    click = click + 1;
    if(click % 2 === 1){
      $('footer').animate({'margin-left':'210px','padding-left':'35px'},400);
    }
    if(click % 2 === 0){
      $('footer').animate({'margin-left':'0px','padding-left':'80px'},400);
    }
  });

  //USER PROFILE
  var current = $('.list-info > li:first-child');
  var current_profile = 1;
  var current_startup = 3;
  var numProfile = $('.list-info > li').size();
  $('.list-info > li').click(function(){
    if(!$(this).hasClass('disabled')){
      current.removeClass('active');
      $('.info-content:nth-of-type(' + current_profile + ')').css('display','none');
      $('.profile-content > .invester-content:nth-child(' + current_startup + ')').css('display','none');
      current_profile = $(this).index() + 1;
      current_startup = $(this).index() + 3;
      current = $(this);
      current.addClass('active');
      $('.info-content:nth-of-type(' + current_profile + ')').css('display','block');
      $('.profile-content > .invester-content:nth-child(' + current_startup + ')').css('display','block');
    }
  });

  

  var maxTab = "#tab" + ($('ul.tabsec > li').size() - 1);
  var lastTab = "#tab" + ($('ul.tabsec > li').size());


  $('select.country-2').on('change', function(){
      select_wrapper = $('#order_state_code_wrapper');
      $('select', select_wrapper).attr('disabled', true);
      country_code = $(this).val();
      url = "/api/subregion_options?parent_region=" + country_code;
      select_wrapper.load(url);
      setTimeout(function(){
        changeSelectRegion();
        changeTextRegion();
      }, 600);
    });
  $('select#user_investor_attributes_investor_type').on('change', function(){
    var type = parseInt((this).value);
    if(type === 1 || type == 2){
      $('ul.tabsec > li:nth-child(3)').find('a').text('Contact');
      $('ul.tabsec > li:nth-child(2)').hide();
      $('.tab-content').find('.type2').show();
      $('.tab-content').find('.type3').hide();
    }else{
      $('ul.tabsec > li:nth-child(3)').find('a').text('Office Headquarters');
      $('ul.tabsec > li:nth-child(2)').show();
      $('.tab-content').find('.type2').hide();
      $('.tab-content').find('.type3').show();
    }
  });

  changeSelectRegion();
  changeTextRegion();

  function changeSelectRegion(){
    $('select[name="user[region]"]').change(function () {
      try {
      var select = '<select name="user[city]" id="user_city"></select>';
      $(select).insertAfter( $('input[name="user[city]"]'));
      $('input[name="user[city]"]').remove();
      $('.select-arrow').show();
      }catch(err){}
      var input_state = $('select[name="user[city]"]');
      $.getJSON('/api/cities/' + $('select[name="user[country]"]').val() + '/' + $(this).val(), function (data) {
        if(data.length > 0) {
          input_state.empty();
          $.each(data, function (key, val) {
            var opt = '<option value='+ val +'>' + val + '</option>';
            input_state.append(opt);
          });
          }else {
            var html = '<input id="user_city" required="required" type="text" name="user[city]" placeholder="e.g New York" required>';
            $(html).insertAfter(input_state);
            input_state.remove();
            $('.select-arrow').hide();
          }
      });
    });
  }

  function changeTextRegion(){
    try{
      $('input[name="user[region]"]').text(function(){
        var html = '<input id="user_city" required="required" type="text" name="user[city]" placeholder="e.g New York" required>';
        var input_state = $('select[name="user[city]"]');
        $(html).insertAfter(input_state);
        input_state.remove();
      });
    }catch(err){}
  }

  $('.profile_details_drop').click(function(){
    if(!$(this).hasClass('open')){
      $(this).addClass('open');
      $(this).find('a.dropdown-toggle').attr('aria-expanded', 'true');
    }else{
      $(this).removeClass('open');
      $(this).find('a.dropdown-toggle').attr('aria-expanded', 'false');
    }
  });
});
