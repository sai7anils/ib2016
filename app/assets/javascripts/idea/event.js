$(document).ready(function() {
  $('select.country-2').on('change', function(){
      select_wrapper = $('#order_state_code_wrapper');
      $('select', select_wrapper).attr('disabled', true);
      country_code = $(this).val();
      url = "/api/event_subregion_options?parent_region=" + country_code;
      select_wrapper.load(url);
      setTimeout(function(){
        changeSelectRegion();
        changeTextRegion();
      }, 600);
    });

  changeSelectRegion();
  changeTextRegion();

  function changeSelectRegion(){
    $('select[name="event[region]"]').change(function () {
      try {
      var select = '<select name="event[city]" id="event_city"></select>';
      $(select).insertAfter( $('input[name="event[city]"]'));
      $('input[name="event[city]"]').remove();
      $('.select-arrow').show();
      }catch(err){}
      var input_state = $('select[name="event[city]"]');
      $.getJSON('/api/cities/' + $('select[name="event[country]"]').val() + '/' + $(this).val(), function (data) {
        if(data.length > 0) {
          input_state.empty();
          $.each(data, function (key, val) {
            var opt = '<option value='+ val +'>' + val + '</option>';
            input_state.append(opt);
          });
          }else {
            var html = '<input id="event_city" required="required" type="text" name="event[city]" placeholder="e.g New York" required>';
            $(html).insertAfter(input_state);
            input_state.remove();
            $('.select-arrow').hide();
          }
      });
    });
  }

  function changeTextRegion(){
    try{
      $('input[name="event[region]"]').text(function(){
        var html = '<input id="event_city" required="required" type="text" name="event[city]" placeholder="e.g New York" required>';
        var input_state = $('select[name="event[city]"]');
        $(html).insertAfter(input_state);
        input_state.remove();
      });
    }catch(err){}
  }
  function applyDatepicker() {
    $('#datepicker').on('change', function() {
      $('#datepicker2').val('');
      try {
        $('#datepicker2').datepicker("destroy");
      } catch(err) {}
      $('#datepicker2').datepicker({
        yearRange: '2006:2050',
        buttonText: "",
        changeMonth: true,
        changeYear: true,
        minDate: new Date($("#datepicker").val()),
        dateFormat: 'yy-mm-dd'
      });
      $('#datepicker2').keypress(function(e) {
        e.preventDefault();
      });
    });
    $( "#datepicker, #datepicker3" ).datepicker({
      yearRange: '2006:2050',
      buttonText: "",
      changeMonth: true,
      changeYear: true,
      minDate: 0,
      dateFormat: 'yy-mm-dd'});
    $('#datepicker, #datepicker3, #dob-datepicker').keypress(function(e) {
      e.preventDefault();
    });

    $("#timepicker").timepicker({ 'scrollDefault': 'now' });
  }

  applyDatepicker();

  var add_partner_val;

  try {
    document.getElementById('btn-event-image').onclick = function() {
      document.getElementById('event-image').click();
    };
  } catch(err){}

  $('.btn-cancel').on('click', function(){
    document.getElementById("create-event-form").reset();
  });

  $("select.select-event-country").select2({
      placeholder: "Select A Country",
      allowClear: true
  });

  $('.event-calendar').keypress(function(e) {
    e.preventDefault();
  });

  var numClickTab = 0;

  $('.list-info.menu-detail li').on('click', function(){
    $('.list-info.menu-detail').find('li').removeClass('active');
    $(this).addClass('active');
    var tab = $('#'+$(this).attr('data-id'));
    $('.detail-info.container-fluid').addClass('hide');
    tab.removeClass('hide');
    if($(this).attr('data-id') == 'location' && numClickTab == 0) {
      fitmap(lat, lng);
      numClickTab++;
    }
  });
});
