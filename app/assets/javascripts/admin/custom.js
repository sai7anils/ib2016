'use strict';

function clearForm() {
  document.getElementById("update-pwd-form").reset();
}

function deleteUser(user, event) {
  event.preventDefault();
  var url = $('.delete_user#'+user).attr('data-url');
  $('#modalComfirm').modal('toggle');
  $('.btn-yes').on('click', function(){
    $.ajax({
      url: url,
      type: 'DELETE',
      data: {},
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      success: function(res) {
        if(res == true){
          $('.delete_user#'+user).parent().parent().remove();
          $('.message-success').removeClass('hide');
        }
        $('#modalComfirm').modal('hide');
      },
      error: function(e) {
      }
    });
  });
}

function deleteIdea(idea, event) {
  event.preventDefault();
  $('#modalComfirm').modal('toggle');
  $('.btn-yes').on('click', function(){
    $.ajax({
      url: "/admin/ideas/" + idea,
      type: 'DELETE',
      data: {},
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      success: function(res) {
        if(res == true){
          $('#'+idea).parent().parent().remove();
          $('.message-success').removeClass('hide');
          $('#modalComfirm').modal('hide');
        }else{
          $('#modalComfirm').modal('hide');
        }
      },
      error: function(e) {
      }
    });
  });
}


function deleteBusinessIdea(idea, event) {
  event.preventDefault();
  $('#modalComfirm').modal('toggle');
  $('.btn-yes').on('click', function(){
    $.ajax({
      url: "/admin/business_ideas/" + idea,
      type: 'DELETE',
      data: {},
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      success: function(res) {
        if(res == true){
          $('#'+idea).parent().parent().remove();
          $('.message-success').removeClass('hide');
          $('#modalComfirm').modal('hide');
        }else{
          $('#modalComfirm').modal('hide');
        }
      },
      error: function(e) {
      }
    });
  });
}

function deleteEvent(event_id, event) {
  event.preventDefault();
  $('#modalComfirm').modal('toggle');
  $('.btn-yes').on('click', function(){
    $.ajax({
      url: "/admin/events/" + event_id,
      type: 'DELETE',
      data: {},
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      success: function(res) {
        if(res == true){
          $('#'+event_id).parent().parent().remove();
          $('.message-success').removeClass('hide');
          $('#modalComfirm').modal('hide');
        }else{
          $('#modalComfirm').modal('hide');
        }
      },
      error: function(e) {
      }
    });
  });
}

function deleteTransaction(transaction_id, event) {
  event.preventDefault();
  $('#modalComfirm').modal('toggle');
  $('.btn-yes').on('click', function(){
    $.ajax({
      url: "/admin/transactions/" + transaction_id,
      type: 'DELETE',
      data: {},
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      success: function(res) {
        if(res == true){
          $('#'+transaction_id).parent().parent().remove();
          $('.message-success').removeClass('hide');
          $('#modalComfirm').modal('hide');
        }else{
          $('#modalComfirm').modal('hide');
        }
      },
      error: function(e) {
      }
    });
  });
}

function deleteOrder(order_id, event) {
  event.preventDefault();
  $('#modalComfirm').modal('toggle');
  $('.btn-yes').on('click', function(){
    $.ajax({
      url: "/admin/orders/" + order_id,
      type: 'DELETE',
      data: {},
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      success: function(res) {
        if(res == true){
          $('#'+order_id).parent().parent().remove();
          $('.message-success').removeClass('hide');
          $('#modalComfirm').modal('hide');
        }else{
          $('#modalComfirm').modal('hide');
        }
      },
      error: function(e) {
      }
    });
  });
}


function searchUser(e) {
  var search = $('#search-user').val();
  if (e.keyCode == 13  && !e.shiftKey){
    e.preventDefault();
    window.location = "?search="+search;
    return false;
  }
}

function searchIdea(e) {
  var search = $('#search-idea').val();
  if (e.keyCode == 13  && !e.shiftKey){
    e.preventDefault();
    window.location = "?search="+search;
    return false;
  }
}

function searchEvent(e){
  var search = $('#search-event').val();
  if (e.keyCode == 13  && !e.shiftKey){
    e.preventDefault();
    window.location = '?country=' + $('.select-event-country').val() + '&keyword=' + search + '&date=' + $('.event-calendar').val() ;
    return false;
  }
}

function formatDate(date) {
  var d = new Date(date),
      month = '' + (d.getMonth() + 1),
      day = '' + d.getDate(),
      year = d.getFullYear();

  if (month.length < 2) month = '0' + month;
  if (day.length < 2) day = '0' + day;

  return [year, month, day].join('-');
}

function formatDate2(date) {
  var d = new Date(date),
      month = '' + (d.getMonth() + 1),
      day = '' + d.getDate(),
      year = d.getFullYear();

  if (month.length < 2) month = '0' + month;
  if (day.length < 2) day = '0' + day;

  return [month, day, year].join('/');
}

function getParameterByName(name, url) {
  if (!url) url = window.location.href;
  name = name.replace(/[\[\]]/g, "\\$&");
  var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
      results = regex.exec(url);
  if (!results) return null;
  if (!results[2]) return '';
  return decodeURIComponent(results[2].replace(/\+/g, " "));
}

// PREVIEW UPLOAD IMAGE
function readURL(input, target) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      target.attr('src', e.target.result);
      target.show();
    }
    if (['jpg', 'jpeg', 'gif', 'png'].indexOf(input.files[0].name.split('.').pop()) !== -1) {
      reader.readAsDataURL(input.files[0]);
    }
  }
}

$(document).on('change', '.js_image', function () {
  readURL(this, $('.js_image_preview'));
});

$(".datepicker" ).datepicker({
  autoclose: true,
  todayHighlight: true,
  format: 'dd/mm/yyyy'
});
