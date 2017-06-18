function postCommentIdea(idea_id){
  var message = $('#message').val();
  if(message == '')
    return false;
  $.ajax({
    url: '/user/ideas/comment',
    type: 'POST',
    data: {idea_id: idea_id, message: message},
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    success: function(html) {
      //$(".comment-details #comments").prepend(html); don't use if using faye
      $('#message').val('');
    },
    error: function(e) {
    }
  });
}
function replyCommentIdea(comment_id){
  event.preventDefault();
  var message = $('#message_' + comment_id).val();
  if(message == '')
    return false;
  $.ajax({
    url: '/user/ideas/reply',
    type: 'POST',
    data: {comment_id: comment_id, message: message},
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    success: function(html) {
      //$('#reply_' + comment_id).append(html);
      $('#message_' + comment_id).val('');
      $('#form_reply_'+comment_id).toggleClass('d_none');
      countEnter = 0;
    },
    error: function(e) {
    }
  });
}
function likeIdea(count, idea_id, status){
  $.ajax({
    url: '/user/ideas/like',
    type: 'POST',
    data: {idea_id: idea_id, status: status},
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    success: function(html) {
      //$('.like-idea').html(html); don't use if using faye
      if (status == 1) {
        count += 1;
        $('.like-idea').find('i.fa-thumbs-up').css("color", "#FFD000");
        $('.like-idea').find('span.c-font-12').html(count);
        $('.like-idea').find('i.fa-thumbs-up').attr("onClick","likeIdea(" + count + "," + idea_id + "," + 0 +")");

      }else if(status == 0){
        count = count - 1;
        $('.like-idea').find('i.fa-thumbs-up').css("color", "#00000");
        $('.like-idea').find('span.c-font-12').html(count);
        $('.like-idea').find('i.fa-thumbs-up').attr("onClick","likeIdea(" + count + "," + idea_id + "," + 1 +")");
      }
    },
    error: function(e) {
    }
  });
}

function _editComment(comment_id) {
  $('#comment-id-'+comment_id).toggle();
  $('#comment-container-'+comment_id).toggle();
}

function _updateComment(comment_id, message) {
  $.ajax({
    url: '/user/ideas/update_comment',
    type: 'POST',
    data: {comment_id: comment_id, message: message},
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    success: function(html) {
      $('#comment-container' + comment_id).text(html);
    },
    error: function(e) {
    }
  });
}

function likeIdeaComment(comment_id, status){
  $.ajax({
    url: '/user/ideas/like_comment',
    type: 'POST',
    data: {comment_id: comment_id, status: status},
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    success: function(html) {
      if(status == 1){
        elem = '<span id="comment-like-id-'+comment_id+'" onclick="likeIdeaComment('+comment_id+', 0)" style="color:#78C2E9;cursor:pointer;">Unlike</span>'
      }else {
        elem = '<span id="comment-like-id-'+comment_id+'" onclick="likeIdeaComment('+comment_id+', 1)" style="color:#78C2E9;cursor:pointer;">Like</span>'
      }
      $('#comment-like-id-'+comment_id).parent('.like-comment-action').html(elem);
    },
    error: function(e) {
    }
  });
}

function repliedReplyIdea(reply_id) {
  event.preventDefault();
  var message = $('#message_' + reply_id).val();
  if(message == '')
    return false;
  $.ajax({
    url: '/user/ideas/replied_reply',
    type: 'POST',
    data: {reply_id: reply_id, message: message},
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    success: function(html) {
      $('#message_' + reply_id).val('');
      $('#form_replied_reply_'+reply_id).toggle();
      countEnterReplied = 0;
    },
    error: function(e) {
    }
  });
}
