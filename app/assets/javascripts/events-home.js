$(".event-calendar").datepicker({
  yearRange: '2006:2050',
  buttonText: "",
  changeMonth: true,
  changeYear: true,
  dateFormat: 'yy-mm-dd'});

var page = 2;
$(".select-event-country").on('change', function(){
  page = 1;
  loadEvents();
});

$('.keyword').keydown(function(e){
  if (e.keyCode == 13  && !e.shiftKey){
    e.preventDefault();
    page = 1;
    loadEvents();
    return false;
  }else if (e.keyCode == 27) {
    $(this).val('');
  }
});

$(".event-calendar").datepicker()
  .on("input change", function (e) {
    page = 1;
    loadEvents();
});

$(".clear-filter").on("click", function(){
  $('.keyword').val('');
  $('.event-calendar').val('');
  $(".select-event-country").val('');
  loadEvents();
});

$('.entrepreneur-section.startupevent-section#startupevent').scroll(function() {
  if($('.entrepreneur-section.startupevent-section#startupevent').scrollTop() + $('.entrepreneur-section.startupevent-section#startupevent').height() > $('.entrepreneur-section.startupevent-section#startupevent')[0].scrollHeight - 100){
    loadEvents('load_more');
  }
});

function loadEvents(type){
  type = type || 'init';
  $.ajax({
    url: '/home/loadmoreevents/',
    data: {keyword: $('.keyword').val(), date: $('.event-calendar').val(), country: $(".select-event-country").val(), page: page},
    success: function(data){
      if (type == 'init'){
        $('.list-events').html('');
        if(data == ''){
          $('.list-events').html('<div class="col-md-12 text-left">No Results</div>');
        }
      }
      $('.list-events').append(data);
    }
  });
  page++;
}
