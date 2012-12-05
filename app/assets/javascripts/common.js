$(document).ready(function() {
    ajaxifyPagination();
});

function ajaxifyPagination() {
  $(".pagination-schedules a").click(function() {
    if($(this).attr("href").indexOf("page=") > 0) {
      lesson_id = $(this).attr("href").substring($(this).attr("href").indexOf("lesson_id=") + "lesson_id=".length, $(this).attr("href").indexOf("&"));
      page = $(this).attr("href").substring($(this).attr("href").indexOf("page=") + "page=".length, $(this).attr("href").length);
      $.ajax({
        url: "/lessons/get_schedule_list/" + lesson_id + "?page=" + page
      , type: "GET"
      , dataType: "html"
      , timeout: 10000
      , beforeSend: function(){}
      , error: function(XMLHttpRequest, status, errorThrown){}
      , success: function(data, status, xhr){success_pagination_schedules(data, status, xhr);}
      });
    }
    return false;
  });

  $(".pagination-comments a").click(function() {
    if($(this).attr("href").indexOf("page=") > 0) {
      lesson_id = $(this).attr("href").substring($(this).attr("href").indexOf("lesson_id=") + "lesson_id=".length, $(this).attr("href").length);
      page = $(this).attr("href").substring($(this).attr("href").indexOf("comment_page=") + "comment_page=".length, $(this).attr("href").indexOf("&"));
      $.ajax({
        url: "/comments/get_comment_list/" + lesson_id + "?comment_page=" + page
      , type: "GET"
      , dataType: "html"
      , timeout: 10000
      , beforeSend: function(){}
      , error: function(XMLHttpRequest, status, errorThrown){}
      , success: function(data, status, xhr){success_pagination_comments(data, status, xhr);}
      });
    }
    return false;
  });

  $(".pagination-schedule-comments a").click(function() {
    if($(this).attr("href").indexOf("page=") > 0) {
      schedule_id = $(this).attr("href").substring($(this).attr("href").indexOf("schedule_id=") + "schedule_id=".length, $(this).attr("href").length);
      page = $(this).attr("href").substring($(this).attr("href").indexOf("schedule_comment_page=") + "schedule_comment_page=".length, $(this).attr("href").indexOf("&"));
      $.ajax({
        url: "/schedule_comments/get_schedule_comment_list/" + schedule_id + "?schedule_comment_page=" + page
      , type: "GET"
      , dataType: "html"
      , timeout: 10000
      , beforeSend: function(){}
      , error: function(XMLHttpRequest, status, errorThrown){}
      , success: function(data, status, xhr){success_pagination_schedule_comments(data, status, xhr);}
      });
    }
    return false;
  });

  $(".pagination-schedules-top a").click(function() {
    if($(this).attr("href").indexOf("page=") > 0) {
      page = $(this).attr("href").substring($(this).attr("href").indexOf("schedule_top_page=") + "schedule_top_page=".length, $(this).attr("href").length);
      $.ajax({
        url: "/top/get_schedule_list" + "?schedule_top_page=" + page
      , type: "GET"
      , dataType: "html"
      , timeout: 10000
      , beforeSend: function(){}
      , error: function(XMLHttpRequest, status, errorThrown){}
      , success: function(data, status, xhr){success_pagination_schedules_top(data, status, xhr);}
      });
    }
    return false;
  });

  $(".pagination-schedules-top-apply a").click(function() {
    if($(this).attr("href").indexOf("page=") > 0) {
      page = $(this).attr("href").substring($(this).attr("href").indexOf("schedule_top_apply_page=") + "schedule_top_apply_page=".length, $(this).attr("href").length);
      $.ajax({
        url: "/top/get_schedule_apply_list" + "?schedule_top_apply_page=" + page
      , type: "GET"
      , dataType: "html"
      , timeout: 10000
      , beforeSend: function(){}
      , error: function(XMLHttpRequest, status, errorThrown){}
      , success: function(data, status, xhr){success_pagination_schedules_top_apply(data, status, xhr);}
      });
    }
    return false;
  });

  $(".pagination-schedules-top-history a").click(function() {
    if($(this).attr("href").indexOf("page=") > 0) {
      page = $(this).attr("href").substring($(this).attr("href").indexOf("schedule_top_history_page=") + "schedule_top_history_page=".length, $(this).attr("href").length);
      $.ajax({
        url: "/top/get_schedule_history_list" + "?schedule_top_history_page=" + page
      , type: "GET"
      , dataType: "html"
      , timeout: 10000
      , beforeSend: function(){}
      , error: function(XMLHttpRequest, status, errorThrown){}
      , success: function(data, status, xhr){success_pagination_schedules_top_history(data, status, xhr);}
      });
    }
    return false;
  });
}

function success_pagination_schedules(data, status, xhr) {
  document.getElementById("apply-schedule-inner").innerHTML = data;
  ajaxifyPagination();
  location.hash = "";
  location.hash = "schedule-top";
}

function success_pagination_comments(data, status, xhr) {
  document.getElementById("comments").innerHTML = data;
  ajaxifyPagination();
  location.hash = "";
  location.hash = "comment-top";
}

function success_pagination_schedule_comments(data, status, xhr) {
  document.getElementById("schedule-comments").innerHTML = data;
  ajaxifyPagination();
  location.hash = "";
  location.hash = "schedule-comment-top-header";
}

function success_pagination_schedules_top(data, status, xhr) {
  document.getElementById("top-schedules").innerHTML = data;
  ajaxifyPagination();
  location.hash = "";
  location.hash = "schedule-top-top";
}

function success_pagination_schedules_top_apply(data, status, xhr) {
  document.getElementById("top-schedules").innerHTML = data;
  ajaxifyPagination();
  location.hash = "";
  location.hash = "schedule-top-top";
}

function success_pagination_schedules_top_history(data, status, xhr) {
  document.getElementById("top-schedules").innerHTML = data;
  ajaxifyPagination();
  location.hash = "";
  location.hash = "schedule-top-top";
}

function ctl_location_inputs(conversation_form_face_to_face) {
  selObj = document.getElementById("schedule_conversation_form_id");
  tgtObj = document.getElementById("schedule_location_inputs");

  if(selObj.options[selObj.selectedIndex].value == conversation_form_face_to_face) {
    tgtObj.className = "";
  } else {
    tgtObj.className = "display-none";
    document.getElementById("schedule_location_prefecture_id").selectedIndex = 0;
    document.getElementById("schedule_location_name").value = "";
    document.getElementById("schedule_location_reference_url").value = "";
  }
}

function register_schedule(f, error_message, status_invalid_parameters) {
  $.ajax({
    url: $(f).attr("action")
  , type: "POST"
  , dataType: "html"
  , timeout: 10000
  , data: $(f).serialize()
  , beforeSend: function(){}
  , error: function(XMLHttpRequest, status, errorThrown){alert(error_message);}
  , success: function(data, status, xhr){success_register_schedule(data, status, xhr, status_invalid_parameters);}
  });
}

function success_register_schedule(data, status, xhr, status_invalid_parameters) {
  if(xhr.status == status_invalid_parameters) {
    document.getElementById("register-schedule-inner").innerHTML = data;
  } else {
    document.getElementById("practice-english-conversation-inner").innerHTML = data;
  }
  ajaxifyPagination();
}

function control_display(id) {
  obj = document.getElementById(id);
  if(obj.className == "display-none") {
    obj.className = "";
  } else {
    obj.className = "display-none";
  }
}

function create_guest(schedule_id, error_message, is_top, is_top_history, is_detail) {
  $.ajax({
    url: "/guests"
  , type: "POST"
  , dataType: "html"
  , timeout: 10000
  , data: {id: schedule_id, is_top: is_top, is_top_history: is_top_history, is_detail: is_detail}
  , beforeSend: function(){}
  , error: function(XMLHttpRequest, status, errorThrown){alert(error_message);}
  , success: function(data, status, xhr){success_create_guest(data, status, xhr, schedule_id);}
  });
}

function success_create_guest(data, status, xhr, schedule_id) {
  document.getElementById("schedule-" + schedule_id).innerHTML = data;
  ajaxifyPagination();
}

function approve_guest_request(schedule_id, guest_id, error_message, is_top, is_top_history, is_detail) {
  $.ajax({
    url: "/guests/approve_request"
  , type: "POST"
  , dataType: "html"
  , timeout: 10000
  , data: {id: guest_id, is_top: is_top, is_top_history: is_top_history, is_detail: is_detail}
  , beforeSend: function(){}
  , error: function(XMLHttpRequest, status, errorThrown){alert(error_message);}
  , success: function(data, status, xhr){success_approve_guest_request(data, status, xhr, schedule_id);}
  });
}

function success_approve_guest_request(data, status, xhr, schedule_id) {
  document.getElementById("schedule-" + schedule_id).innerHTML = data;
  ajaxifyPagination();
}

function decline_guest_request(schedule_id, guest_id, error_message, confirm_message, is_top, is_top_history, is_detail) {
  if(!confirm(confirm_message)) {
    return false;
  }

  $.ajax({
    url: "/guests/decline_request"
  , type: "POST"
  , dataType: "html"
  , timeout: 10000
  , data: {id: guest_id, is_top: is_top, is_top_history: is_top_history, is_detail: is_detail}
  , beforeSend: function(){}
  , error: function(XMLHttpRequest, status, errorThrown){alert(error_message);}
  , success: function(data, status, xhr){success_decline_guest_request(data, status, xhr, schedule_id);}
  });
}

function success_decline_guest_request(data, status, xhr, schedule_id) {
  document.getElementById("schedule-" + schedule_id).innerHTML = data;
  ajaxifyPagination();
}

function cancel_guest_request(schedule_id, error_message, confirm_message, is_top, is_top_history) {
  if(!confirm(confirm_message)) {
    return false;
  }

  $.ajax({
    url: "/guests/cancel_request"
  , type: "POST"
  , dataType: "html"
  , timeout: 10000
  , data: {id: schedule_id, is_top: is_top, is_top_history: is_top_history}
  , beforeSend: function(){}
  , error: function(XMLHttpRequest, status, errorThrown){alert(error_message);}
  , success: function(data, status, xhr){success_cancel_guest_request(data, status, xhr, schedule_id);}
  });
}

function success_cancel_guest_request(data, status, xhr, schedule_id) {
  document.getElementById("schedule-" + schedule_id).innerHTML = data;
  ajaxifyPagination();
}

function delete_schedule(schedule_id, error_message, confirm_message) {
  if(!confirm(confirm_message)) {
    return false;
  }

  $.ajax({
    url: "/schedules/delete_schedule"
  , type: "POST"
  , dataType: "html"
  , timeout: 10000
  , data: {id: schedule_id}
  , beforeSend: function(){}
  , error: function(XMLHttpRequest, status, errorThrown){alert(error_message);}
  , success: function(data, status, xhr){success_delete_schedule(data, status, xhr);}
  });
}

function success_delete_schedule(data, status, xhr) {
  document.getElementById("practice-english-conversation-inner").innerHTML = data;
  ajaxifyPagination();
}

function delete_schedule_top(schedule_id, error_message, confirm_message) {
  if(!confirm(confirm_message)) {
    return false;
  }

  $.ajax({
    url: "/schedules/delete_schedule_top"
  , type: "POST"
  , dataType: "html"
  , timeout: 10000
  , data: {id: schedule_id}
  , beforeSend: function(){}
  , error: function(XMLHttpRequest, status, errorThrown){alert(error_message);}
  , success: function(data, status, xhr){success_delete_schedule_top(data, status, xhr);}
  });
}

function success_delete_schedule_top(data, status, xhr) {
  document.getElementById("top-schedules").innerHTML = data;
  ajaxifyPagination();
  location.hash = "";
  location.hash = "schedule-top-top";
}

function delete_schedule_top_history(schedule_id, error_message, confirm_message) {
  if(!confirm(confirm_message)) {
    return false;
  }

  $.ajax({
    url: "/schedules/delete_schedule_top_history"
  , type: "POST"
  , dataType: "html"
  , timeout: 10000
  , data: {id: schedule_id}
  , beforeSend: function(){}
  , error: function(XMLHttpRequest, status, errorThrown){alert(error_message);}
  , success: function(data, status, xhr){success_delete_schedule_top_history(data, status, xhr);}
  });
}

function success_delete_schedule_top_history(data, status, xhr) {
  document.getElementById("top-schedules").innerHTML = data;
  ajaxifyPagination();
  location.hash = "";
  location.hash = "schedule-top-top";
}

function register_comment(f, error_message, status_invalid_parameters) {
  $.ajax({
    url: $(f).attr("action")
  , type: "POST"
  , dataType: "html"
  , timeout: 10000
  , data: $(f).serialize()
  , beforeSend: function(){}
  , error: function(XMLHttpRequest, status, errorThrown){alert(error_message);}
  , success: function(data, status, xhr){success_register_comment(data, status, xhr, status_invalid_parameters);}
  });
}

function success_register_comment(data, status, xhr, status_invalid_parameters) {
  if(xhr.status == status_invalid_parameters) {
    document.getElementById("register-comment").innerHTML = data;
  } else {
    document.getElementById("comments-top").innerHTML = data;
  }
  ajaxifyPagination();
}

function register_schedule_comment(f, error_message, status_invalid_parameters) {
  $.ajax({
    url: $(f).attr("action")
  , type: "POST"
  , dataType: "html"
  , timeout: 10000
  , data: $(f).serialize()
  , beforeSend: function(){}
  , error: function(XMLHttpRequest, status, errorThrown){alert(error_message);}
  , success: function(data, status, xhr){success_register_schedule_comment(data, status, xhr, status_invalid_parameters);}
  });
}

function success_register_schedule_comment(data, status, xhr, status_invalid_parameters) {
  if(xhr.status == status_invalid_parameters) {
    document.getElementById("register-schedule-comment-body").innerHTML = data;
  } else {
    document.getElementById("schedule-comment-top").innerHTML = data;
  }
  ajaxifyPagination();
}

function delete_comment(comment_id, error_message, confirm_message) {
  if(!confirm(confirm_message)) {
    return false;
  }

  $.ajax({
    url: "/comments/delete_comment"
  , type: "POST"
  , dataType: "html"
  , timeout: 10000
  , data: {id: comment_id}
  , beforeSend: function(){}
  , error: function(XMLHttpRequest, status, errorThrown){alert(error_message);}
  , success: function(data, status, xhr){success_delete_comment(data, status, xhr);}
  });
}

function success_delete_comment(data, status, xhr) {
  document.getElementById("comments").innerHTML = data;
  ajaxifyPagination();
}

function delete_schedule_comment(schedule_comment_id, error_message, confirm_message) {
  if(!confirm(confirm_message)) {
    return false;
  }

  $.ajax({
    url: "/schedule_comments/delete_schedule_comment"
  , type: "POST"
  , dataType: "html"
  , timeout: 10000
  , data: {id: schedule_comment_id}
  , beforeSend: function(){}
  , error: function(XMLHttpRequest, status, errorThrown){alert(error_message);}
  , success: function(data, status, xhr){success_delete_schedule_comment(data, status, xhr);}
  });
}

function success_delete_schedule_comment(data, status, xhr) {
  document.getElementById("schedule-comments").innerHTML = data;
  ajaxifyPagination();
}

function register_comment_child(f, comment_id, error_message, status_invalid_parameters) {
  $.ajax({
    url: "/comments/register_comment_child"
  , type: "POST"
  , dataType: "html"
  , timeout: 10000
  , data: $(f).serialize()
  , beforeSend: function(){}
  , error: function(XMLHttpRequest, status, errorThrown){alert(error_message);}
  , success: function(data, status, xhr){success_register_comment_child(data, status, xhr, status_invalid_parameters, comment_id);}
  });
}

function success_register_comment_child(data, status, xhr, status_invalid_parameters, comment_id) {
  if(xhr.status == status_invalid_parameters) {
    document.getElementById("register-comment-child").innerHTML = data;
  } else {
    document.getElementById("comment" + comment_id).innerHTML = data;
  }
  ajaxifyPagination();
}

function delete_comment_child(comment_id, error_message, confirm_message, parent_comment_id) {
  if(!confirm(confirm_message)) {
    return false;
  }

  $.ajax({
    url: "/comments/delete_comment_child"
  , type: "POST"
  , dataType: "html"
  , timeout: 10000
  , data: {id: comment_id}
  , beforeSend: function(){}
  , error: function(XMLHttpRequest, status, errorThrown){alert(error_message);}
  , success: function(data, status, xhr){success_delete_comment_child(data, status, xhr, parent_comment_id);}
  });
}

function success_delete_comment_child(data, status, xhr, parent_comment_id) {
  document.getElementById("comment" + parent_comment_id).innerHTML = data;
  ajaxifyPagination();
}
